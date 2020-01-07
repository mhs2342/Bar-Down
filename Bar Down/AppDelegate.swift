//
//  AppDelegate.swift
//  Bar Down
//
//  Created by Matthew Sanford on 12/25/19.
//  Copyright © 2019 sanch. All rights reserved.
//

import OSLog
import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var statusBarItem: NSStatusItem?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        statusBarItem = NSStatusBar.system.statusItem(withLength: -1)

        // Ensure that the system gave us back am item
        guard let button = statusBarItem?.button else {
            os_log(.error, "System did not return us a button to use")
            NSApp.terminate(nil)
            return
        }

        button.image = NSImage(named: "Menu Bar")

        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

