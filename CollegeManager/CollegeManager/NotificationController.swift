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

    private func setDeadlineReminder(eventName: String, eventDate : NSDate, eventType : EventType) {
        let fireDate = eventDate
        let alertTitle = eventName
        let alertBody : String

        if eventType == EventType.Assignment {
            alertBody = deadlineAssignmentDateAlertBody
        } else {
            alertBody = deadlineExamDateAlertBody
        }

//        setLocalNotification(
//            eventDate,
//            repeatInterval: nil,
//            alertTitle: alertTitle,
//            alertBody: alertBody,
//            alertAction: nil,
//            userInfo: deadlineDateUserInfo
//        )
    }

    func setReminder(name : String, date : NSDate, type : EventType) {}

    func setReminder(event : Avaliacao) {
        let eventName = event.nome
        let eventDate = event.dataEntrega // event.dataEntrega
        let eventType : EventType

        if event.tipo == 1 {
            eventType = EventType.Assignment
        } else {
            eventType = EventType.Exam
        }

        setReminder(eventName, date: eventDate, type: eventType)
    }
   
}
