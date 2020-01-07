//
//  TestModel.swift
//  Bar Down
//
//  Created by Matthew Sanford on 12/28/19.
//  Copyright © 2019 sanch. All rights reserved.
//

import Foundation

class TestModel: Codable {
    var children: [String: DynamicChild]
}


class DynamicChild: Codable {
    var foo: String
    var bar: String
}
