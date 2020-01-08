//
//  BDMLiveGamePlayer.swift
//  Bar Down Model
//
//  Created by Matthew Sanford on 12/28/19.
//  Copyright © 2019 sanch. All rights reserved.
//

import Foundation

// MARK: - BDMLiveGamePlayer
public class BDMLiveGamePlayer: NSObject, Codable, NSSecureCoding {
    public static var supportsSecureCoding: Bool { return true }
    public let id: Int
    public let fullName, link, firstName, lastName: String
    public let primaryNumber, birthDate: String
    public let currentAge: Int
    public let birthCity, birthCountry, nationality: String
    public let birthStateProvince: String?
    public let height: String
    public let weight: Int
    public let active, alternateCaptain, captain, rookie: Bool
    public let shootsCatches, rosterStatus: String
    public let currentTeam: BDMPlayerCurrentTeam
    public let primaryPosition: BDMPlayerPrimaryPosition

    public func encode(with coder: NSCoder) {
        coder.encode(self.id, forKey: "player_id")
        coder.encode(self.fullName, forKey: "fullName")
        coder.encode(self.link, forKey: "link")
        coder.encode(self.firstName, forKey: "firstName")
        coder.encode(self.lastName, forKey: "lastName")
        coder.encode(self.primaryNumber, forKey: "primaryNumber")
        coder.encode(self.birthDate, forKey: "birthDate")
        coder.encode(self.currentAge, forKey: "currentAge")
        coder.encode(self.birthCity, forKey: "birthCity")
        coder.encode(self.birthStateProvince, forKey: "birthStateProvince")
        coder.encode(self.birthCountry, forKey: "birthCountry")
        coder.encode(self.nationality, forKey: "nationality")
        coder.encode(self.height, forKey: "height")
        coder.encode(self.weight, forKey: "weight")
        coder.encode(self.active, forKey: "active")
        coder.encode(self.alternateCaptain, forKey: "alternateCaptain")
        coder.encode(self.captain, forKey: "captain")
        coder.encode(self.rookie, forKey: "rookie")
        coder.encode(self.shootsCatches, forKey: "shootsCatches")
        coder.encode(self.rosterStatus, forKey: "rosterStatus")
        coder.encode(self.currentTeam, forKey: "currentTeam")
        coder.encode(self.primaryPosition, forKey: "primaryPosition")
    }

    public required convenience init?(coder: NSCoder) {
        let id = coder.decodeInteger(forKey: "player_id")
        let currentAge = coder.decodeInteger(forKey: "currentAge")
        let weight = coder.decodeInteger(forKey: "weight")
        let alternateCaptain = coder.decodeBool(forKey: "alternateCaptain")
        let active = coder.decodeBool(forKey: "captain")
        let rookie = coder.decodeBool(forKey: "rookie")
        let captain = coder.decodeBool(forKey: "captain")
        let birthStateProvince = coder.decodeObject(of: NSString.self, forKey: "birthStateProvince")
        guard let fullName = coder.decodeObject(of: NSString.self, forKey: "fullName"),
            let link = coder.decodeObject(of: NSString.self, forKey: "link"),
            let firstName = coder.decodeObject(of: NSString.self, forKey: "firstName"),
            let lastName = coder.decodeObject(of: NSString.self, forKey: "lastName"),
            let primaryNumber = coder.decodeObject(of: NSString.self, forKey: "primaryNumber"),
            let birthDate = coder.decodeObject(of: NSString.self, forKey: "birthDate"),
            let birthCity = coder.decodeObject(of: NSString.self, forKey: "birthCity"),
            let birthCountry = coder.decodeObject(of: NSString.self, forKey: "birthCountry"),
            let nationality = coder.decodeObject(of: NSString.self, forKey: "nationality"),
            let height = coder.decodeObject(of: NSString.self, forKey: "height"),
            let shootsCatches = coder.decodeObject(of: NSString.self, forKey: "shootsCatches"),
            let rosterStatus = coder.decodeObject(of: NSString.self, forKey: "rosterStatus"),
            let currentTeam = coder.decodeObject(of: BDMPlayerCurrentTeam.self, forKey: "currentTeam"),
            let primaryPosition = coder.decodeObject(of: BDMPlayerPrimaryPosition.self, forKey: "primaryPosition") else {
                return nil
        }

        self.init(id: Int(id),
                  fullName: fullName as String,
                  link: link as String,
                  firstName: firstName as String,
                  lastName: lastName as String,
                  primaryNumber: primaryNumber as String,
                  birthDate: birthDate as String,
                  currentAge: currentAge,
                  birthCity: birthCity as String,
                  birthStateProvince: birthStateProvince as String?,
                  birthCountry: birthCountry as String,
                  nationality: nationality as String,
                  height: height as String,
                  weight: weight,
                  active: active,
                  alternateCaptain: alternateCaptain,
                  captain: captain,
                  rookie: rookie,
                  shootsCatches: shootsCatches as String,
                  rosterStatus: rosterStatus as String,
                  currentTeam: currentTeam,
                  primaryPosition: primaryPosition)
    }

    init(id: Int, fullName: String, link: String, firstName: String, lastName: String, primaryNumber: String, birthDate: String, currentAge: Int, birthCity: String, birthStateProvince: String? = nil, birthCountry: String, nationality: String, height: String, weight: Int, active: Bool, alternateCaptain: Bool, captain: Bool, rookie: Bool, shootsCatches: String, rosterStatus: String, currentTeam: BDMPlayerCurrentTeam, primaryPosition: BDMPlayerPrimaryPosition) {
        self.id = id
        self.fullName = fullName
        self.link = link
        self.firstName = firstName
        self.lastName = lastName
        self.primaryNumber = primaryNumber
        self.birthDate = birthDate
        self.currentAge = currentAge
        self.birthCity = birthCity
        self.birthStateProvince = birthStateProvince
        self.birthCountry = birthCountry
        self.nationality = nationality
        self.height = height
        self.weight = weight
        self.active = active
        self.alternateCaptain = alternateCaptain
        self.captain = captain
        self.rookie = rookie
        self.shootsCatches = shootsCatches
        self.rosterStatus = rosterStatus
        self.currentTeam = currentTeam
        self.primaryPosition = primaryPosition
    }

    public override func isEqual(_ object: Any?) -> Bool {
        if let object = object as? BDMLiveGamePlayer {
            if object === self {
                return true
            } else {
                return isEqualToBDMLiveGamePlayer(object)
            }
        } else {
            return super.isEqual(object)
        }
    }

    private func isEqualToBDMLiveGamePlayer(_ object: BDMLiveGamePlayer) -> Bool {
        return self.id == object.id
    }
}

// MARK: - CurrentTeam
public class BDMPlayerCurrentTeam: NSObject, Codable, NSSecureCoding {
    public static var supportsSecureCoding: Bool { return true }

    public func encode(with coder: NSCoder) {
        coder.encode(self.id, forKey: "id")
        coder.encode(self.name, forKey: "name")
        coder.encode(self.link, forKey: "link")
        coder.encode(self.triCode, forKey: "triCode")
    }

    public required convenience init?(coder: NSCoder) {
        let id = coder.decodeInteger(forKey: "id")
        guard let link = coder.decodeObject(of: NSString.self, forKey: "link"),
            let name = coder.decodeObject(of: NSString.self, forKey: "name"),
            let triCode = coder.decodeObject(of: NSString.self, forKey: "triCode") else {
                return nil
        }
        self.init(id: id,
                  name: name as String,
                  link: link as String,
                  triCode: triCode as String)
    }

    public let id: Int
    public let name, link, triCode: String

    init(id: Int, name: String, link: String, triCode: String) {
        self.id = id
        self.name = name
        self.link = link
        self.triCode = triCode
    }

    public override func isEqual(_ object: Any?) -> Bool {
        if let object = object as? BDMPlayerCurrentTeam {
            if object === self {
                return true
            } else {
                return isEqualToBDMPlayerCurrentTeam(object)
            }
        } else {
            return super.isEqual(object)
        }
    }

    private func isEqualToBDMPlayerCurrentTeam(_ object: BDMPlayerCurrentTeam) -> Bool {
        return self.id == object.id
    }
}

// MARK: - PrimaryPosition
public class BDMPlayerPrimaryPosition: NSObject, Codable, NSSecureCoding {
    public static var supportsSecureCoding: Bool { return true }

    public func encode(with coder: NSCoder) {
        coder.encode(self.code, forKey: "code")
        coder.encode(self.name, forKey: "name")
        coder.encode(self.type, forKey: "type")
        coder.encode(self.abbreviation, forKey: "abbreviation")
    }

    public required convenience init?(coder: NSCoder) {
        guard let code = coder.decodeObject(of: NSString.self, forKey: "code"),
            let name = coder.decodeObject(of: NSString.self, forKey: "name"),
            let type = coder.decodeObject(of: NSString.self, forKey: "type"),
            let abbreviation = coder.decodeObject(of: NSString.self, forKey: "abbreviation") else {
                return nil
        }
        self.init(code: code as String,
                  name: name as String,
                  type: type as String,
                  abbreviation: abbreviation as String)
    }

    public let code, name, type, abbreviation: String

    init(code: String, name: String, type: String, abbreviation: String) {
        self.code = code
        self.name = name
        self.type = type
        self.abbreviation = abbreviation
    }

    public override func isEqual(_ object: Any?) -> Bool {
        if let object = object as? BDMPlayerPrimaryPosition {
            if object === self {
                return true
            } else {
                return isEqualToBDMPlayerPrimaryPosition(object)
            }
        } else {
            return super.isEqual(object)
        }
    }

    private func isEqualToBDMPlayerPrimaryPosition(_ object: BDMPlayerPrimaryPosition) -> Bool {
        return self.code == object.code
    }
}
