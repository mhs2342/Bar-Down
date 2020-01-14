//
//  BDMScheduledGames.swift
//  Bar Down Model
//
//  Created by Matthew Sanford on 1/6/20.
//  Copyright © 2020 sanch. All rights reserved.
//

import Foundation

// MARK: - Team
public class BDMScheduledGames: NSObject, Codable, NSSecureCoding {
    public static var supportsSecureCoding: Bool { return true }
    public let copyright: String
    public let totalItems, totalEvents, totalGames, totalMatches, wait: Int
    public let dates: [BDMScheduledGameDate]

    init(copyright: String, totalItems: Int, totalEvents: Int, totalGames: Int, totalMatches: Int, wait: Int, dates: [BDMScheduledGameDate]) {
        self.copyright = copyright
        self.totalItems = totalItems
        self.totalEvents = totalEvents
        self.totalGames = totalGames
        self.totalMatches = totalMatches
        self.wait = wait
        self.dates = dates
    }

    public required convenience init?(coder: NSCoder) {
        let totalItems = coder.decodeInteger(forKey: "totalItems")
        let totalEvents = coder.decodeInteger(forKey: "totalEvents")
        let totalGames = coder.decodeInteger(forKey: "totalGames")
        let totalMatches = coder.decodeInteger(forKey: "totalMatches")
        let wait = coder.decodeInteger(forKey: "wait")
        guard let copyright = coder.decodeObject(of: NSString.self, forKey: "copyright"),
            let dates = coder.decodeObject(of: [NSArray.self, BDMScheduledGameDate.self], forKey: "dates") as? [BDMScheduledGameDate] else {
                return nil
        }
        self.init(copyright: copyright as String,
                  totalItems: totalItems,
                  totalEvents: totalEvents,
                  totalGames: totalGames,
                  totalMatches: totalMatches,
                  wait: wait,
                  dates: dates)
    }

    public func encode(with coder: NSCoder) {
        coder.encode(self.copyright, forKey: "copyright")
        coder.encode(self.totalItems, forKey: "totalItems")
        coder.encode(self.totalEvents, forKey: "totalEvents")
        coder.encode(self.totalGames, forKey: "totalGames")
        coder.encode(self.totalMatches, forKey: "totalMatches")
        coder.encode(self.wait, forKey: "wait")
        coder.encode(self.dates, forKey: "dates")
    }
}

// MARK: - DateElement
public class BDMScheduledGameDate: NSObject, Codable, NSSecureCoding {
    public static var supportsSecureCoding: Bool { return true }
    public let date: String
    public let totalItems, totalEvents, totalGames, totalMatches: Int
    public let games: [BDMScheduledGame]

    init(date: String, totalItems: Int, totalEvents: Int, totalGames: Int, totalMatches: Int, games: [BDMScheduledGame]) {
        self.date = date
        self.totalItems = totalItems
        self.totalEvents = totalEvents
        self.totalGames = totalGames
        self.totalMatches = totalMatches
        self.games = games
    }

    public required convenience init?(coder: NSCoder) {
        let totalItems = coder.decodeInteger(forKey: "totalItems")
        let totalEvents = coder.decodeInteger(forKey: "totalEvents")
        let totalGames = coder.decodeInteger(forKey: "totalGames")
        let totalMatches = coder.decodeInteger(forKey: "totalMatches")
        guard let date = coder.decodeObject(of: NSString.self, forKey: "date"),
            let games = coder.decodeObject(of: [NSArray.self, BDMScheduledGame.self], forKey: "games") as? [BDMScheduledGame] else {
                return nil
        }
        self.init(date: date as String,
                  totalItems: totalItems,
                  totalEvents: totalEvents,
                  totalGames: totalGames,
                  totalMatches: totalMatches,
                  games: games)
    }

    public func encode(with coder: NSCoder) {
        coder.encode(self.date, forKey: "date")
        coder.encode(self.totalItems, forKey: "totalItems")
        coder.encode(self.totalEvents, forKey: "totalEvents")
        coder.encode(self.totalGames, forKey: "totalGames")
        coder.encode(self.totalMatches, forKey: "totalMatches")
        coder.encode(self.games, forKey: "games")
    }
}

// MARK: - Game
public class BDMScheduledGame: NSObject, Codable, NSSecureCoding {
    public static var supportsSecureCoding: Bool { return true }
    public let gamePk: Int
    public let link, gameType, season: String
    public let gameDate: Date
    public let status: BDMScheduledGameStatus
    public let teams: BDMScheduledGameTeams
    public let venue: BDMVenue

    init(gamePk: Int, link: String, gameType: String, season: String, gameDate: Date, status: BDMScheduledGameStatus, teams: BDMScheduledGameTeams, venue: BDMVenue) {
        self.gamePk = gamePk
        self.link = link
        self.gameType = gameType
        self.season = season
        self.gameDate = gameDate
        self.status = status
        self.teams = teams
        self.venue = venue
    }

    public required convenience init?(coder: NSCoder) {
        let gamePk = coder.decodeInteger(forKey: "gamePk")
        guard let link = coder.decodeObject(of: NSString.self, forKey: "link"),
            let gameType = coder.decodeObject(of: NSString.self, forKey: "gameType"),
            let gameDate = coder.decodeObject(of: NSDate.self, forKey: "gameDate"),
            let season = coder.decodeObject(of: NSString.self, forKey: "season"),
            let status = coder.decodeObject(of: BDMScheduledGameStatus.self, forKey: "status"),
            let teams = coder.decodeObject(of: BDMScheduledGameTeams.self, forKey: "teams"),
            let venue = coder.decodeObject(of: BDMVenue.self, forKey: "venue") else { return nil }
        self.init(gamePk: gamePk,
                  link: link as String,
                  gameType: gameType as String,
                  season: season as String,
                  gameDate: gameDate as Date,
                  status: status,
                  teams: teams,
                  venue: venue)
    }
    public func encode(with coder: NSCoder) {
        coder.encode(self.link, forKey: "link")
        coder.encode(self.gameType, forKey: "gameType")
        coder.encode(self.season, forKey: "season")
        coder.encode(self.gameDate, forKey: "gameDate")
        coder.encode(self.status, forKey: "status")
        coder.encode(self.teams, forKey: "teams")
        coder.encode(self.venue, forKey: "venue")
    }
}

// MARK: - Status
public class BDMScheduledGameStatus: NSObject, Codable, NSSecureCoding {
    public static var supportsSecureCoding: Bool { return true }
    public let abstractGameState, codedGameState, detailedState, statusCode: String
    public let startTimeTBD: Bool

    init(abstractGameState: String, codedGameState: String, detailedState: String, statusCode: String, startTimeTBD: Bool) {
        self.abstractGameState = abstractGameState
        self.codedGameState = codedGameState
        self.detailedState = detailedState
        self.statusCode = statusCode
        self.startTimeTBD = startTimeTBD
    }

    public required convenience init?(coder: NSCoder) {
        guard let abstractGameState = coder.decodeObject(of: NSString.self, forKey: "abstractGameState"),
            let codedGameState = coder.decodeObject(of: NSString.self, forKey: "codedGameState"),
            let detailedState = coder.decodeObject(of: NSString.self, forKey: "detailedState"),
            let statusCode = coder.decodeObject(of: NSString.self, forKey: "statusCode") else {
                return nil
        }
        let startTimeTBD = coder.decodeBool(forKey: "startTimeTBD")
        self.init(abstractGameState: abstractGameState as String,
                  codedGameState: codedGameState as String,
                  detailedState: detailedState as String,
                  statusCode: statusCode as String,
                  startTimeTBD: startTimeTBD)
    }

    public func encode(with coder: NSCoder) {
        coder.encode(self.abstractGameState, forKey:"abstractGameState")
        coder.encode(self.codedGameState, forKey:"codedGameState")
        coder.encode(self.detailedState, forKey:"detailedState")
        coder.encode(self.statusCode, forKey:"statusCode")
        coder.encode(self.startTimeTBD, forKey:"startTimeTBD")
    }
}

// MARK: - Teams
public class BDMScheduledGameTeams: NSObject, Codable, NSSecureCoding {
    public static var supportsSecureCoding: Bool { return true }
    public let away, home: BDMScheduledGameTeam

    init(away: BDMScheduledGameTeam, home: BDMScheduledGameTeam) {
        self.away = away
        self.home = home
    }

    public required convenience init?(coder: NSCoder) {
        guard let away = coder.decodeObject(of: BDMScheduledGameTeam.self, forKey: "away"),
            let home = coder.decodeObject(of: BDMScheduledGameTeam.self, forKey: "home") else { return nil }
        self.init(away: away, home: home)
    }

    public func encode(with coder: NSCoder) {
        coder.encode(self.home, forKey: "home")
        coder.encode(self.away, forKey: "away")
    }
}

// MARK: - Away
public class BDMScheduledGameTeam: NSObject, Codable, NSSecureCoding {
    public static var supportsSecureCoding: Bool { return true }
    public let leagueRecord: BDMLeagueRecord
    public let score: Int
    public let team: BDMLiteTeam

    init(leagueRecord: BDMLeagueRecord, score: Int, team: BDMLiteTeam) {
        self.leagueRecord = leagueRecord
        self.score = score
        self.team = team
    }

    public required convenience init?(coder: NSCoder) {
        guard let record = coder.decodeObject(of: BDMLeagueRecord.self, forKey: "leagueRecord"),
            let team = coder.decodeObject(of: BDMLiteTeam.self, forKey: "team") else { return nil }
        let score = coder.decodeInteger(forKey: "score")
        self.init(leagueRecord: record, score: score, team: team)
    }

    public func encode(with coder: NSCoder) {
        coder.encode(self.leagueRecord, forKey: "leagueRecord")
        coder.encode(self.score, forKey: "score")
        coder.encode(self.team, forKey: "team")
    }
}

// MARK: - LeagueRecord
public class BDMLeagueRecord: NSObject, Codable, NSSecureCoding {
    public static var supportsSecureCoding: Bool { return true }
    public let wins, losses, ot: Int
    public let type: String
    
    public var overall: String { "\(wins)-\(losses)-\(ot)" }

    init(wins: Int, losses: Int, ot: Int, type: String) {
        self.wins = wins
        self.losses = losses
        self.ot = ot
        self.type = type
    }

    public required convenience init?(coder: NSCoder) {
        let wins = coder.decodeInteger(forKey: "wins")
        let losses = coder.decodeInteger(forKey: "losses")
        let ot = coder.decodeInteger(forKey: "ot")
        guard let type = coder.decodeObject(of: NSString.self, forKey: "type") else { return nil }
        self.init(wins: wins,
                  losses: losses,
                  ot: ot,
                  type: type as String)
    }

    public func encode(with coder: NSCoder) {
        coder.encode(self.wins, forKey: "wins")
        coder.encode(self.losses, forKey: "losses")
        coder.encode(self.ot, forKey: "ot")
        coder.encode(self.type, forKey: "type")
    }
}
