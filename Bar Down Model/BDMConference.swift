//
//  BDConference.swift
//  Bar Down Model
//
//  Created by Matthew Sanford on 12/27/19.
//  Copyright © 2019 sanch. All rights reserved.
//
import Foundation

// MARK: - Conference
public class BDMConference: NSObject, Codable, NSSecureCoding {
    public static var supportsSecureCoding: Bool { return true }
    public let id: Int
    public let name, link: String

    init(id: Int, name: String, link: String) {
        self.id = id
        self.name = name
        self.link = link
    }

    public required convenience init?(coder: NSCoder) {
        let id = coder.decodeInteger(forKey: "id")
        guard let name = coder.decodeObject(of: NSString.self, forKey: "name"),
            let link = coder.decodeObject(of: NSString.self, forKey: "link") else { return nil }

        self.init(id: id, name: name as String, link: link as String)
    }

    public func encode(with coder: NSCoder) {
        coder.encodeCInt(Int32(id), forKey: "id")
        coder.encode(self.name, forKey: "name")
        coder.encode(self.link, forKey: "link")
    }
}
