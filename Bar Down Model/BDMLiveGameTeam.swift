//
//  BDMLiveGameTeam.swift
//  Bar Down
//
//  Created by Matthew Sanford on 12/28/19.
//  Copyright © 2019 sanch. All rights reserved.
//

import Foundation

// MARK: - BDMLiveGameTeam
public class BDMLiveGameTeam: BDMTeam {
    public let tricode: String

    private enum SubCodingKeys: String, CodingKey {
        case tricode = "triCode"
    }

    init(id: Int, name: String, link: String, venue: BDMVenue, abbreviation: String, tricode: String, teamName: String, locationName: String, firstYearOfPlay: String, division: BDMDivision, conference: BDMConference, franchise: BDMFranchise, shortName: String, officialSiteURL: String, franchiseID: Int, active: Bool) {
        self.tricode = tricode
        super.init(id: id,
                 name: name,
                 link: link,
                 venue: venue,
                 abbreviation: abbreviation,
                 teamName: teamName,
                 locationName: locationName,
                 firstYearOfPlay: firstYearOfPlay,
                 division: division,
                 conference: conference,
                 franchise: franchise,
                 shortName: shortName,
                 officialSiteURL: officialSiteURL,
                 franchiseID: franchiseID,
                 active: active)

    }

    public override func encode(with coder: NSCoder) {
        coder.encode(self.tricode, forKey: "triCode")
        super.encode(with: coder)
    }

    public required convenience init?(coder: NSCoder) {
        let id = coder.decodeInteger(forKey: "id")
        let franchiseID = coder.decodeInteger(forKey: "franchiseID")
        let active = coder.decodeBool(forKey: "active")
        guard let name = coder.decodeObject(of: NSString.self, forKey: "name"),
            let link = coder.decodeObject(of: NSString.self, forKey: "link"),
            let venue = coder.decodeObject(of: BDMVenue.self, forKey: "venue"),
            let abbreviation = coder.decodeObject(of: NSString.self, forKey: "abbreviation"),
            let tricode = coder.decodeObject(of: NSString.self, forKey: "triCode"),
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

        self.init(id: id,
                  name: name as String,
                  link: link as String,
                  venue: venue,
                  abbreviation: abbreviation as String,
                  tricode: tricode as String,
                  teamName: teamName as String,
                  locationName: locationName as String,
                  firstYearOfPlay: firstYearOfPlay as String,
                  division: division,
                  conference: conference,
                  franchise: franchise,
                  shortName: shortName as String,
                  officialSiteURL: officialSiteURL as String,
                  franchiseID: franchiseID,
                  active: active)
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SubCodingKeys.self)
        self.tricode = try container.decode(String.self, forKey: .tricode)
        try super.init(from: decoder)
    }
}
