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

    func getSchedule(date: Date = Date(), offlineMode: Bool, with reply: @escaping (BDMScheduledGames?, Error?) -> Void) {
        if offlineMode {
            
        } else {
            networkManager.getSchedule { (result) in
                switch result {
                case .success(let games):
                    reply(games, nil)
                case .failure(let error):
                    reply(nil, error)
                }
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

    func getAllTeams(offlineMode: Bool, with reply: @escaping (BDMTeams?, Error?) -> Void) {
        if offlineMode {
            do {
                let data = loadJsonFromFile("BostonBruins")
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let teams = try decoder.decode(BDMTeams.self, from: data)
                reply(teams, nil)
            } catch {

                reply(nil, error)
            }
        } else {
            networkManager.getAllTeams { (result) in
                switch result {
                case .success(let teams):
                    reply(teams, nil)
                case .failure(let error):
                    reply(nil, error)
                }
            }
        }

    }

    private func loadJsonFromFile(_ name: String) -> Data {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: name, ofType: "json")
        let url = URL(fileURLWithPath: path!)
        return try! Data(contentsOf: url)
    }
}
