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

private enum CellIdentifiers {
    static let NameCell = NSUserInterfaceItemIdentifier(rawValue: "NameCellID")
    static let TeamCell = NSUserInterfaceItemIdentifier(rawValue: "TeamCellID")
}

class ViewController: NSViewController {

    let connection = NSXPCConnection(serviceName: "com.sanch.Bar-Down-War-Room")

    @IBOutlet var tableView: NSTableView!
    var teams = [BDMTeam]()

    override func viewDidLoad() {
        super.viewDidLoad()

        connection.remoteObjectInterface = NSXPCInterface(with: BDWarRoomProtocol.self)
        connection.resume()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NSNib(nibNamed: "TeamCellView", bundle: .main),
                           forIdentifier: CellIdentifiers.TeamCell)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func getScheduleClicked(_ sender: NSButton) {
        NSKeyedUnarchiver.setClass(BDMScheduledGames.self, forClassName: "Bar_Down.BDMScheduledGames")
        NSKeyedUnarchiver.setClass(BDMScheduledGame.self, forClassName: "Bar_Down.BDMScheduledGame")
        NSKeyedUnarchiver.setClass(BDMScheduledGameDate.self, forClassName: "Bar_Down.BDMScheduledGameDate")
        
        if let warRoom = connection.remoteObjectProxy as? BDWarRoomProtocol {
            warRoom.getSchedule(date: Date(), offlineMode: true) { (games, error) in
                if let games = games {
                    print("Success")
                }
            }
        }
    }

    @IBAction func getTeams(_ sender: Any) {
        NSKeyedUnarchiver.setClass(BDMTeam.self, forClassName: "Bar_Down.BDMTeam")
        NSKeyedUnarchiver.setClass(BDMTeams.self, forClassName: "Bar_Down.BDMTeams")
        if let warRoom = connection.remoteObjectProxy as? BDWarRoomProtocol {
            warRoom.getAllTeams(offlineMode: true) { (teams, error) in
                if let teams = teams {
                    self.teams = teams.teams.sorted(by: { $0.name < $1.name })
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
}

extension ViewController: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        // get the data for the row
        let team = teams[row]
        let viewModel = TeamCellViewModel(team)
        // set the column data

        // create the cell
        if tableColumn == tableView.tableColumns[0] {
            let cellIdentifier = CellIdentifiers.TeamCell
            if let cell = tableView.makeView(withIdentifier: cellIdentifier, owner: self) as? TeamCellView {
                cell.setup(viewModel)
                return cell
            }
        }
        // send the cell back
        return nil

    }

    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 120.0
    }
}


extension ViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return teams.count
    }
}

