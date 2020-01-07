//
//  BDMLiveGameEvent.swift
//  Bar Down Model
//
//  Created by Matthew Sanford on 12/29/19.
//  Copyright © 2019 sanch. All rights reserved.
//

import Foundation

class BDMLiveGameEvent: NSObject, Codable, NSSecureCoding {
    static var supportsSecureCoding: Bool { return true }

    let players: [BDMLiveGameEventPlayerElement]?
    let result: BDMLiveGameEventResult
    let about: BDMLiveGameEventAbout
    let coordinates: BDMLiveGameEventCoordinates?
    let team: BDMLiveGameEventTeam?

    init(players: [BDMLiveGameEventPlayerElement]? = nil, result: BDMLiveGameEventResult, about: BDMLiveGameEventAbout, coordinates: BDMLiveGameEventCoordinates? = nil, team: BDMLiveGameEventTeam? = nil) {
        self.players = players
        self.result = result
        self.about = about
        self.coordinates = coordinates
        self.team = team
    }

    func encode(with coder: NSCoder) {
        coder.encode(self.players, forKey: "eventPlayers")
        coder.encode(self.result, forKey: "eventResult")
        coder.encode(self.about, forKey: "eventAbout")
        coder.encode(self.coordinates, forKey: "eventCoordinates")
        coder.encode(self.team, forKey: "eventTeam")
    }

    required convenience init?(coder: NSCoder) {
        guard let result = coder.decodeObject(of: BDMLiveGameEventResult.self, forKey: "eventResult"),
        let about = coder.decodeObject(of: BDMLiveGameEventAbout.self, forKey: "eventAbout") else {
            return nil
        }

        let players = coder.decodeObject(of: [BDMLiveGameEventPlayerElement.self], forKey: "eventPlayers") as? [BDMLiveGameEventPlayerElement]
        let coordinates = coder.decodeObject(of: BDMLiveGameEventCoordinates.self, forKey: "eventCoordinates")
        let team = coder.decodeObject(of: BDMLiveGameEventTeam.self, forKey: "eventTeam")

        self.init(players: players,
                  result: result,
                  about: about,
                  coordinates: coordinates,
                  team: team)
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        players = try? values.decode([BDMLiveGameEventPlayerElement].self, forKey: .players)
        result = try values.decode(BDMLiveGameEventResult.self, forKey: .result)
        about = try values.decode(BDMLiveGameEventAbout.self, forKey: .about)
        coordinates = try? values.decode(BDMLiveGameEventCoordinates.self, forKey: .coordinates)
        team = try? values.decode(BDMLiveGameEventTeam.self, forKey: .team)
    }
}


// MARK: - About
class BDMLiveGameEventAbout: NSObject, Codable, NSSecureCoding {

    let eventIdx, eventID, period: Int
    let periodType, ordinalNum, periodTime, periodTimeRemaining: String
    let dateTime: Date
    let goals: BDMLiveGameEventGoals

    enum CodingKeys: String, CodingKey {
        case eventIdx
        case eventID = "eventId"
        case period, periodType, ordinalNum, periodTime, periodTimeRemaining, dateTime, goals
    }

    init(eventIdx: Int, eventID: Int, period: Int, periodType: String, ordinalNum: String, periodTime: String, periodTimeRemaining: String, dateTime: Date, goals: BDMLiveGameEventGoals) {
        self.eventIdx = eventIdx
        self.eventID = eventID
        self.period = period
        self.periodType = periodType
        self.ordinalNum = ordinalNum
        self.periodTime = periodTime
        self.periodTimeRemaining = periodTimeRemaining
        self.dateTime = dateTime
        self.goals = goals
    }

    // NSSecureCoding
    static var supportsSecureCoding: Bool { return true }

    func encode(with coder: NSCoder) {
        coder.encode(self.eventIdx, forKey: "eventIdx")
        coder.encode(self.eventID, forKey: "eventID")
        coder.encode(self.period, forKey: "period")
        coder.encode(self.periodType, forKey: "periodType")
        coder.encode(self.ordinalNum, forKey: "ordinalNum")
        coder.encode(self.periodTime, forKey: "periodTime")
        coder.encode(self.periodTimeRemaining, forKey: "periodTimeRemaining")
        coder.encode(self.dateTime, forKey: "dateTime")
        coder.encode(self.goals, forKey: "goals")
    }

    required convenience init?(coder: NSCoder) {
        let eventIdx = coder.decodeInteger(forKey: "eventIdx")
        let eventID = coder.decodeInteger(forKey: "eventID")
        let period = coder.decodeInteger(forKey: "period")
        guard let periodType = coder.decodeObject(of: NSString.self, forKey: "periodType"),
            let ordinalNum = coder.decodeObject(of: NSString.self, forKey: "ordinalNum"),
            let periodTime = coder.decodeObject(of: NSString.self, forKey: "periodTime"),
            let periodTimeRemaining = coder.decodeObject(of: NSString.self, forKey: "periodTimeRemaining"),
            let dateTime = coder.decodeObject(of: NSDate.self, forKey: "dateTime"),
            let goals = coder.decodeObject(of: BDMLiveGameEventGoals.self, forKey: "goals") else {
                return nil
        }

        self.init(eventIdx: eventIdx,
                  eventID: eventID,
                  period: period,
                  periodType: periodType as String,
                  ordinalNum: ordinalNum as String,
                  periodTime: periodTime as String,
                  periodTimeRemaining: periodTimeRemaining as String,
                  dateTime: dateTime as Date,
                  goals: goals)
    }
}

// MARK: - Goals
class BDMLiveGameEventGoals: NSObject, Codable, NSSecureCoding {
    static var supportsSecureCoding: Bool { return true }

    let away, home: Int

    init(away: Int, home: Int) {
        self.away = away
        self.home = home
    }

    func encode(with coder: NSCoder) {
        coder.encode(self.away, forKey: "awayGoals")
        coder.encode(self.home, forKey: "homeGoals")
    }

    required convenience init?(coder: NSCoder) {
        let awayGoals = coder.decodeInteger(forKey: "awayGoals")
        let homegoals = coder.decodeInteger(forKey: "homeGoals")
        self.init(away: awayGoals, home: homegoals)
    }
}

// MARK: - BDMLiveGameEventCoordinates
class BDMLiveGameEventCoordinates: NSObject, Codable, NSSecureCoding {
    static var supportsSecureCoding: Bool { return true }

    let x, y: Int

    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }

    func encode(with coder: NSCoder) {
        coder.encode(self.x, forKey: "xCoordinate")
        coder.encode(self.y, forKey: "yCoordinate")
    }

    required convenience init?(coder: NSCoder) {
        let x = coder.decodeInteger(forKey: "xCoordinate")
        let y = coder.decodeInteger(forKey: "yCoordinate")
        self.init(x: x, y: y)
    }
}

// MARK: - BDMLiveGameEventPlayerElement
class BDMLiveGameEventPlayerElement: NSObject, Codable, NSSecureCoding {
    let player: BDMLiveGameEventPlayer
    let playerType: String

    init(player: BDMLiveGameEventPlayer, playerType: String) {
        self.player = player
        self.playerType = playerType
    }

    // NSSecureCoding
    static var supportsSecureCoding: Bool { return true }

    func encode(with coder: NSCoder) {
        coder.encode(self.player, forKey: "eventPlayer")
        coder.encode(self.playerType, forKey: "playerType")
    }

    required convenience init?(coder: NSCoder) {
        guard let player = coder.decodeObject(of: BDMLiveGameEventPlayer.self, forKey: "eventPlayer"),
            let playerType = coder.decodeObject(of: NSString.self, forKey: "playerType") else {
                return nil
        }
        self.init(player: player,
                  playerType: playerType as String)
    }
}

// MARK: - Player
class BDMLiveGameEventPlayer: NSObject, Codable, NSSecureCoding {
    let id: Int
    let fullName, link: String

    init(id: Int, fullName: String, link: String) {
        self.id = id
        self.fullName = fullName
        self.link = link
    }

    // NSSecureCoding
    static var supportsSecureCoding: Bool { return true }

    func encode(with coder: NSCoder) {
        coder.encode(self.id, forKey: "id")
        coder.encode(self.fullName, forKey: "fullName")
        coder.encode(self.link, forKey: "link")
    }

    required convenience init?(coder: NSCoder) {
        let id = coder.decodeInteger(forKey: "id")
        guard let fullName = coder.decodeObject(of: NSString.self, forKey: "fullName"),
            let link = coder.decodeObject(of: NSString.self, forKey: "link") else {
                return nil
        }
        self.init(id: id,
                  fullName: fullName as String,
                  link: link as String)
    }
}

// MARK: - BDMLiveGameEventResult
class BDMLiveGameEventResult: NSObject, Codable, NSSecureCoding {
    let event, eventCode, eventTypeID, resultDescription: String
    let secondaryType, penaltySeverity: String?
    let penaltyMinutes: Int?
    let strength: BDMLiveGameEventResultStrength?
    let gameWinningGoal, emptyNet: Bool?
    enum CodingKeys: String, CodingKey {
        case event, eventCode
        case eventTypeID = "eventTypeId"
        case resultDescription = "description"
        case secondaryType
        case strength
        case penaltySeverity
        case penaltyMinutes
        case gameWinningGoal
        case emptyNet
    }

    init(event: String, eventCode: String, eventTypeID: String, resultDescription: String, secondaryType: String? = nil, penaltySeverity: String? = nil, penaltyMinutes: Int? = nil, strength: BDMLiveGameEventResultStrength? = nil, gameWinningGoal: Bool? = nil, emptyNet: Bool? = nil) {
        self.event = event
        self.eventCode = eventCode
        self.eventTypeID = eventTypeID
        self.resultDescription = resultDescription
        self.secondaryType = secondaryType
        self.strength = strength
        self.penaltySeverity = penaltySeverity
        self.penaltyMinutes = penaltyMinutes
        self.gameWinningGoal = gameWinningGoal
        self.emptyNet = emptyNet
    }

    // NSSecureCoding
    static var supportsSecureCoding: Bool { return true }

    func encode(with coder: NSCoder) {
        coder.encode(self.event, forKey: "event")
        coder.encode(self.eventCode, forKey: "eventCode")
        coder.encode(self.eventTypeID, forKey: "eventTypeID")
        coder.encode(self.resultDescription, forKey: "resultDescription")
        coder.encode(self.secondaryType, forKey: "secondaryType")
        coder.encode(self.strength, forKey: "strength")
        coder.encode(self.gameWinningGoal, forKey: "gameWinningGoal")
        coder.encode(self.penaltySeverity, forKey: "penaltySeverity")
        coder.encode(self.penaltyMinutes, forKey: "penaltyMinutes")
        coder.encode(self.emptyNet, forKey: "emptyNet")
    }

    required convenience init?(coder: NSCoder) {
        guard let event = coder.decodeObject(of: NSString.self, forKey: "event"),
            let eventCode = coder.decodeObject(of: NSString.self, forKey: "eventCode"),
            let eventTypeID = coder.decodeObject(of: NSString.self, forKey: "eventTypeID"),
            let resultDescription = coder.decodeObject(of: NSString.self, forKey: "resultDescription") else {
                return nil
        }
        let secondaryType = coder.decodeObject(of: NSString.self, forKey: "secondaryType")
        let strength = coder.decodeObject(of: BDMLiveGameEventResultStrength.self, forKey: "strength")
        let penaltySeverity = coder.decodeObject(of: NSString.self, forKey: "penaltySeverity")
        let penaltyMinutes = coder.containsValue(forKey: "penaltyMinutes") ? coder.decodeInteger(forKey: "penaltyMinutes") : nil
        let gameWinningGoal = coder.containsValue(forKey: "gameWinningGoal") ? coder.decodeBool(forKey: "gameWinningGoal") : nil

        let emptyNet = coder.containsValue(forKey: "emptyNet") ? coder.decodeBool(forKey: "emptyNet") : nil

        self.init(event: event as String,
                  eventCode: eventCode as String,
                  eventTypeID: eventTypeID as String,
                  resultDescription: resultDescription as String,
                  secondaryType: secondaryType as String?,
                  penaltySeverity: penaltySeverity as String?,
                  penaltyMinutes: penaltyMinutes,
                  strength: strength,
                  gameWinningGoal: gameWinningGoal,
                  emptyNet: emptyNet)
    }
}

class BDMLiveGameEventResultStrength: NSObject, Codable, NSSecureCoding {
    let code, name: String
    static var supportsSecureCoding: Bool { return true }
    init(code: String, name: String) {
        self.code = code
        self.name = name
    }

    func encode(with coder: NSCoder) {
        coder.encode(self.code, forKey: "code")
        coder.encode(self.name, forKey: "name")
    }

    required convenience init?(coder: NSCoder) {
        guard let code = coder.decodeObject(of: NSString.self, forKey: "code"),
            let name = coder.decodeObject(of: NSString.self, forKey: "name") else {
                return nil
        }

        self.init(code: code as String,
                  name: name as String)
    }
}

// MARK: - BDMLiveGameEventTeam
class BDMLiveGameEventTeam: NSObject, Codable, NSSecureCoding {

    let id: Int
    let name, link, triCode: String
    let abbreviation: String?

    init(id: Int, name: String, link: String, triCode: String, abbreviation: String? = nil) {
        self.id = id
        self.name = name
        self.link = link
        self.triCode = triCode
        self.abbreviation = abbreviation
    }

    // NSSecureCoding
    static var supportsSecureCoding: Bool { return true }

    func encode(with coder: NSCoder) {
        coder.encode(self.id, forKey: "id")
        coder.encode(self.name, forKey: "name")
        coder.encode(self.link, forKey: "link")
        coder.encode(self.triCode, forKey: "triCode")
        coder.encode(self.abbreviation, forKey: "abbreviation")
    }

    required convenience init?(coder: NSCoder) {
        let id = coder.decodeInteger(forKey: "id")
        guard let link = coder.decodeObject(of: NSString.self, forKey: "link"),
            let name = coder.decodeObject(of: NSString.self, forKey: "name"),
            let triCode = coder.decodeObject(of: NSString.self, forKey: "triCode") else {
                return nil
        }
        let abbreviation = coder.decodeObject(of: NSString.self, forKey: "abbreviation")
        self.init(id: id,
                  name: name as String,
                  link: link as String,
                  triCode: triCode as String,
                  abbreviation: abbreviation as String?)
    }
}
