//
//  BDMRecord.swift
//  Bar Down Model
//
//  Created by Matthew Sanford on 1/9/20.
//  Copyright © 2020 sanch. All rights reserved.
//

import Foundation

// MARK: - Record
public class BDMRecord: NSObject, Codable, NSSecureCoding {
    public static var supportsSecureCoding: Bool { return true }
    public let team: BDMLiteTeam
    public let leagueRecord: BDMLeagueRecord
    public let regulationWins, goalsAgainst, goalsScored, points: Int
    public let divisionRank, divisionL10Rank, divisionRoadRank, divisionHomeRank: String
    public let conferenceRank, conferenceL10Rank, conferenceRoadRank, conferenceHomeRank: String
    public let leagueRank, leagueL10Rank, leagueRoadRank, leagueHomeRank: String
    public let wildCardRank: String
    public let row, gamesPlayed: Int
    public let streak: BDMStreak
    public let lastUpdated: Date

    init(team: BDMLiteTeam, leagueRecord: BDMLeagueRecord, regulationWins: Int, goalsAgainst: Int, goalsScored: Int, points: Int, divisionRank: String, divisionL10Rank: String, divisionRoadRank: String, divisionHomeRank: String, conferenceRank: String, conferenceL10Rank: String, conferenceRoadRank: String, conferenceHomeRank: String, leagueRank: String, leagueL10Rank: String, leagueRoadRank: String, leagueHomeRank: String, wildCardRank: String, row: Int, gamesPlayed: Int, streak: BDMStreak, lastUpdated: Date) {
        self.team = team
        self.leagueRecord = leagueRecord
        self.regulationWins = regulationWins
        self.goalsAgainst = goalsAgainst
        self.goalsScored = goalsScored
        self.points = points
        self.divisionRank = divisionRank
        self.divisionL10Rank = divisionL10Rank
        self.divisionRoadRank = divisionRoadRank
        self.divisionHomeRank = divisionHomeRank
        self.conferenceRank = conferenceRank
        self.conferenceL10Rank = conferenceL10Rank
        self.conferenceRoadRank = conferenceRoadRank
        self.conferenceHomeRank = conferenceHomeRank
        self.leagueRank = leagueRank
        self.leagueL10Rank = leagueL10Rank
        self.leagueRoadRank = leagueRoadRank
        self.leagueHomeRank = leagueHomeRank
        self.wildCardRank = wildCardRank
        self.row = row
        self.gamesPlayed = gamesPlayed
        self.streak = streak
        self.lastUpdated = lastUpdated
    }

    public required convenience init?(coder: NSCoder) {
        guard let team = coder.decodeObject(of: BDMLiteTeam.self, forKey: "team"),
            let leagueRecord = coder.decodeObject(of: BDMLeagueRecord.self, forKey: "leagueRecord"),
            let divisionRank = coder.decodeObject(of: NSString.self, forKey: "divisionRank"),
            let divisionL10Rank = coder.decodeObject(of: NSString.self, forKey: "divisionL10Rank"),
            let divisionRoadRank = coder.decodeObject(of: NSString.self, forKey: "divisionRoadRank"),
            let divisionHomeRank = coder.decodeObject(of: NSString.self, forKey: "divisionHomeRank"),
            let conferenceRank = coder.decodeObject(of: NSString.self, forKey: "conferenceRank"),
            let conferenceL10Rank = coder.decodeObject(of: NSString.self, forKey: "conferenceL10Rank"),
            let conferenceRoadRank = coder.decodeObject(of: NSString.self, forKey: "conferenceRoadRank"),
            let conferenceHomeRank = coder.decodeObject(of: NSString.self, forKey: "conferenceHomeRank"),
            let leagueRank = coder.decodeObject(of: NSString.self, forKey: "leagueRank"),
            let leagueL10Rank = coder.decodeObject(of: NSString.self, forKey: "leagueL10Rank"),
            let leagueRoadRank = coder.decodeObject(of: NSString.self, forKey: "leagueRoadRank"),
            let leagueHomeRank = coder.decodeObject(of: NSString.self, forKey: "leagueHomeRank"),
            let wildCardRank = coder.decodeObject(of: NSString.self, forKey: "wildCardRank"),
            let streak = coder.decodeObject(of: BDMStreak.self, forKey: "streak"),
            let lastUpdated = coder.decodeObject(of: NSDate.self, forKey: "lastUpdated")else {
                return nil
        }

        let regulationWins = coder.decodeInteger(forKey: "regulationWins")
        let goalsAgainst = coder.decodeInteger(forKey: "goalsAgainst")
        let goalsScored = coder.decodeInteger(forKey: "goalsScored")
        let points = coder.decodeInteger(forKey: "points")
        let row = coder.decodeInteger(forKey: "row")
        let gamesPlayed = coder.decodeInteger(forKey: "gamesPlayed")

        self.init(
            team: team,
            leagueRecord: leagueRecord,
            regulationWins: regulationWins,
            goalsAgainst: goalsAgainst,
            goalsScored: goalsScored,
            points: points,
            divisionRank: divisionRank as String,
            divisionL10Rank: divisionL10Rank as String,
            divisionRoadRank: divisionRoadRank as String,
            divisionHomeRank: divisionHomeRank as String,
            conferenceRank: conferenceRank as String,
            conferenceL10Rank: conferenceL10Rank as String,
            conferenceRoadRank: conferenceRoadRank as String,
            conferenceHomeRank: conferenceHomeRank as String,
            leagueRank: leagueRank as String,
            leagueL10Rank: leagueL10Rank as String,
            leagueRoadRank: leagueRoadRank as String,
            leagueHomeRank: leagueHomeRank as String,
            wildCardRank: wildCardRank as String,
            row: row,
            gamesPlayed: gamesPlayed,
            streak: streak,
            lastUpdated: lastUpdated as Date
        )
    }

    public func encode(with coder: NSCoder) {
        coder.encode(self.team, forKey: "team")
        coder.encode(self.leagueRecord, forKey: "leagueRecord")
        coder.encode(self.regulationWins, forKey: "regulationWins")
        coder.encode(self.goalsAgainst, forKey: "goalsAgainst")
        coder.encode(self.goalsScored, forKey: "goalsScored")
        coder.encode(self.points, forKey: "points")
        coder.encode(self.divisionRank, forKey: "divisionRank")
        coder.encode(self.divisionL10Rank, forKey: "divisionL10Rank")
        coder.encode(self.divisionRoadRank, forKey: "divisionRoadRank")
        coder.encode(self.divisionHomeRank, forKey: "divisionHomeRank")
        coder.encode(self.conferenceRank, forKey: "conferenceRank")
        coder.encode(self.conferenceL10Rank, forKey: "conferenceL10Rank")
        coder.encode(self.conferenceRoadRank, forKey: "conferenceRoadRank")
        coder.encode(self.conferenceHomeRank, forKey: "conferenceHomeRank")
        coder.encode(self.leagueRank, forKey: "leagueRank")
        coder.encode(self.leagueL10Rank, forKey: "leagueL10Rank")
        coder.encode(self.leagueRoadRank, forKey: "leagueRoadRank")
        coder.encode(self.leagueHomeRank, forKey: "leagueHomeRank")
        coder.encode(self.wildCardRank, forKey: "wildCardRank")
        coder.encode(self.row, forKey: "row")
        coder.encode(self.gamesPlayed, forKey: "gamesPlayed")
        coder.encode(self.streak, forKey: "streak")
        coder.encode(self.lastUpdated, forKey: "lastUpdated")
    }
}

// MARK: - Streak
public class BDMStreak: NSObject, Codable, NSSecureCoding {
    public static var supportsSecureCoding: Bool { return true }
    public let streakType: String
    public let streakNumber: Int
    public let streakCode: String

    init(streakType: String, streakNumber: Int, streakCode: String) {
        self.streakType = streakType
        self.streakNumber = streakNumber
        self.streakCode = streakCode
    }

    public required convenience init?(coder: NSCoder) {
        guard let streakType = coder.decodeObject(of: NSString.self, forKey: "streakType"),
            let streakCode = coder.decodeObject(of: NSString.self, forKey: "streakCode") else {
                return nil
        }
        let streakNumber = coder.decodeInteger(forKey: "streakNumber")
        self.init(streakType: streakType as String,
                  streakNumber: streakNumber,
                  streakCode: streakCode as String)
    }

    public func encode(with coder: NSCoder) {
        coder.encode(self.streakType, forKey: "streakType")
        coder.encode(self.streakNumber, forKey: "streakNumber")
        coder.encode(self.streakCode, forKey: "streakCode")
    }
}
