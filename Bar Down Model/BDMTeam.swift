//
//  BDTeam.swift
//  Bar Down Model
//
//  Created by Matthew Sanford on 12/27/19.
//  Copyright © 2019 sanch. All rights reserved.
//

import Foundation

public class BDMTeams: NSObject, Codable, NSSecureCoding {
    public static var supportsSecureCoding: Bool { return true }
    public let teams: [BDMTeam]

    public init(teams: [BDMTeam]) {
        self.teams = teams
    }

    public required convenience init?(coder: NSCoder) {
        
        guard let teams = coder.decodeObject(of: [NSArray.self, BDMTeam.self], forKey: "teams") as? [BDMTeam] else {
            return nil
        }
        self.init(teams: teams)
    }

    public func encode(with coder: NSCoder) {
        coder.encode(self.teams, forKey: "teams")
    }
}

// MARK: - BDMTeam
public class BDMTeam: NSObject, Codable, NSSecureCoding {
    public static var supportsSecureCoding: Bool { return true }
    public let id: Int
    public let name, link: String
    public let venue: BDMVenue
    public let abbreviation, teamName, locationName, firstYearOfPlay: String
    public let division: BDMDivision
    public let conference: BDMConference
    public let franchise: BDMFranchise
    public let shortName: String
    public let officialSiteURL: String
    public let franchiseID: Int
    public let active: Bool
    public let record: BDMRecord?
    enum CodingKeys: String, CodingKey {
        case id, name, link, venue, abbreviation, teamName, locationName, firstYearOfPlay, division, conference, franchise, shortName
        case officialSiteURL = "officialSiteUrl"
        case franchiseID = "franchiseId"
        case active
        case record
    }

    public func encode(with coder: NSCoder) {
        coder.encodeCInt(Int32(self.id), forKey: "id")
        coder.encode(self.name, forKey: "name")
        coder.encode(self.link, forKey: "link")
        coder.encode(self.venue, forKey: "venue")
        coder.encode(self.abbreviation, forKey: "abbreviation")
        coder.encode(self.teamName, forKey: "teamName")
        coder.encode(self.locationName, forKey: "locationName")
        coder.encode(self.firstYearOfPlay, forKey: "firstYearOfPlay")
        coder.encode(self.division, forKey: "division")
        coder.encode(self.conference, forKey: "conference")
        coder.encode(self.franchise, forKey: "franchise")
        coder.encode(self.shortName, forKey: "shortName")
        coder.encode(self.officialSiteURL, forKey: "officialSiteURL")
        coder.encodeCInt(Int32(self.franchiseID), forKey: "franchiseID")
        coder.encode(self.active, forKey: "active")
        coder.encode(self.record, forKey: "record")
    }

    init(id: Int, name: String, link: String, venue: BDMVenue, abbreviation: String, teamName: String, locationName: String, firstYearOfPlay: String, division: BDMDivision, conference: BDMConference, franchise: BDMFranchise, shortName: String, officialSiteURL: String, franchiseID: Int, active: Bool, record: BDMRecord? = nil) {
        self.id = id
        self.name = name
        self.link = link
        self.venue = venue
        self.abbreviation = abbreviation
        self.teamName = teamName
        self.locationName = locationName
        self.firstYearOfPlay = firstYearOfPlay
        self.division = division
        self.conference = conference
        self.franchise = franchise
        self.shortName = shortName
        self.officialSiteURL = officialSiteURL
        self.franchiseID = franchiseID
        self.active = active
        self.record = record
    }

    public required convenience init?(coder: NSCoder) {
        let id = coder.decodeInteger(forKey: "id")
        let franchiseID = coder.decodeInteger(forKey: "franchiseID")
        let active = coder.decodeBool(forKey: "active")
        guard let name = coder.decodeObject(of: NSString.self, forKey: "name"),
            let link = coder.decodeObject(of: NSString.self, forKey: "link"),
            let venue = coder.decodeObject(of: BDMVenue.self, forKey: "venue"),
            let abbreviation = coder.decodeObject(of: NSString.self, forKey: "abbreviation"),
            let teamName = coder.decodeObject(of: NSString.self, forKey: "teamName"),
            let locationName = coder.decodeObject(of: NSString.self, forKey: "locationName"),
            let firstYearOfPlay = coder.decodeObject(of: NSString.self, forKey: "firstYearOfPlay"),
            let division = coder.decodeObject(of: BDMDivision.self, forKey: "division"),
            let conference = coder.decodeObject(of: BDMConference.self, forKey: "conference"),
            let franchise = coder.decodeObject(of: BDMFranchise.self, forKey: "franchise"),
            let shortName = coder.decodeObject(of: NSString.self, forKey: "shortName"),
            let officialSiteURL = coder.decodeObject(of: NSString.self, forKey: "officialSiteURL") else {
                return nil
        }
        let record = coder.decodeObject(of: BDMRecord.self, forKey: "record")

        self.init(id: id,
                  name: name as String,
                  link: link as String,
                  venue: venue,
                  abbreviation: abbreviation as String,
                  teamName: teamName as String,
                  locationName: locationName as String,
                  firstYearOfPlay: firstYearOfPlay as String,
                  division: division,
                  conference: conference,
                  franchise: franchise,
                  shortName: shortName as String,
                  officialSiteURL: officialSiteURL as String,
                  franchiseID: franchiseID,
                  active: active,
                  record: record)
    }
}
