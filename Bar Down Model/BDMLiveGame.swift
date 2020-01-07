//
//  BDMLiveGame.swift
//  Bar Down Model
//
//  Created by Matthew Sanford on 1/6/20.
//  Copyright © 2020 sanch. All rights reserved.
//

import Foundation

class BDMLiveGame: NSObject, Codable, NSSecureCoding {
    static var supportsSecureCoding: Bool { return true }
    let link: String
    let liveData: BDMLiveGameData
    let gameData: BDMLiveGameGameData

    init(link: String, liveData: BDMLiveGameData, gameData: BDMLiveGameGameData) {
        self.link = link
        self.liveData = liveData
        self.gameData = gameData
    }

    required convenience init?(coder: NSCoder) {
        guard let link = coder.decodeObject(of: NSString.self, forKey: "link"),
            let liveData = coder.decodeObject(of: BDMLiveGameData.self, forKey: "liveData"),
            let gameData = coder.decodeObject(of: BDMLiveGameGameData.self, forKey: "gameData") else {
                return nil
        }
        self.init(link: link as String,
                  liveData: liveData,
                  gameData: gameData)
    }

    func encode(with coder: NSCoder) {
        coder.encode(self.link, forKey: "link")
        coder.encode(self.liveData, forKey: "liveData")
        coder.encode(self.gameData, forKey: "gameData")
    }

    override func isEqual(_ object: Any?) -> Bool {
        if let object = object as? BDMLiveGame {
            if object === self {
                return true
            } else {
                return isEqualToBDMLiveGame(object)
            }
        } else {
            return super.isEqual(object)
        }
    }

    private func isEqualToBDMLiveGame(_ object: BDMLiveGame) -> Bool {
        return self.link == object.link
    }
}

class BDMLiveGameData: NSObject, Codable, NSSecureCoding {
    static var supportsSecureCoding: Bool { return true }
    let plays: BDMLiveGamePlays
    let linescore: BDMLiveGameLinescore
    let boxscore: BDMLiveGameBoxScore

    init(plays: BDMLiveGamePlays, linescore: BDMLiveGameLinescore, boxscore: BDMLiveGameBoxScore) {
        self.plays = plays
        self.linescore = linescore
        self.boxscore = boxscore
    }

    required convenience init?(coder: NSCoder) {
        guard let plays = coder.decodeObject(of: BDMLiveGamePlays.self, forKey: "plays"),
            let linescore = coder.decodeObject(of: BDMLiveGameLinescore.self, forKey: "linescore"),
            let boxscore = coder.decodeObject(of: BDMLiveGameBoxScore.self, forKey: "boxscore") else { return nil }

        self.init(plays: plays,
                  linescore: linescore,
                  boxscore: boxscore)
    }

    func encode(with coder: NSCoder) {
        coder.encode(self.plays, forKey: "plays")
        coder.encode(self.linescore, forKey: "linescore")
        coder.encode(self.boxscore, forKey: "boxscore")
    }

}
