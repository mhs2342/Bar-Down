//
//  BDMLiteObject.swift
//  Bar Down Model
//
//  Created by Matthew Sanford on 1/6/20.
//  Copyright © 2020 sanch. All rights reserved.
//

import Foundation

public class BDMLiteObject: NSObject, Codable, NSSecureCoding {
    public class var supportsSecureCoding: Bool { return true }
    public let id: Int?
    public let name, link: String

    init(id: Int? = nil, name: String, link: String) {
        self.id = id
        self.name = name
        self.link = link
    }

    public required convenience init?(coder: NSCoder) {
        let id = coder.containsValue(forKey: "id") ? coder.decodeInteger(forKey: "id") : nil
        guard let name = coder.decodeObject(of: NSString.self, forKey: "name"),
            let link = coder.decodeObject(of: NSString.self, forKey: "link") else { return nil }

        self.init(id: id,
                  name: name as String,
                  link: link as String)

    }

    public func encode(with coder: NSCoder) {
        coder.encode(self.id, forKey: "id")
        coder.encode(self.name, forKey: "name")
        coder.encode(self.link, forKey: "link")
    }
}

public class BDMLiteTeam: BDMLiteObject {
    
}
