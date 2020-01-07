//
//  BDTeamDTO.swift
//  Bar Down Model
//
//  Created by Matthew Sanford on 12/27/19.
//  Copyright © 2019 sanch. All rights reserved.
//

import Foundation

// MARK: - BDMTeamDTO
class BDMTeamDTO:  NSObject, Codable, NSSecureCoding {
    func encode(with coder: NSCoder) {
        coder.encode(self.copyright, forKey: "copyright")
        coder.encode(self.teams, forKey: "teams")
    }

    required convenience init?(coder: NSCoder) {
        guard let copyright = coder.decodeObject(of: NSString.self, forKey: "copyright"),
            let teams = coder.decodeObject(of: [BDMTeam.self], forKey: "teams") as? [BDMTeam] else { return nil }

        self.init(copyright: copyright as String,
                  teams: teams)
    }

   static var supportsSecureCoding: Bool { return true }

    let copyright: String
    let teams: [BDMTeam]

    init(copyright: String, teams: [BDMTeam]) {
        self.copyright = copyright
        self.teams = teams
    }
}
