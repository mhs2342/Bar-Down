//
//  BDMLiveGameBoxScoreOrganization.swift
//  Bar Down Model
//
//  Created by Matthew Sanford on 1/5/20.
//  Copyright © 2020 sanch. All rights reserved.
//

import Foundation

public class BDMLiveGameBoxScoreOrganization: NSObject, Codable, NSSecureCoding {
    public static var supportsSecureCoding: Bool { return true }
    public let team: BDMLiveGameBoxScoreTeam
    public let teamStats: BDMLiveGameBoxScoreTeamStats
    public let players: [String: BDMLiveGameBoxScorePlayer]
    public let goalies: [Int]
    public let skaters: [Int]
    public let onIce: [Int]
    public let scratches: [Int]
    public let penaltyBox: [Int]

    init(team: BDMLiveGameBoxScoreTeam, teamStats: BDMLiveGameBoxScoreTeamStats, players: [String : BDMLiveGameBoxScorePlayer], goalies: [Int], skaters: [Int], onIce: [Int], scratches: [Int], penaltyBox: [Int]) {
        self.team = team
        self.teamStats = teamStats
        self.players = players
        self.goalies = goalies
        self.skaters = skaters
        self.onIce = onIce
        self.scratches = scratches
        self.penaltyBox = penaltyBox
    }

    public required convenience init?(coder: NSCoder) {
        guard let team = coder.decodeObject(of: BDMLiveGameBoxScoreTeam.self, forKey: "team"),
            let teamStats = coder.decodeObject(of: BDMLiveGameBoxScoreTeamStats.self, forKey: "teamStats"),
            let players = coder.decodeObject(of: NSDictionary.self, forKey: "players") as? [String : BDMLiveGameBoxScorePlayer],
            let goalies = coder.decodeObject(of: [NSNumber.self], forKey: "goalies") as? [Int],
            let skaters = coder.decodeObject(of: [NSNumber.self], forKey: "skaters") as? [Int],
            let onIce = coder.decodeObject(of: [NSNumber.self], forKey: "onIce") as? [Int],
            let scratches = coder.decodeObject(of: [NSNumber.self], forKey: "scratches") as? [Int],
            let penaltyBox = coder.decodeObject(of: [NSNumber.self], forKey: "penaltyBox") as? [Int] else {
                return nil
        }

        self.init(team: team,
                  teamStats: teamStats,
                  players: players,
                  goalies: goalies,
                  skaters: skaters,
                  onIce: onIce,
                  scratches: scratches,
                  penaltyBox: penaltyBox)
    }

    public func encode(with coder: NSCoder) {
        coder.encode(self.team, forKey: "team")
        coder.encode(self.teamStats, forKey: "teamStats")
        coder.encode(self.players, forKey: "players")
        coder.encode(self.goalies, forKey: "goalies")
        coder.encode(self.skaters, forKey: "skaters")
        coder.encode(self.onIce, forKey: "onIce")
        coder.encode(self.scratches, forKey: "scratches")
        coder.encode(self.penaltyBox, forKey: "penaltyBox")
    }
}

public class BDMLiveGameBoxScoreTeamStats: NSObject, Codable, NSSecureCoding {
    public static var supportsSecureCoding: Bool { return true }
    public let teamSkaterStats: BDMLiveGameBoxScoreTeamSkaterStats?

    init(teamSkaterStats: BDMLiveGameBoxScoreTeamSkaterStats?) {
        self.teamSkaterStats = teamSkaterStats
    }
    public required convenience init?(coder: NSCoder) {
        let stats = coder.decodeObject(of: BDMLiveGameBoxScoreTeamSkaterStats.self, forKey: "stats")
        self.init(teamSkaterStats: stats)
    }

    public func encode(with coder: NSCoder) {
        coder.encode(self.teamSkaterStats, forKey: "stats")
    }

}


public class BDMLiveGameBoxScoreTeamSkaterStats: NSObject, Codable, NSSecureCoding {
    public static var supportsSecureCoding: Bool { return true }

    public let goals, pim, shots: Int
    public let powerPlayPercentage: String
    public let powerPlayGoals, powerPlayOpportunities: Double
    public let faceOffWinPercentage: String
    public let blocked, takeaways, giveaways, hits: Int

    init(goals: Int, pim: Int, shots: Int, powerPlayPercentage: String, powerPlayGoals: Double, powerPlayOpportunities: Double, faceOffWinPercentage: String, blocked: Int, takeaways: Int, giveaways: Int, hits: Int) {
        self.goals = goals
        self.pim = pim
        self.shots = shots
        self.powerPlayPercentage = powerPlayPercentage
        self.powerPlayGoals = powerPlayGoals
        self.powerPlayOpportunities = powerPlayOpportunities
        self.faceOffWinPercentage = faceOffWinPercentage
        self.blocked = blocked
        self.takeaways = takeaways
        self.giveaways = giveaways
        self.hits = hits
    }

    public required convenience init?(coder: NSCoder) {
        let goals = coder.decodeInteger(forKey: "goals")
        let pim = coder.decodeInteger(forKey: "pim")
        let shots = coder.decodeInteger(forKey: "shots")
        guard let powerPlayPercentage = coder.decodeObject(of: NSString.self, forKey: "powerPlayPercentage"),
            let faceOffWinPercentage = coder.decodeObject(of: NSString.self, forKey: "faceOffWinPercentage") else { return nil }
        let powerPlayGoals = coder.decodeDouble(forKey: "powerPlayGoals")
        let powerPlayOpportunities = coder.decodeDouble(forKey: "powerPlayOpportunities")

        let blocked = coder.decodeInteger(forKey: "blocked")
        let takeaways = coder.decodeInteger(forKey: "takeaways")
        let giveaways = coder.decodeInteger(forKey: "giveaways")
        let hits = coder.decodeInteger(forKey: "hits")

        self.init(goals: goals,
                  pim: pim,
                  shots: shots,
                  powerPlayPercentage: powerPlayPercentage as String,
                  powerPlayGoals: powerPlayGoals,
                  powerPlayOpportunities: powerPlayOpportunities,
                  faceOffWinPercentage: faceOffWinPercentage as String,
                  blocked: blocked,
                  takeaways: takeaways,
                  giveaways: giveaways,
                  hits: hits)
    }

    public func encode(with coder: NSCoder) {
        coder.encode(self.goals, forKey: "goals")
        coder.encode(self.pim, forKey: "pim")
        coder.encode(self.shots, forKey: "shots")
        coder.encode(self.powerPlayPercentage, forKey: "powerPlayPercentage")
        coder.encode(self.powerPlayGoals, forKey: "powerPlayGoals")
        coder.encode(self.powerPlayOpportunities, forKey: "powerPlayOpportunities")
        coder.encode(self.blocked, forKey: "blocked")
        coder.encode(self.takeaways, forKey: "takeaways")
        coder.encode(self.giveaways, forKey: "giveaways")
        coder.encode(self.hits, forKey: "hits")
    }
}

public class BDMLiveGameBoxScoreTeam: NSObject, Codable, NSSecureCoding {
    public static var supportsSecureCoding: Bool { return true }
    public let id: Int
    public let name, link, abbreviation, triCode: String

    init(id: Int, name: String, link: String, abbreviation: String, triCode: String) {
        self.id = id
        self.name = name
        self.link = link
        self.abbreviation = abbreviation
        self.triCode = triCode
    }

    public required convenience init?(coder: NSCoder) {
        let id = coder.decodeInteger(forKey: "id")
        guard let name = coder.decodeObject(of: NSString.self, forKey: "name"),
            let link = coder.decodeObject(of: NSString.self, forKey: "link"),
            let abbreviation = coder.decodeObject(of: NSString.self, forKey: "abbreviation"),
            let triCode = coder.decodeObject(of: NSString.self, forKey: "triCode") else { return nil }

        self.init(id: id,
                  name: name as String,
                  link: link as String,
                  abbreviation: abbreviation as String,
                  triCode: triCode as String)
    }

    public func encode(with coder: NSCoder) {
        coder.encode(self.id, forKey: "id")
        coder.encode(self.name, forKey: "name")
        coder.encode(self.link, forKey: "link")
        coder.encode(self.abbreviation, forKey: "abbreviation")
        coder.encode(self.triCode, forKey: "triCode")
    }
}


public class BDMLiveGameBoxScorePlayer: NSObject, Codable, NSSecureCoding {
    public static var supportsSecureCoding: Bool { return true }
    public let jerseyNumber: String
    public let playerInfo: BDMLiveGameBoxScorePlayerInfo
    public let position: BDMLiveGameBoxScorePlayerPosition
    public let stats: BDMLiveGameBoxScorePlayerStats

    enum CodingKeys: String, CodingKey {
        case jerseyNumber
        case playerInfo = "person"
        case position
        case stats
    }

    public init(jerseyNumber: String, playerInfo: BDMLiveGameBoxScorePlayerInfo, position: BDMLiveGameBoxScorePlayerPosition, stats: BDMLiveGameBoxScorePlayerStats) {
        self.jerseyNumber = jerseyNumber
        self.playerInfo = playerInfo
        self.position = position
        self.stats = stats
    }

    public required convenience init?(coder: NSCoder) {
        guard let jerseyNumber = coder.decodeObject(of: NSString.self, forKey: "jerseyNumber"),
            let playerInfo = coder.decodeObject(of: BDMLiveGameBoxScorePlayerInfo.self, forKey: "playerInfo"),
            let position = coder.decodeObject(of: BDMLiveGameBoxScorePlayerPosition.self, forKey: "position"),
            let stats = coder.decodeObject(of: BDMLiveGameBoxScorePlayerStats.self, forKey: "stats") else {
            return nil
        }
        self.init(jerseyNumber: jerseyNumber as String,
                  playerInfo: playerInfo,
                  position: position,
                  stats: stats)
    }

    public func encode(with coder: NSCoder) {
        coder.encode(self.jerseyNumber, forKey: "jerseyNumber")
        coder.encode(self.playerInfo, forKey: "playerInfo")
        coder.encode(self.position, forKey: "position")
        coder.encode(self.stats, forKey: "stats")
    }
}

public class BDMLiveGameBoxScorePlayerInfo: NSObject, Codable, NSSecureCoding {
    public static var supportsSecureCoding: Bool { return true }
    public let id: Int
    public let fullName, link, shootsCatches, rosterStatus: String

    init(id: Int, fullName: String, link: String, shootsCatches: String, rosterStatus: String) {
        self.id = id
        self.fullName = fullName
        self.link = link
        self.shootsCatches = shootsCatches
        self.rosterStatus = rosterStatus
    }

    public required convenience init?(coder: NSCoder) {
        let id = coder.decodeInteger(forKey: "id")
        guard let fullName = coder.decodeObject(of: NSString.self, forKey: "fullName"),
            let link = coder.decodeObject(of: NSString.self, forKey: "link"),
            let shootsCatches = coder.decodeObject(of: NSString.self, forKey: "shootsCatches"),
            let rosterStatus = coder.decodeObject(of: NSString.self, forKey: "rosterStatus") else { return nil }

        self.init(id: id,
                  fullName: fullName as String,
                  link: link as String,
                  shootsCatches: shootsCatches as String,
                  rosterStatus: rosterStatus as String)
    }

    public func encode(with coder: NSCoder) {
        coder.encode(self.id, forKey: "id")
        coder.encode(self.link, forKey: "link")
        coder.encode(self.shootsCatches, forKey: "shootsCatches")
        coder.encode(self.rosterStatus, forKey: "rosterStatus")
    }
}

public class BDMLiveGameBoxScorePlayerPosition: NSObject, Codable, NSSecureCoding {
    public static var supportsSecureCoding: Bool { return true }
    public let code, name, type, abbreviation: String

    init(code: String, name: String, type: String, abbreviation: String) {
        self.code = code
        self.name = name
        self.type = type
        self.abbreviation = abbreviation
    }

    public required convenience init?(coder: NSCoder) {
        guard let code = coder.decodeObject(of: NSString.self, forKey: "code"),
            let name = coder.decodeObject(of: NSString.self, forKey: "name"),
            let type = coder.decodeObject(of: NSString.self, forKey: "type"),
            let abbreviation = coder.decodeObject(of: NSString.self, forKey: "abbreviation") else  {
                return nil
        }
        self.init(code: code as String,
                  name: name as String,
                  type: type as String,
                  abbreviation: abbreviation as String)
    }

    public func encode(with coder: NSCoder) {
        coder.encode(self.code, forKey: "code")
        coder.encode(self.name, forKey: "name")
        coder.encode(self.type, forKey: "type")
        coder.encode(self.abbreviation, forKey: "abbreviation")
    }
}

public class BDMLiveGameBoxScorePlayerStats: NSObject, Codable, NSSecureCoding {
    public static var supportsSecureCoding: Bool { return true }
    public let skaterStats: BDMLiveGameBoxScorePlayerSkaterStats?
    public let goalieStats: BDMLiveGameBoxScorePlayerGoalieStats?

    init(skaterStats: BDMLiveGameBoxScorePlayerSkaterStats? = nil,
                  goalieStats: BDMLiveGameBoxScorePlayerGoalieStats? = nil) {
        self.skaterStats = skaterStats
        self.goalieStats = goalieStats
    }

    public required convenience init?(coder: NSCoder) {
        let skaterStats = coder.decodeObject(of: BDMLiveGameBoxScorePlayerSkaterStats.self, forKey: "skaterStats")
        let goalieStats = coder.decodeObject(of: BDMLiveGameBoxScorePlayerGoalieStats.self, forKey: "goalieStats")
        self.init(skaterStats: skaterStats,
                  goalieStats: goalieStats)
    }

    public func encode(with coder: NSCoder) {
        coder.encode(self.skaterStats, forKey: "skaterStats")
        coder.encode(self.goalieStats, forKey: "goalieStats")
    }
}

public class BDMLiveGameBoxScorePlayerSkaterStats: NSObject, Codable, NSSecureCoding {
    public static var supportsSecureCoding: Bool { return true }
    public let timeOnIce: String
    public let assists, goals, shots, hits: Int
    public let powerPlayGoals, powerPlayAssists, penaltyMinutes: Int
    public let faceOffPct: Double?
    public let faceOffWins, faceoffTaken, takeaways, giveaways: Int
    public let shortHandedGoals, shortHandedAssists, blocked, plusMinus: Int
    public let evenTimeOnIce, powerPlayTimeOnIce, shortHandedTimeOnIce: String

    init(timeOnIce: String, assists: Int, goals: Int, shots: Int, hits: Int, powerPlayGoals: Int, powerPlayAssists: Int, penaltyMinutes: Int, faceOffPct: Double? = nil, faceOffWins: Int, faceoffTaken: Int, takeaways: Int, giveaways: Int, shortHandedGoals: Int, shortHandedAssists: Int, blocked: Int, plusMinus: Int, evenTimeOnIce: String, powerPlayTimeOnIce: String, shortHandedTimeOnIce: String) {
        self.timeOnIce = timeOnIce
        self.assists = assists
        self.goals = goals
        self.shots = shots
        self.hits = hits
        self.powerPlayGoals = powerPlayGoals
        self.powerPlayAssists = powerPlayAssists
        self.penaltyMinutes = penaltyMinutes
        self.faceOffPct = faceOffPct
        self.faceOffWins = faceOffWins
        self.faceoffTaken = faceoffTaken
        self.takeaways = takeaways
        self.giveaways = giveaways
        self.shortHandedGoals = shortHandedGoals
        self.shortHandedAssists = shortHandedAssists
        self.blocked = blocked
        self.plusMinus = plusMinus
        self.evenTimeOnIce = evenTimeOnIce
        self.powerPlayTimeOnIce = powerPlayTimeOnIce
        self.shortHandedTimeOnIce = shortHandedTimeOnIce
    }

    public required convenience init?(coder: NSCoder) {
        let assists = coder.decodeInteger(forKey: "assists")
        let goals = coder.decodeInteger(forKey: "goals")
        let shots = coder.decodeInteger(forKey: "shots")
        let hits = coder.decodeInteger(forKey: "hits")
        let powerPlayGoals = coder.decodeInteger(forKey: "powerPlayGoals")
        let powerPlayAssists = coder.decodeInteger(forKey: "powerPlayAssists")
        let penaltyMinutes = coder.decodeInteger(forKey: "penaltyMinutes")
        let faceOffPct = coder.containsValue(forKey: "faceOffPct") ? coder.decodeDouble(forKey: "faceOffPct") : nil
        let faceOffWins = coder.decodeInteger(forKey: "faceOffWins")
        let faceoffTaken = coder.decodeInteger(forKey: "faceoffTaken")
        let takeaways = coder.decodeInteger(forKey: "takeaways")
        let giveaways = coder.decodeInteger(forKey: "giveaways")
        let shortHandedGoals = coder.decodeInteger(forKey: "shortHandedGoals")
        let shortHandedAssists = coder.decodeInteger(forKey: "shortHandedAssists")
        let blocked = coder.decodeInteger(forKey: "blocked")
        let plusMinus = coder.decodeInteger(forKey: "plusMinus")
        guard let timeOnIce = coder.decodeObject(of: NSString.self, forKey: "timeOnIce"),
            let evenTimeOnIce = coder.decodeObject(of: NSString.self, forKey: "evenTimeOnIce"),
            let powerPlayTimeOnIce = coder.decodeObject(of: NSString.self, forKey: "powerPlayTimeOnIce"),
            let shortHandedTimeOnIce = coder.decodeObject(of: NSString.self, forKey: "shortHandedTimeOnIce") else {
                return nil
        }

        self.init(timeOnIce: timeOnIce as String,
                  assists: assists,
                  goals: goals,
                  shots: shots,
                  hits: hits,
                  powerPlayGoals: powerPlayGoals,
                  powerPlayAssists: powerPlayAssists,
                  penaltyMinutes: penaltyMinutes,
                  faceOffPct: faceOffPct,
                  faceOffWins: faceOffWins,
                  faceoffTaken: faceoffTaken,
                  takeaways: takeaways,
                  giveaways: giveaways,
                  shortHandedGoals: shortHandedGoals,
                  shortHandedAssists: shortHandedAssists,
                  blocked: blocked,
                  plusMinus: plusMinus,
                  evenTimeOnIce: evenTimeOnIce as String,
                  powerPlayTimeOnIce: powerPlayTimeOnIce as String,
                  shortHandedTimeOnIce: shortHandedTimeOnIce as String)
    }

    public func encode(with coder: NSCoder) {
        coder.encode(self.timeOnIce, forKey: "timeOnIce")
        coder.encode(self.assists, forKey: "assists")
        coder.encode(self.goals, forKey: "goals")
        coder.encode(self.hits, forKey: "hits")
        coder.encode(self.powerPlayGoals, forKey: "powerPlayGoals")
        coder.encode(self.powerPlayAssists, forKey: "powerPlayAssists")
        coder.encode(self.penaltyMinutes, forKey: "penaltyMinutes")
        coder.encode(self.faceOffPct, forKey: "faceOffPct")
        coder.encode(self.faceOffWins, forKey: "faceOffWins")
        coder.encode(self.faceoffTaken, forKey: "faceoffTaken")
        coder.encode(self.takeaways, forKey: "takeaways")
        coder.encode(self.giveaways, forKey: "giveaways")
        coder.encode(self.shortHandedGoals, forKey: "shortHandedGoals")
        coder.encode(self.shortHandedAssists, forKey: "shortHandedAssists")
        coder.encode(self.blocked, forKey: "blocked")
        coder.encode(self.plusMinus, forKey: "plusMinus")
        coder.encode(self.evenTimeOnIce, forKey: "evenTimeOnIce")
        coder.encode(self.powerPlayTimeOnIce, forKey: "powerPlayTimeOnIce")
        coder.encode(self.shortHandedTimeOnIce, forKey: "shortHandedTimeOnIce")
    }
}

public class BDMLiveGameBoxScorePlayerGoalieStats: NSObject, Codable, NSSecureCoding {
    public static var supportsSecureCoding: Bool { return true }
    public let timeOnIce: String
    public let assists, goals, pim, shots: Int
    public let saves, powerPlaySaves, shortHandedSaves, evenSaves: Int
    public let shortHandedShotsAgainst, evenShotsAgainst, powerPlayShotsAgainst: Int
    public let decision: String
    public let savePercentage, powerPlaySavePercentage, shortHandedSavePercentage, evenStrengthSavePercentage: Double

    init(timeOnIce: String, assists: Int, goals: Int, pim: Int, shots: Int, saves: Int, powerPlaySaves: Int, shortHandedSaves: Int, evenSaves: Int, shortHandedShotsAgainst: Int, evenShotsAgainst: Int, powerPlayShotsAgainst: Int, decision: String, savePercentage: Double, powerPlaySavePercentage: Double, shortHandedSavePercentage: Double, evenStrengthSavePercentage: Double) {
        self.timeOnIce = timeOnIce
        self.assists = assists
        self.goals = goals
        self.pim = pim
        self.shots = shots
        self.saves = saves
        self.powerPlaySaves = powerPlaySaves
        self.shortHandedSaves = shortHandedSaves
        self.evenSaves = evenSaves
        self.shortHandedShotsAgainst = shortHandedShotsAgainst
        self.evenShotsAgainst = evenShotsAgainst
        self.powerPlayShotsAgainst = powerPlayShotsAgainst
        self.decision = decision
        self.savePercentage = savePercentage
        self.powerPlaySavePercentage = powerPlaySavePercentage
        self.shortHandedSavePercentage = shortHandedSavePercentage
        self.evenStrengthSavePercentage = evenStrengthSavePercentage
    }

    public required convenience init?(coder: NSCoder) {
        let assists = coder.decodeInteger(forKey: "assists")
        let goals = coder.decodeInteger(forKey: "goals")
        let shots = coder.decodeInteger(forKey: "shots")
        let pim = coder.decodeInteger(forKey: "pim")
        let saves = coder.decodeInteger(forKey: "saves")
        let powerPlaySaves = coder.decodeInteger(forKey: "powerPlaySaves")
        let shortHandedSaves = coder.decodeInteger(forKey: "shortHandedSaves")
        let evenSaves = coder.decodeInteger(forKey: "evenSaves")
        let shortHandedShotsAgainst = coder.decodeInteger(forKey: "shortHandedShotsAgainst")
        let evenShotsAgainst = coder.decodeInteger(forKey: "evenShotsAgainst")
        let powerPlayShotsAgainst = coder.decodeInteger(forKey: "powerPlayShotsAgainst")
        let savePercentage = coder.decodeDouble(forKey: "savePercentage")
        let powerPlaySavePercentage = coder.decodeDouble(forKey: "powerPlaySavePercentage")
        let shortHandedSavePercentage = coder.decodeDouble(forKey: "shortHandedSavePercentage")
        let evenStrengthSavePercentage = coder.decodeDouble(forKey: "evenStrengthSavePercentage")
        guard let timeOnIce = coder.decodeObject(of: NSString.self, forKey: "timeOnIce"),
            let decision = coder.decodeObject(of: NSString.self, forKey: "decision") else {
                return nil
        }

        self.init(timeOnIce: timeOnIce as String,
                  assists: assists,
                  goals: goals,
                  pim: pim,
                  shots: shots,
                  saves: saves,
                  powerPlaySaves: powerPlaySaves,
                  shortHandedSaves: shortHandedSaves,
                  evenSaves: evenSaves,
                  shortHandedShotsAgainst: shortHandedShotsAgainst,
                  evenShotsAgainst: evenShotsAgainst,
                  powerPlayShotsAgainst: powerPlayShotsAgainst,
                  decision: decision as String,
                  savePercentage: savePercentage,
                  powerPlaySavePercentage: powerPlaySavePercentage,
                  shortHandedSavePercentage: shortHandedSavePercentage,
                  evenStrengthSavePercentage: evenStrengthSavePercentage)
    }

    public func encode(with coder: NSCoder) {
        coder.encode(self.timeOnIce, forKey: "timeOnIce")
        coder.encode(self.assists, forKey: "assists")
        coder.encode(self.goals, forKey: "goals")
        coder.encode(self.pim, forKey: "pim")
        coder.encode(self.shots, forKey: "shots")
        coder.encode(self.saves, forKey: "saves")
        coder.encode(self.powerPlaySaves, forKey: "powerPlaySaves")
        coder.encode(self.shortHandedSaves, forKey: "shortHandedSaves")
        coder.encode(self.evenSaves, forKey: "evenSaves")
        coder.encode(self.shortHandedShotsAgainst, forKey: "shortHandedShotsAgainst")
        coder.encode(self.evenShotsAgainst, forKey: "evenShotsAgainst")
        coder.encode(self.powerPlayShotsAgainst, forKey: "powerPlayShotsAgainst")
        coder.encode(self.decision, forKey: "decision")
        coder.encode(self.savePercentage, forKey: "savePercentage")
        coder.encode(self.powerPlaySavePercentage, forKey: "powerPlaySavePercentage")
        coder.encode(self.shortHandedSavePercentage, forKey: "shortHandedSavePercentage")
        coder.encode(self.evenStrengthSavePercentage, forKey: "evenStrengthSavePercentage")
    }
}


