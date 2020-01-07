//
//  BDMLiveGamePlays.swift
//  Bar Down Model
//
//  Created by Matthew Sanford on 12/31/19.
//  Copyright © 2019 sanch. All rights reserved.
//

import Foundation

class BDMLiveGamePlays: NSObject, Codable, NSSecureCoding {
    static var supportsSecureCoding: Bool { return true }
    var allPlays: [BDMLiveGameEvent]
    var scoringPlays, penaltyPlays: [Int]
    var periodPlays: [BDMLiveGamePeriodPlays]
    var currentPlay: BDMLiveGameEvent

    enum CodingKeys: String, CodingKey {
        case allPlays
        case scoringPlays
        case penaltyPlays
        case periodPlays = "playsByPeriod"
        case currentPlay
    }

    init(allPlays: [BDMLiveGameEvent], scoringPlays: [Int], penaltyPlays: [Int], periodPlays: [BDMLiveGamePeriodPlays], currentPlay: BDMLiveGameEvent) {
        self.allPlays = allPlays
        self.scoringPlays = scoringPlays
        self.penaltyPlays = penaltyPlays
        self.periodPlays = periodPlays
        self.currentPlay = currentPlay

    }

    required convenience init?(coder: NSCoder) {
        guard let allPlays = coder.decodeObject(of: [BDMLiveGameEvent.self], forKey: "allPlays") as? [BDMLiveGameEvent],
            let scoringPlays = coder.decodeObject(of: [NSNumber.self], forKey: "scoringPlays") as? [Int],
            let penaltyPlays = coder.decodeObject(of: [NSNumber.self], forKey: "penaltyPlays") as? [Int],
            let periodPlays = coder.decodeObject(of: [BDMLiveGamePeriodPlays.self], forKey: "periodPlays") as? [BDMLiveGamePeriodPlays],
            let currentPlay = coder.decodeObject(of: BDMLiveGameEvent.self, forKey: "currentPlay") else {
                return nil
        }
        self.init(allPlays: allPlays,
                  scoringPlays: scoringPlays,
                  penaltyPlays: penaltyPlays,
                  periodPlays: periodPlays,
                  currentPlay: currentPlay)
    }

    func encode(with coder: NSCoder) {
        coder.encode(self.allPlays, forKey: "allPlays")
        coder.encode(self.scoringPlays, forKey: "scoringPlays")
        coder.encode(self.penaltyPlays, forKey: "peanltyPlays")
        coder.encode(self.periodPlays, forKey: "periodPlays")
        coder.encode(self.currentPlay, forKey: "currentPlay")
    }

}

// MARK: - BDMLiveGamePeriodPlays
class BDMLiveGamePeriodPlays: NSObject, Codable, NSSecureCoding {
    static var supportsSecureCoding: Bool { return true }
    let startIndex, endIndex: Int
    let plays: [Int]

    init(startIndex: Int, endIndex: Int, plays: [Int]) {
        self.startIndex = startIndex
        self.endIndex = endIndex
        self.plays = plays
    }

    required convenience init?(coder: NSCoder) {
        let startIndex = coder.decodeInteger(forKey: "startIndex")
        let endIndex = coder.decodeInteger(forKey: "endIndex")
        let plays = coder.decodeObject(of: [NSNumber.self], forKey: "plays")
        self.init(startIndex: startIndex,
                  endIndex: endIndex,
                  plays: plays as? [Int] ?? [])
    }

    func encode(with coder: NSCoder) {
        coder.encode(self.startIndex, forKey: "startIndex")
        coder.encode(self.endIndex, forKey: "endIndex")
        coder.encode(self.plays, forKey: "plays")
    }
}
