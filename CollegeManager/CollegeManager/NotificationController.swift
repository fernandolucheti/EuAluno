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

    private func removeLocalNotification(ID : NSManagedObjectID) {
        let application = UIApplication.sharedApplication()
        var reminder : UILocalNotification
        var userInfo : [String : AnyObject]

        for notification in application.scheduledLocalNotifications {
            reminder = notification as! UILocalNotification
            userInfo = reminder.userInfo as! [String : NSManagedObjectID]

            if ID == userInfo["ID"] as! NSManagedObjectID {
                application.cancelLocalNotification(reminder)
                break
            }
        }
    }

    private func setLocalNotification(
        fireDate : NSDate,
        repeatInterval : NSCalendarUnit?,
        alertTitle : String,
        alertBody : String,
        alertAction : String?,
        userInfo : NSManagedObjectID) {

        var notification = UILocalNotification()

        notification.fireDate = fireDate
        notification.alertBody = alertBody
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.userInfo = [ "ID" : userInfo ]

        if repeatInterval != nil {
            notification.repeatInterval = repeatInterval!
        }

        if !alertTitle.isEmpty {
            notification.alertTitle = alertTitle
        }

        if !alertAction!.isEmpty {
            notification.alertAction = alertAction
        }

        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }

    private func setDeadlineReminder(name: String, date : NSDate, type : EventType, ID : NSManagedObjectID) {

        // Set a reminder for the event day.

        let alertBody : String

        if type == EventType.Assignment {
            alertBody = deadlineAssignmentDateAlertBody
        } else {
            alertBody = deadlineExamDateAlertBody
        }

        setLocalNotification(
            date,
            repeatInterval: nil,
            alertTitle: name,
            alertBody: alertBody,
            alertAction: nil,
            userInfo: ID
        )
    }

    func setReminder(name : String, date : NSDate, type : EventType, ID : NSManagedObjectID) {
        let daysFromToday = daysFromNow(date)
        var day = daysFromToday - 7
        var duration = daysFromToday - 1
        var alertBody : String

        // Set a reminder to trigger everyday seven
        // days prior to the event.

        for day; day < duration ; day++ {

            if type == EventType.Assignment {
                alertBody = String(format: remainingDaysAssignmentAlertBody, day)
            } else {
                alertBody = String(format: remainingDaysExamAlertBody, day)
            }

            setLocalNotification(
                dateFromNow(day),
                repeatInterval: nil,
                alertTitle: name,
                alertBody: alertBody,
                alertAction: nil,
                userInfo: ID
            )
        }

        setDeadlineReminder(name, date: date, type: type, ID: ID)
    }

    func setReminder(event : Avaliacao) {
        let eventType : EventType

        if event.tipo == 1 {
            eventType = EventType.Assignment
        } else {
            eventType = EventType.Exam
        }

        setReminder(event.nome, date: event.dataEntrega, type: eventType, ID: event.objectID)
    }

    func removeReminder(event : Avaliacao) {
        removeLocalNotification(event.objectID)
    }

}
