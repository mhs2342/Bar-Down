//
//  BDMLiveGameBoxScore.swift
//  Bar Down Model
//
//  Created by Matthew Sanford on 1/5/20.
//  Copyright © 2020 sanch. All rights reserved.
//

import Foundation

class BDMLiveGameBoxScore: NSObject, Codable, NSSecureCoding {
    static var supportsSecureCoding: Bool { return true }
    let teams: BDMLiveGameBoxScoreTeams

    init(teams: BDMLiveGameBoxScoreTeams) {
        self.teams = teams
    }

    required convenience init?(coder: NSCoder) {
        guard let teams = coder.decodeObject(of: BDMLiveGameBoxScoreTeams.self, forKey: "teams") else { return nil }
        self.init(teams: teams)
    }

    func encode(with coder: NSCoder) {
        coder.encode(self.teams, forKey: "teams")
    }
}

class BDMLiveGameBoxScoreTeams: NSObject, Codable, NSSecureCoding {
    static var supportsSecureCoding: Bool { return true }
    let home: BDMLiveGameBoxScoreOrganization
    let away: BDMLiveGameBoxScoreOrganization

    init(home: BDMLiveGameBoxScoreOrganization, away: BDMLiveGameBoxScoreOrganization) {
        self.home = home
        self.away = away
    }

    required convenience init?(coder: NSCoder) {
        guard let home = coder.decodeObject(of: BDMLiveGameBoxScoreOrganization.self, forKey: "home"),
        let away = coder.decodeObject(of: BDMLiveGameBoxScoreOrganization.self, forKey: "away") else { return nil }

        self.init(home: home,
                  away: away)
    }

    func encode(with coder: NSCoder) {
        coder.encode(self.home, forKey: "home")
        coder.encode(self.away, forKey: "away")
    }
}
