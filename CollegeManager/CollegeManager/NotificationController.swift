//
//  NotificationController.swift
//  CollegeManager
//
//  Created by Eduardo Quadros on 6/18/15.
//  Copyright (c) 2015 Fernando Lucheti. All rights reserved.
//

class NotificationController: NSObject {

    enum EventType {
        case Assignment
        case Exam
    }

    private let remainingDaysUserInfo = "RemainingDaysReminder"
    private let remainingDaysExamAlertBody = "Você tem uma prova daqui %i dias"
    private let remainingDaysAssignmentAlertBody = "A entrega será em %i dias"
    private let deadlineDateUserInfo = "DeadlineDateReminder"
    private let deadlineExamDateAlertBody = "Você tem uma avaliação hoje!"
    private let deadlineAssignmentDateAlertBody = "Hoje é o dia da entrega!"

    private let defaultTimeToDisplayAlert = 6

    private func daysFromNow(date: NSDate) -> Int {
        let daysFromNowComponent = NSCalendar
            .currentCalendar()
            .components(NSCalendarUnit.CalendarUnitDay, fromDate: NSDate(), toDate: date, options: nil)

        return daysFromNowComponent.day
    }

    private func dateFromNow(numberOfDays : Int) -> NSDate {
        return NSCalendar
            .currentCalendar()
            .dateByAddingUnit(
                NSCalendarUnit.CalendarUnitDay,
                value: numberOfDays,
                toDate: NSDate(),
                options: nil)!
    }

    private func removeLocalNotification(ID : String) {
        let application = UIApplication.sharedApplication()
        var userInfo : [String : String]

        for notification in application.scheduledLocalNotifications as! [UILocalNotification] {
            println(" * \(notification)")
            if ID == (notification.userInfo as! [String : String])["ID"] {
                application.cancelLocalNotification(notification)
            }
        }
    }

    private func setLocalNotification(
        fireDate : NSDate,
        repeatInterval : NSCalendarUnit?,
        alertTitle : String,
        alertBody : String,
        alertAction : String?,
        userInfo : String) {

        let calendar = NSCalendar.currentCalendar()
        let components = NSDateComponents()
        var notification = UILocalNotification()

        components.hour = 6

        notification.fireDate = calendar.dateByAddingComponents(components, toDate: fireDate, options: nil)
        notification.alertBody = alertBody
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.userInfo = ["ID" : userInfo]

        if repeatInterval != nil {
            notification.repeatInterval = repeatInterval!
        }

        if alertAction != nil {
            notification.alertAction = alertAction
        }

        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        println("Notification scheduled for: \(notification.fireDate)")
    }

    private func setDeadlineReminder(name: String, date : NSDate, type : EventType) {
        let alertBody : String

        if type == EventType.Assignment {
            alertBody = deadlineAssignmentDateAlertBody
        } else {
            alertBody = deadlineExamDateAlertBody
        }
        setLocalNotification(date, repeatInterval: nil, alertTitle: name, alertBody: alertBody, alertAction: nil, userInfo: name)
    }

    // MARK: Add and Remove Alerts

    func setReminder(name : String, date : NSDate, type : EventType) {
        let calendar = NSCalendar.currentCalendar()
        let components = NSDateComponents()

        var resultingDate : NSDate
        var comparisonResult : NSComparisonResult
        var alertBody : String

        // Reverse count from the event date by subtracting
        // days and set an alert up after verifying the
        // firedate is happening after today.

        for var index = -1; index > -7; index-- {
            components.day = index
            resultingDate = calendar.dateByAddingComponents(components, toDate: date, options: nil)!
            comparisonResult = calendar.compareDate(resultingDate, toDate: NSDate(), toUnitGranularity: NSCalendarUnit.CalendarUnitDay)

            // Check whether both dates are different.

            if comparisonResult != NSComparisonResult.OrderedSame {
                if type == EventType.Assignment {
                    alertBody = String(format: remainingDaysAssignmentAlertBody, abs(index))
                } else {
                    alertBody = String(format: remainingDaysExamAlertBody, abs(index))
                }
                setLocalNotification(resultingDate, repeatInterval: nil, alertTitle: name, alertBody: alertBody, alertAction: nil, userInfo: name)
            } else {
                break
            }
        }
        setDeadlineReminder(name, date: date, type: type)
    }

    func setReminder(event : Avaliacao) {
        let eventType : EventType

        if event.tipo == 1 {
            eventType = EventType.Assignment
        } else {
            eventType = EventType.Exam
        }
        setReminder(event.nome, date: event.dataEntrega, type: eventType)
    }

    func removeReminder(event : Avaliacao) {
        removeLocalNotification(event.nome)
    }

}
