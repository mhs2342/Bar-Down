//
//  main.swift
//  Bar Down War Room
//
//  Created by Matthew Sanford on 12/27/19.
//  Copyright © 2019 sanch. All rights reserved.
//

import Foundation

let delegate = BDWarRoomDelegate()
let listener = NSXPCListener.service()
listener.delegate = delegate
listener.resume()
