//
//  ViewController.swift
//  Meeting Bully
//
//  Created by Mike Crittenden on 10/7/19.
//  Copyright © 2019 Mike Crittenden. All rights reserved.
//

import Cocoa
import EventKit

class ViewController: NSViewController {
    
    private let eventStore = EKEventStore()

    @IBOutlet weak var titleLabelView: NSTextFieldCell!
    @IBOutlet weak var descriptionLabelView: NSTextFieldCell!
    
    override func viewWillAppear() {
        super.viewWillAppear()
        eventStore.requestAccess(to: .event) { granted, error in
            if granted {
                self.getTodayEvents()
            } else {
                self.descriptionLabelView.stringValue = "Event access denied!"
            }
        }
    }
    
    private func getTodayEvents() {
        DispatchQueue.main.async {
            let calendars = self.eventStore.calendars(for: .event)
            for calendar in calendars {
                // This checking will remove Birthdays and Holidays calendars
                guard calendar.allowsContentModifications else {
                    continue
                }

                let start = Date()
                let end = Date()

                let predicate = self.eventStore.predicateForEvents(withStart: start, end: end, calendars: [calendar])
                let events = self.eventStore.events(matching: predicate)

                for event in events {
                    if !event.isAllDay {
                        self.descriptionLabelView.stringValue.append(event.notes ?? "")
                        self.titleLabelView.stringValue.append(event.title)
                    }
                }
            }
        }
    }
}

