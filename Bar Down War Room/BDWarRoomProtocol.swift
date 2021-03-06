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
    func getSchedule(date: Date, offlineMode: Bool, with reply: @escaping (BDMScheduledGames?, Error?) -> Void)
    func subscribeToFeed(feedId: Int, with reply: @escaping  (BDMLiveGame?, Error?) -> Void)
    func getAllTeams(offlineMode: Bool, with reply: @escaping (BDMTeams?, Error?) -> Void)
}
