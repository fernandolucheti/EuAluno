//
//  ViewController.swift
//  Calendar
//
//  Created by Lancy on 01/06/15.
//  Copyright (c) 2015 Lancy. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController, CalendarViewDelegate {
    
    //@IBOutlet var placeholderView: UIView!
    var placeholderView: UIView!
    override func viewDidLoad() {
        
        super.viewDidLoad()

        var backView = UIButton(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width*10, height: self.view.bounds.height*10))
        backView.backgroundColor = UIColor.blackColor()
        backView.alpha = 0.65
        backView.addTarget(self, action: "dismiss", forControlEvents: UIControlEvents.TouchUpInside)
        placeholderView = UIView(frame: CGRect(x: self.view.bounds.width / 8, y: self.view.bounds.height / 4, width: 315, height: 315))
        placeholderView.center = self.view.center
        self.view.addSubview(backView)
        self.view.addSubview(placeholderView)
        //self.view.backgroundColor = UIColor.clearColor()
        // todays date.
        let date = NSDate()
        
        // create an instance of calendar view with 
        // base date (Calendar shows 12 months range from current base date)
        // selected date (marked dated in the calendar)
        let calendarView = CalendarView.instance(date, selectedDate: date)
        calendarView.delegate = self
        calendarView.setTranslatesAutoresizingMaskIntoConstraints(false)
        placeholderView.addSubview(calendarView)
        
        // Constraints for calendar view - Fill the parent view.
        placeholderView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[calendarView]|", options: NSLayoutFormatOptions(0), metrics: nil, views: ["calendarView": calendarView]))
        placeholderView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[calendarView]|", options: NSLayoutFormatOptions(0), metrics: nil, views: ["calendarView": calendarView]))
    }
    func dismiss(){
            self.dismissViewControllerAnimated(true, completion: nil)
    }
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {

        placeholderView.center = view.center
    }
    func didSelectDate(date: NSDate) {
        
        println("\(date.year)-\(date.month)-\(date.day)")
    }
}

