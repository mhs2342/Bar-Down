//
//  BDMVenue.swift
//  Bar Down Model
//
//  Created by Matthew Sanford on 12/27/19.
//  Copyright © 2019 sanch. All rights reserved.
//

import Foundation

// MARK: - Venue
public class BDMVenue: BDMLiteObject {
    public let city: String?
    public let timeZone: BDMTimeZone?

    init(id: Int, name: String, link: String, city: String? = nil, timeZone: BDMTimeZone? = nil) {
        self.city = city
        self.timeZone = timeZone
        super.init(id: id, name: name, link: link)
    }

    enum SubCodingKeys: String, CodingKey {
        case city
        case timeZone
    }

    public required convenience init?(coder: NSCoder) {
        let id = coder.decodeInteger(forKey: "id")
        let city = coder.decodeObject(of: NSString.self, forKey: "city")
        let timeZone = coder.decodeObject(of: BDMTimeZone.self, forKey: "timeZone")
        guard let name = coder.decodeObject(of: NSString.self, forKey: "name"),
            let link = coder.decodeObject(of: NSString.self, forKey: "link") else { return nil }

        self.init(id: id,
                  name: name as String,
                  link: link as String,
                  city: city as String?,
                  timeZone: timeZone)

    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SubCodingKeys.self)
        self.city = try? container.decode(String.self, forKey: .city)
        self.timeZone = try? container.decode(BDMTimeZone.self, forKey: .timeZone)
        try super.init(from: decoder)
    }

    public override func encode(with coder: NSCoder) {
        super.encode(with: coder)
        coder.encode(self.city, forKey: "city")
        coder.encode(self.timeZone, forKey: "timeZone")
    }
}
