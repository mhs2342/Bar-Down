//
//  BDWarRoom.swift
//  Bar Down War Room
//
//  Created by Matthew Sanford on 12/27/19.
//  Copyright © 2019 sanch. All rights reserved.
//

import Bar_Down_Model
import Foundation

class BDWarRoom: NSObject, BDWarRoomProtocol {
    var networkManager: BDWarRoomNetworkManager

    override init() {
        networkManager = BDWarRoomNetworkManager()

        super.init()

    }

    func getSchedule(date: Date = Date(), with reply: @escaping (BDMScheduledGames?, Error?) -> Void) {
        networkManager.getSchedule { (result) in
            switch result {
            case .success(let games):
                reply(games, nil)
            case .failure(let error):
                reply(nil, error)
            }
        }
    }

    func subscribeToFeed(feedId: Int, with reply: @escaping (BDMLiveGame?, Error?) -> Void) {
        networkManager.getLiveFeed(feedId) { (result) in
            switch result {
            case .success(let game):
                reply(game, nil)
            case .failure(let error):
                reply(nil, error)
            }
        }
    }

    func getAllTeams(with reply: @escaping ([BDMTeam]?, Error?) -> Void) {
        networkManager.getAllTeams { (result) in
            switch result {
            case .success(let teams):
                reply(teams.teams, nil)
            case .failure(let error):
                reply(nil, error)
            }
        }
    }
}
