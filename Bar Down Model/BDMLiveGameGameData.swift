//
//  BDMLiveGameGameData.swift
//  Bar Down Model
//
//  Created by Matthew Sanford on 1/2/20.
//  Copyright © 2020 sanch. All rights reserved.
//

import Foundation

class BDMLiveGameGameData: NSObject, Codable, NSSecureCoding {
    static var supportsSecureCoding: Bool { return true }
    let leagueInfo: BDMLiveGameGameDataLeagueInfo
    let dateInfo: BDMLiveGameGameDataDateInfo
    let status: BDMLiveGameGameDataStatus
    let teams: BDMLiveGameGameDataTeams
    let players: [String: BDMLiveGamePlayer]
    let venue: BDMVenue

    enum CodingKeys: String, CodingKey {
        case leagueInfo = "game"
        case dateInfo = "datetime"
        case status
        case teams
        case players
        case venue
    }

    init(leagueInfo: BDMLiveGameGameDataLeagueInfo, dateInfo: BDMLiveGameGameDataDateInfo, status: BDMLiveGameGameDataStatus, teams: BDMLiveGameGameDataTeams, players: [String : BDMLiveGamePlayer], venue: BDMVenue) {
        self.leagueInfo = leagueInfo
        self.dateInfo = dateInfo
        self.status = status
        self.teams = teams
        self.players = players
        self.venue = venue
    }

    required convenience init?(coder: NSCoder) {
        guard let leagueInfo = coder.decodeObject(of: BDMLiveGameGameDataLeagueInfo.self, forKey: "leagueInfo"),
            let dateInfo = coder.decodeObject(of: BDMLiveGameGameDataDateInfo.self, forKey: "dateInfo"),
            let status = coder.decodeObject(of: BDMLiveGameGameDataStatus.self, forKey: "status"),
            let teams = coder.decodeObject(of: BDMLiveGameGameDataTeams.self, forKey: "teams"),
            let players  = coder.decodeObject(of: NSDictionary.self, forKey: "players") as? [String : BDMLiveGamePlayer],
            let venue = coder.decodeObject(of: BDMVenue.self, forKey: "venue") else {
                return nil
        }

        self.init(leagueInfo: leagueInfo,
                  dateInfo: dateInfo,
                  status: status,
                  teams: teams,
                  players: players,
                  venue: venue)
    }

    func encode(with coder: NSCoder) {
        coder.encode(self.leagueInfo, forKey: "leagueInfo")
        coder.encode(self.dateInfo, forKey: "dateInfo")
        coder.encode(self.status, forKey: "status")
        coder.encode(self.teams, forKey: "teams")
        coder.encode(self.players, forKey: "players")
        coder.encode(self.venue, forKey: "venue")
    }

}

class BDMLiveGameGameDataLeagueInfo: NSObject, Codable, NSSecureCoding {
    init(pk: Int, season: String, type: String) {
        self.pk = pk
        self.season = season
        self.type = type
    }

    required convenience init?(coder: NSCoder) {
        let pk = coder.decodeInteger(forKey: "pk")
        guard let season = coder.decodeObject(of: NSString.self, forKey: "season"),
            let type = coder.decodeObject(of: NSString.self, forKey: "type") else { return nil }
        self.init(pk: pk,
                  season: season as String,
                  type: type as String)
    }

    func encode(with coder: NSCoder) {
        coder.encode(self.pk, forKey: "pk")
        coder.encode(self.season, forKey: "season")
        coder.encode(self.type, forKey: "type")
    }

    static var supportsSecureCoding: Bool { return true }
    let pk: Int
    let season: String
    let type: String
}

class BDMLiveGameGameDataDateInfo: NSObject, Codable, NSSecureCoding {
    static var supportsSecureCoding: Bool { return true }
    let dateTime: Date
    let endDateTime: Date

    init(dateTime: Date, endDateTime: Date) {
        self.dateTime = dateTime
        self.endDateTime = endDateTime
    }

    required convenience init?(coder: NSCoder) {
        guard let dateTime = coder.decodeObject(of: NSDate.self, forKey: "dateTime"),
            let endDateTime = coder.decodeObject(of: NSDate.self, forKey: "endDateTime") else {
                return nil
        }

        self.init(dateTime: dateTime as Date,
                  endDateTime: endDateTime as Date)
    }

    func encode(with coder: NSCoder) {
        coder.encode(self.dateTime, forKey: "dateTime")
        coder.encode(self.endDateTime, forKey: "endDateTime")
    }
}

class BDMLiveGameGameDataStatus: NSObject, Codable, NSSecureCoding {
    static var supportsSecureCoding: Bool { return true }
    let abstractGameState, codedGameState, detailedState, statusCode: String
    let startTimeTBD: Bool

    init(abstractGameState: String, codedGameState: String, detailedState: String, statusCode: String, startTimeTBD: Bool) {
        self.abstractGameState = abstractGameState
        self.codedGameState = codedGameState
        self.detailedState = detailedState
        self.statusCode = statusCode
        self.startTimeTBD = startTimeTBD
    }

    required convenience init?(coder: NSCoder) {
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

    func encode(with coder: NSCoder) {
        coder.encode(self.abstractGameState, forKey: "abstractGameState")
        coder.encode(self.codedGameState, forKey: "codedGameState")
        coder.encode(self.detailedState, forKey: "detailedState")
        coder.encode(self.statusCode, forKey: "statusCode")
        coder.encode(self.startTimeTBD, forKey: "startTimeTBD")
    }
}

class BDMLiveGameGameDataTeams: NSObject, Codable, NSSecureCoding {
    static var supportsSecureCoding: Bool { return true }
    let home, away: BDMLiveGameTeam
    init(home: BDMLiveGameTeam, away: BDMLiveGameTeam) {
        self.home = home
        self.away = away
    }

    required convenience init?(coder: NSCoder) {
        guard let home = coder.decodeObject(of: BDMLiveGameTeam.self, forKey: "home"),
            let away = coder.decodeObject(of: BDMLiveGameTeam.self, forKey: "away") else { return nil }
        self.init(home: home, away: away)
    }

    func encode(with coder: NSCoder) {
        coder.encode(self.home, forKey: "home")
        coder.encode(self.away, forKey: "away")
    }

}


