//
//  LeagueTableView.swift
//  Bar Down
//
//  Created by Matthew Sanford on 1/20/20.
//  Copyright © 2020 sanch. All rights reserved.
//

import Cocoa

class LeagueTableView: NSView, LoadableView {

    @IBOutlet var tableView: NSTableView!
    @IBOutlet var getScheduleButton: NSButton!
    @IBOutlet var LoadTeamsButton: NSButton!

    @IBAction func getScheduleClicked(_ sender: Any) {
        tableViewManager.getSchedule()
    }
    @IBAction func loadTeamsClicked(_ sender: Any) {
        tableViewManager.getTeams()
    }

    private var tableViewManager = LeagueTableViewManager()

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)

        load(fromNIBNamed: String(describing: LeagueTableView.self))
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setup() {
        tableViewManager.setup(tableView)
    }
}
