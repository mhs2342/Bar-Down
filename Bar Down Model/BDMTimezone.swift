//
//  BDMTimezone.swift
//  Bar Down Model
//
//  Created by Matthew Sanford on 12/27/19.
//  Copyright © 2019 sanch. All rights reserved.
//

import Foundation

// MARK: - TimeZone
public class BDMTimeZone: NSObject, Codable, NSSecureCoding {
    public static var supportsSecureCoding: Bool { return true }
    public let id: String
    public let offset: Int
    public let tz: String

    init(id: String, offset: Int, tz: String) {
        self.id = id
        self.offset = offset
        self.tz = tz
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(self.id, forKey: "id")
        coder.encodeCInt(Int32(self.offset), forKey: "offset")
        coder.encode(self.tz, forKey: "tz")
    }

    public required convenience init?(coder: NSCoder) {
        let offset = coder.decodeInteger(forKey: "offset")
        guard let id = coder.decodeObject(of: NSString.self, forKey: "id"),
            let tz = coder.decodeObject(of: NSString.self, forKey: "tz") else { return nil }

        self.init(id: id as String,
                  offset: offset,
                  tz: tz as String)
    }


}
