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
    var leagueTableView: LeagueTableView?
    @IBOutlet var menu: NSMenu?
    @IBOutlet var firstMenuItem: NSMenuItem?


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        statusBarItem = NSStatusBar.system.statusItem(withLength: -1)

        // Ensure that the system gave us back am item
        guard let button = statusBarItem?.button else {
            os_log(.error, "System did not return us a button to use")
            NSApp.terminate(nil)
            return
        }

        button.image = NSImage(named: "Menu Bar")

        if let menu = menu {
            statusBarItem?.menu = menu
        }

        if let firstMenuItem = firstMenuItem {
            leagueTableView = LeagueTableView(frame: .init(origin: .zero, size: .init(width: 250.0, height: 400.0)))
            firstMenuItem.view = leagueTableView
            leagueTableView?.setup()
        }
        
    }

}

