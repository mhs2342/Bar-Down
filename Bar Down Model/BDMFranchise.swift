//
//  BDMFranchise.swift
//  Bar Down Model
//
//  Created by Matthew Sanford on 12/27/19.
//  Copyright © 2019 sanch. All rights reserved.
//

import Foundation

// MARK: - Franchise
public class BDMFranchise: NSObject, Codable, NSSecureCoding {
    public static var supportsSecureCoding: Bool { return true }
    public let franchiseID: Int
    public let teamName, link: String

    enum CodingKeys: String, CodingKey {
        case franchiseID = "franchiseId"
        case teamName, link
    }

    init(franchiseID: Int, teamName: String, link: String) {
        self.franchiseID = franchiseID
        self.teamName = teamName
        self.link = link
    }


    public func encode(with coder: NSCoder) {
        coder.encodeCInt(Int32(self.franchiseID), forKey: "franchiseID")
        coder.encode(self.teamName, forKey: "teamName")
        coder.encode(self.link, forKey: "link")
    }

    public required convenience init?(coder: NSCoder) {
        let franchiseID = coder.decodeInteger(forKey: "franchiseID")
        guard let teamName = coder.decodeObject(of: NSString.self, forKey: "teamName"),
            let link = coder.decodeObject(of: NSString.self, forKey: "link") else { return nil }

        self.init(franchiseID: franchiseID,
                  teamName: teamName as String,
                  link: link as String)
    }
}
