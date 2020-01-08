//
//  BDMLiveGameBoxScore.swift
//  Bar Down Model
//
//  Created by Matthew Sanford on 1/5/20.
//  Copyright © 2020 sanch. All rights reserved.
//

import Foundation

public class BDMLiveGameBoxScore: NSObject, Codable, NSSecureCoding {
    public static var supportsSecureCoding: Bool { return true }
    public let teams: BDMLiveGameBoxScoreTeams

    init(teams: BDMLiveGameBoxScoreTeams) {
        self.teams = teams
    }

    public required convenience init?(coder: NSCoder) {
        guard let teams = coder.decodeObject(of: BDMLiveGameBoxScoreTeams.self, forKey: "teams") else { return nil }
        self.init(teams: teams)
    }

    public func encode(with coder: NSCoder) {
        coder.encode(self.teams, forKey: "teams")
    }
}

public class BDMLiveGameBoxScoreTeams: NSObject, Codable, NSSecureCoding {
    public static var supportsSecureCoding: Bool { return true }
    public let home: BDMLiveGameBoxScoreOrganization
    public let away: BDMLiveGameBoxScoreOrganization

    init(home: BDMLiveGameBoxScoreOrganization, away: BDMLiveGameBoxScoreOrganization) {
        self.home = home
        self.away = away
    }

    public required convenience init?(coder: NSCoder) {
        guard let home = coder.decodeObject(of: BDMLiveGameBoxScoreOrganization.self, forKey: "home"),
        let away = coder.decodeObject(of: BDMLiveGameBoxScoreOrganization.self, forKey: "away") else { return nil }

        self.init(home: home,
                  away: away)
    }

    public func encode(with coder: NSCoder) {
        coder.encode(self.home, forKey: "home")
        coder.encode(self.away, forKey: "away")
    }
}
