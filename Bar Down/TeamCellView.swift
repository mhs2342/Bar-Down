//
//  TeamCellView.swift
//  Bar Down
//
//  Created by Matthew Sanford on 1/14/20.
//  Copyright © 2020 sanch. All rights reserved.
//

import Cocoa
import Bar_Down_Model
class TeamCellView: NSTableCellView {

    @IBOutlet var teamLogoView: NSImageView!
    @IBOutlet var teamNameField: NSTextField!
    @IBOutlet var teamRecordLabel: NSTextField!
    @IBOutlet var favoriteButton: NSButton!

    func setup(_ viewModel: TeamCellViewModel) {
        teamNameField.stringValue = viewModel.name
        teamRecordLabel.stringValue = viewModel.record
        teamLogoView.image = loadTeamLogo(with: viewModel.teamId)
    }

    private func loadTeamLogo(with Id: Int) -> NSImage? {
        return NSImage(named: "team-\(Id)")
    }

    @IBAction func favoriteToggled(_ sender: NSButton) {
        print("Enabled: \(sender.isEnabled)")
    }
}

struct TeamCellViewModel {
    let name: String
    let record: String
    let teamId: Int

    init(_ team: BDMTeam) {
        name = team.name
        record = team.record?.leagueRecord.overall ?? "record not available"
        teamId = team.id
    }
}
