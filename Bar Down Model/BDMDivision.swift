//
//  BDMDivision.swift
//  Bar Down Model
//
//  Created by Matthew Sanford on 12/27/19.
//  Copyright © 2019 sanch. All rights reserved.
//

import Foundation

// MARK: - Division
public class BDMDivision: NSObject, Codable, NSSecureCoding {
    public static var supportsSecureCoding: Bool { return true }
    public let id: Int
    public let name, nameShort, link, abbreviation: String

    init(id: Int, name: String, nameShort: String, link: String, abbreviation: String) {
        self.id = id
        self.name = name
        self.nameShort = nameShort
        self.link = link
        self.abbreviation = abbreviation
    }

    public required convenience init?(coder: NSCoder) {
        let id = coder.decodeInteger(forKey: "id")
        guard let name = coder.decodeObject(of: NSString.self, forKey: "name"),
            let nameShort = coder.decodeObject(of: NSString.self, forKey: "nameShort"),
            let link = coder.decodeObject(of: NSString.self, forKey: "link"),
            let abbreviation = coder.decodeObject(of: NSString.self, forKey: "abbreviation") else {
                 return nil
        }

        self.init(id: id,
                  name: name as String,
                  nameShort: nameShort as String,
                  link: link as String,
                  abbreviation: abbreviation as String)
    }

    public func encode(with coder: NSCoder) {
        coder.encodeCInt(Int32(self.id), forKey: "id")
        coder.encode(self.name, forKey: "name")
        coder.encode(self.nameShort, forKey: "nameShort")
        coder.encode(self.link, forKey: "link")
        coder.encode(self.abbreviation, forKey: "abbreviation")
    }
}
