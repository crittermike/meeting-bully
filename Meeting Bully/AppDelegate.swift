//
//  AppDelegate.swift
//  Meeting Bully
//
//  Created by Mike Crittenden on 10/7/19.
//  Copyright © 2019 Mike Crittenden. All rights reserved.
//

import Cocoa
import EventKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var statusBarItem: NSStatusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

    func applicationWillFinishLaunching(_ aNotification: Notification) {
        guard let statusButton = statusBarItem.button else { return }
        statusButton.title = "Meeting Bully"
    }
}
