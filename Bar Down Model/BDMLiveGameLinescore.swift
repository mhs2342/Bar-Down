//
//  BDMLiveGameLinescore.swift
//  Bar Down Model
//
//  Created by Matthew Sanford on 12/31/19.
//  Copyright © 2019 sanch. All rights reserved.
//

import Foundation

class BDMLiveGameLinescore: NSObject, Codable, NSSecureCoding {
    static var supportsSecureCoding: Bool { return true }
    let currentPeriod: Int
    let currentPeriodOrdinal, currentPeriodTimeRemaining: String
    let periods: [BDMLiveGameLinescorePeriodSummary]
    let shootoutInfo: BDMLiveGameLinescoreShootoutInfo
    let teams: BDMLiveGameLinescoreTeamWrapper
    let powerPlayStrength: String
    let hasShootout: Bool
    let intermissionInfo: BDMLiveGameLinescoreIntermissionInfo
    let powerPlayInfo: BDMLiveGameLinescorePowerPlayInfo

    init(currentPeriod: Int, currentPeriodOrdinal: String, currentPeriodTimeRemaining: String, periods: [BDMLiveGameLinescorePeriodSummary], shootoutInfo: BDMLiveGameLinescoreShootoutInfo, teams: BDMLiveGameLinescoreTeamWrapper, powerPlayStrength: String, hasShootout: Bool, intermissionInfo: BDMLiveGameLinescoreIntermissionInfo, powerPlayInfo: BDMLiveGameLinescorePowerPlayInfo) {
        self.currentPeriod = currentPeriod
        self.currentPeriodOrdinal = currentPeriodOrdinal
        self.currentPeriodTimeRemaining = currentPeriodTimeRemaining
        self.periods = periods
        self.shootoutInfo = shootoutInfo
        self.teams = teams
        self.powerPlayStrength = powerPlayStrength
        self.hasShootout = hasShootout
        self.intermissionInfo = intermissionInfo
        self.powerPlayInfo = powerPlayInfo
    }

    required convenience init?(coder: NSCoder) {
        let currentPeriod = coder.decodeInteger(forKey: "currentPeriod")
        guard let currentPeriodOrdinal = coder.decodeObject(of: NSString.self, forKey: "currentPeriodOrdinal"),
            let currentPeriodTimeRemaining = coder.decodeObject(of: NSString.self, forKey: "currentPeriodTimeRemaining"),
            let periods = coder.decodeObject(of: [BDMLiveGameLinescorePeriodSummary.self], forKey: "periods") as? [BDMLiveGameLinescorePeriodSummary],
            let shootoutInfo = coder.decodeObject(of: BDMLiveGameLinescoreShootoutInfo.self, forKey: "shootoutInfo"),
            let teams = coder.decodeObject(of: BDMLiveGameLinescoreTeamWrapper.self, forKey: "teams"),
            let powerPlayStrength = coder.decodeObject(of: NSString.self, forKey: "powerPlayStrength"),
            let intermissionInfo = coder.decodeObject(of: BDMLiveGameLinescoreIntermissionInfo.self, forKey: "intermissionInfo"),
            let powerPlayInfo = coder.decodeObject(of: BDMLiveGameLinescorePowerPlayInfo.self, forKey: "powerPlayInfo") else {
                return nil
        }
        let hasShootout = coder.decodeBool(forKey: "hasShootout")
        self.init(currentPeriod: currentPeriod,
                  currentPeriodOrdinal: currentPeriodOrdinal as String,
                  currentPeriodTimeRemaining: currentPeriodTimeRemaining as String,
                  periods: periods,
                  shootoutInfo: shootoutInfo,
                  teams: teams,
                  powerPlayStrength: powerPlayStrength as String,
                  hasShootout: hasShootout,
                  intermissionInfo: intermissionInfo,
                  powerPlayInfo: powerPlayInfo)
    }

    func encode(with coder: NSCoder) {
        coder.encode(self.currentPeriod, forKey: "currentPeriod")
        coder.encode(self.currentPeriodOrdinal, forKey: "currentPeriodOrdinal")
        coder.encode(self.currentPeriodTimeRemaining, forKey: "currentPeriodTimeRemaining")
        coder.encode(self.periods, forKey: "periods")
        coder.encode(self.shootoutInfo, forKey: "shootoutInfo")
        coder.encode(self.teams, forKey: "teams")
        coder.encode(self.powerPlayStrength, forKey: "powerPlayStrength")
        coder.encode(self.intermissionInfo, forKey: "intermissionInfo")
        coder.encode(self.powerPlayInfo, forKey: "powerPlayInfo")
        coder.encode(self.hasShootout, forKey: "hasShootout")
    }
}

class BDMLiveGameLinescorePeriodSummary: NSObject, Codable, NSSecureCoding {
    static var supportsSecureCoding: Bool { return true }
    let periodType, ordinalNum: String
    let startTime, endTime: Date
    let num: Int


    init(periodType: String, ordinalNum: String, startTime: Date, endTime: Date, num: Int) {
        self.periodType = periodType
        self.ordinalNum = ordinalNum
        self.startTime = startTime
        self.endTime = endTime
        self.num = num
    }

    required convenience init?(coder: NSCoder) {
        let num = coder.decodeInteger(forKey: "num")
        guard let periodType = coder.decodeObject(of: NSString.self, forKey: "periodType"),
            let ordinalNum = coder.decodeObject(of: NSString.self, forKey: "ordinalNum"),
            let startTime = coder.decodeObject(of: NSDate.self, forKey: "startTime"),
            let endTime = coder.decodeObject(of: NSDate.self, forKey: "endTime") else {
                return nil
        }

        self.init(periodType: periodType as String,
                  ordinalNum: ordinalNum as String,
                  startTime: startTime as Date,
                  endTime: endTime as Date,
                  num: num)
    }

    func encode(with coder: NSCoder) {
        coder.encode(self.num, forKey: "num")
        coder.encode(self.periodType, forKey: "periodType")
        coder.encode(self.ordinalNum, forKey: "ordinalNum")
        coder.encode(self.startTime, forKey: "startTime")
        coder.encode(self.endTime, forKey: "endTime")
    }
}

class BDMLiveGameLinescorePeriodSummaryTeamStats: NSObject, Codable, NSSecureCoding {
    static var supportsSecureCoding: Bool { return true }
    let goals: Int
    let shotsOnGoal: Int
    let rinkSide: String

    init(goals: Int, shotsOnGoal: Int, rinkSide: String) {
        self.goals = goals
        self.shotsOnGoal = shotsOnGoal
        self.rinkSide = rinkSide
    }

    required convenience init?(coder: NSCoder) {
        let goals = coder.decodeInteger(forKey: "goals")
        let shotsOnGoal = coder.decodeInteger(forKey: "shotsOnGoal")
        guard let rinkSide = coder.decodeObject(of: NSString.self, forKey: "rinkSide") else {
             return nil
        }

        self.init(goals: goals,
                  shotsOnGoal: shotsOnGoal,
                  rinkSide: rinkSide as String)
    }

    func encode(with coder: NSCoder) {
        coder.encode(self.goals, forKey: "goals")
        coder.encode(self.shotsOnGoal, forKey: "shotsOnGoals")
        coder.encode(self.rinkSide, forKey: "rinkSide")
    }
}

class BDMLiveGameLinescoreShootoutInfo: NSObject, Codable, NSSecureCoding {
    static var supportsSecureCoding: Bool { return true }
    let home, away: BDMLiveGameLinescoreShootoutInfoTeamStats

    init(home: BDMLiveGameLinescoreShootoutInfoTeamStats, away: BDMLiveGameLinescoreShootoutInfoTeamStats) {
        self.home = home
        self.away = away
    }
    required convenience init?(coder: NSCoder) {
        guard let home = coder.decodeObject(of: BDMLiveGameLinescoreShootoutInfoTeamStats.self, forKey: "home"),
            let away = coder.decodeObject(of: BDMLiveGameLinescoreShootoutInfoTeamStats.self, forKey: "away") else {
                return nil
        }
        self.init(home: home, away: away)
    }

    func encode(with coder: NSCoder) {
        coder.encode(self.home, forKey: "home")
        coder.encode(self.away, forKey: "away")
    }
}

class BDMLiveGameLinescoreShootoutInfoTeamStats: NSObject, Codable, NSSecureCoding {
    static var supportsSecureCoding: Bool { return true }
    let scores, attempts: Int

    init(scores: Int, attempts: Int) {
        self.scores = scores
        self.attempts = attempts
    }

    required convenience init?(coder: NSCoder) {
        let scores = coder.decodeInteger(forKey: "scores")
        let attempts = coder.decodeInteger(forKey: "attempts")
        self.init(scores: scores,
                  attempts: attempts)
    }

    func encode(with coder: NSCoder) {
        coder.encode(self.scores, forKey: "scores")
        coder.encode(self.attempts, forKey: "attempts")
    }
}

class BDMLiveGameLinescoreTeamWrapper: NSObject, Codable, NSSecureCoding {
    static var supportsSecureCoding: Bool { return true }
    let home, away: BDMLiveGameLinescoreTeamInfo

    init(home: BDMLiveGameLinescoreTeamInfo, away: BDMLiveGameLinescoreTeamInfo) {
        self.home = home
        self.away = away
    }

    required convenience init?(coder: NSCoder) {
        guard let home = coder.decodeObject(of: BDMLiveGameLinescoreTeamInfo.self, forKey: "home"),
            let away = coder.decodeObject(of: BDMLiveGameLinescoreTeamInfo.self, forKey: "away") else {
                return nil
        }

        self.init(home: home, away: away)
    }

    func encode(with coder: NSCoder) {
        coder.encode(self.home, forKey: "home")
        coder.encode(self.away, forKey: "away")
    }
}

class BDMLiveGameLinescoreTeamInfo: NSObject, Codable, NSSecureCoding {
    static var supportsSecureCoding: Bool { return true }
    var goals: Int
    var shotsOnGoal: Int
    var goaliePulled: Bool
    var numSkaters: Int
    var powerPlay: Bool
    var team: BDMLiveGameEventTeam

    init(goals: Int, shotsOnGoal: Int, goaliePulled: Bool, numSkaters: Int, powerPlay: Bool, team: BDMLiveGameEventTeam) {
        self.goals = goals
        self.shotsOnGoal = shotsOnGoal
        self.goaliePulled = goaliePulled
        self.numSkaters = numSkaters
        self.powerPlay = powerPlay
        self.team = team
    }

    required convenience init?(coder: NSCoder) {
        let goals = coder.decodeInteger(forKey: "goals")
        let shotsOnGoal = coder.decodeInteger(forKey: "shotsOnGoal")
        let goaliePulled = coder.decodeBool(forKey: "goaliePulled")
        let numSkaters = coder.decodeInteger(forKey: "numSkaters")
        let powerPlay = coder.decodeBool(forKey: "powerPlay")
        guard let team = coder.decodeObject(of: BDMLiveGameEventTeam.self, forKey: "team") else { return nil }
        self.init(goals: goals,
                  shotsOnGoal: shotsOnGoal,
                  goaliePulled: goaliePulled,
                  numSkaters: numSkaters,
                  powerPlay: powerPlay,
                  team: team)
    }

    func encode(with coder: NSCoder) {
        coder.encode(self.goals, forKey: "goals")
        coder.encode(self.shotsOnGoal, forKey: "shotsOnGoal")
        coder.encode(self.goaliePulled, forKey: "goaliePulled")
        coder.encode(self.numSkaters, forKey: "numSkaters")
        coder.encode(self.powerPlay, forKey: "powerPlay")
        coder.encode(self.team, forKey: "team")
    }
}

class BDMLiveGameLinescoreSegmentInfo: NSObject, Codable, NSSecureCoding {
    static var supportsSecureCoding: Bool { return true }
    var timeRemaining: Int
    var timeElapsed: Int
    var inProgress: Bool

    init(timeRemaining: Int, timeElapsed: Int, inProgress: Bool) {
        self.timeRemaining = timeRemaining
        self.timeElapsed = timeElapsed
        self.inProgress = inProgress
    }

    required convenience init?(coder: NSCoder) {
        let timeRemaining = coder.decodeInteger(forKey: "timeRemaining")
        let timeElapsed = coder.decodeInteger(forKey: "timeElapsed")
        let inProgress = coder.decodeBool(forKey: "inProgress")

        self.init(timeRemaining: timeRemaining,
                  timeElapsed: timeElapsed,
                  inProgress: inProgress)
    }

    func encode(with coder: NSCoder) {
        coder.encode(self.timeRemaining, forKey: "timeRemaining")
        coder.encode(self.timeElapsed, forKey: "timeElapsed")
        coder.encode(self.inProgress, forKey: "inProgress")
    }
}

class BDMLiveGameLinescoreIntermissionInfo: BDMLiveGameLinescoreSegmentInfo {
    enum CodingKeys: String, CodingKey {
        case timeRemaining = "intermissionTimeRemaining"
        case timeElapsed = "intermissionTimeElapsed"
        case inProgress = "inIntermission"
    }

    required init(from decoder: Decoder) throws {
        super.init(timeRemaining: -1, timeElapsed: -1, inProgress: false)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.timeRemaining = try container.decode(Int.self, forKey: .timeRemaining)
        self.timeElapsed = try container.decode(Int.self, forKey: .timeElapsed)
        self.inProgress = try container.decode(Bool.self, forKey: .inProgress)
    }

    required convenience init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BDMLiveGameLinescorePowerPlayInfo: BDMLiveGameLinescoreSegmentInfo {
    enum CodingKeys: String, CodingKey {
        case timeRemaining = "situationTimeRemaining"
        case timeElapsed = "situationTimeElapsed"
        case inProgress = "inSituation"
    }

    required init(from decoder: Decoder) throws {
        super.init(timeRemaining: -1, timeElapsed: -1, inProgress: false)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        timeRemaining = try container.decode(Int.self, forKey: .timeRemaining)
        timeElapsed = try container.decode(Int.self, forKey: .timeElapsed)
        inProgress = try container.decode(Bool.self, forKey: .inProgress)

    }

    required convenience init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
