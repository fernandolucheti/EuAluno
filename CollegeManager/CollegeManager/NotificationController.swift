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

    private let deadlineDateUserInfo = "DeadlineDateReminder"
    private let deadlineExamDateAlertBody = "Você tem uma avaliação hoje!"
    private let deadlineAssignmentDateAlertBody = "Hoje é o dia da entrega!"

    private func daysFromNow(date: NSDate) -> Int {
        let daysFromNowComponent = NSCalendar
            .currentCalendar()
            .components(NSCalendarUnit.CalendarUnitDay, fromDate: NSDate(), toDate: date, options: nil)

        return daysFromNowComponent.day
    }

    private func removeLocalNotification() {}

    private func setLocalNotification(
        fireDate : NSDate,
        repeatInterval : NSCalendarUnit,
        alertTitle : String,
        alertBody : String,
        alertAction : String,
        userInfo : String) {

        var notification = UILocalNotification()

        notification.fireDate = fireDate
        notification.alertBody = alertBody
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.userInfo = [ "ID" : userInfo ]

        if repeatInterval != nil {
            notification.repeatInterval = repeatInterval
        }

        if !alertTitle.isEmpty {
            notification.alertTitle = alertTitle
        }

        if !alertAction.isEmpty {
            notification.alertAction = alertAction
        }

        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }

    private func editLocalNotification() {

    }

    private func setDeadlineReminder(eventName: String, eventDate : NSDate, eventType : EventType) {


        let fireDate = eventDate
        let alertTitle = eventName
        let alertBody : String

        if eventType == EventType.Assignment {
            alertBody = deadlineAssignmentDateAlertBody
        } else {
            alertBody = deadlineExamDateAlertBody
        }

        setLocalNotification(
            eventDate,
            repeatInterval: nil,
            alertTitle: nil,
            alertBody: alertBody,
            alertAction: nil,
            userInfo: deadlineDateUserInfo
        )
    }

    func setReminder(name : String, date : NSDate, type : EventType) {
        var index = daysFromNow(date) - 7

        for index; index < (daysFromNow(date) - 1) ; index++ {

        }

        // Set overdue alert.

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

}
