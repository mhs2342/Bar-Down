//
//  ViewController.swift
//  Bar Down
//
//  Created by Matthew Sanford on 12/25/19.
//  Copyright © 2019 sanch. All rights reserved.
//
import Bar_Down_Model
import Bar_Down_War_Room
import Cocoa

class ViewController: NSViewController {
    @IBOutlet var tableView: NSTableView!
    var teams = [BDMTeam]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func getScheduleClicked(_ sender: NSButton) {

    }

    @IBAction func getTeams(_ sender: Any) {

    }
}
