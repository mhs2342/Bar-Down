//
//  BDWarRoomProtocol.swift
//  Bar Down War Room
//
//  Created by Matthew Sanford on 12/27/19.
//  Copyright © 2019 sanch. All rights reserved.
//

import Bar_Down_Model
import Foundation

@objc public protocol BDWarRoomProtocol {
    func getTodaysSchedule(with reply: (BDMScheduledGames) -> Void)
}
