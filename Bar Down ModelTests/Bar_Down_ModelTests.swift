//
//  Bar_Down_ModelTests.swift
//  Bar Down ModelTests
//
//  Created by Matthew Sanford on 12/27/19.
//  Copyright © 2019 sanch. All rights reserved.
//

import XCTest
@testable import Bar_Down_Model

class Bar_Down_ModelTests: XCTestCase {
    var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()

    override func setUp() {
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPlayerNSCoder() {
        do {
            let data = try Bar_Down_ModelTests.loadJsonFromFile("BradMarchand")
            let player = try decoder.decode(BDMLiveGamePlayer.self, from: data)
            let archivedData = try NSKeyedArchiver.archivedData(withRootObject: player, requiringSecureCoding: true)
            guard let unarchivedPlayer = try NSKeyedUnarchiver.unarchivedObject(ofClass: BDMLiveGamePlayer.self, from: archivedData) else {
                XCTFail()
                return
            }
            XCTAssertEqual(player, unarchivedPlayer)
        } catch  {

        }
    }

    func testPeriodReadyEventDecoderFromJSON() {
        do {
            let data = try Bar_Down_ModelTests.loadJsonFromFile("PeriodReadyEvent")
            let event = try decoder.decode(BDMLiveGameEvent.self, from: data)
            XCTAssertNotNil(event.about)
            XCTAssertNil(event.coordinates)
            XCTAssertNotNil(event.result)
            XCTAssertNil(event.result.strength)
            XCTAssertNil(event.result.secondaryType)
            XCTAssertNil(event.result.gameWinningGoal)
            XCTAssertNil(event.result.emptyNet)
        } catch  {
            XCTFail(error.localizedDescription)
        }
    }

    func testFaceoffEventDecoderFromJSON() {
        do {
            let data = try Bar_Down_ModelTests.loadJsonFromFile("FaceoffEvent")
            let event = try decoder.decode(BDMLiveGameEvent.self, from: data)
            XCTAssertNotNil(event.about)
            XCTAssertNotNil(event.coordinates)
            XCTAssertNotNil(event.result)
            XCTAssertNil(event.result.strength)
            XCTAssertNil(event.result.secondaryType)
            XCTAssertNil(event.result.gameWinningGoal)
            XCTAssertNil(event.result.emptyNet)
            XCTAssertNotNil(event.team)
            XCTAssertEqual(event.players?.count, 2)
            XCTAssertEqual(event.result.eventTypeID, "FACEOFF")
            XCTAssertEqual(event.about.eventID, 152)
        } catch  {
            XCTFail(error.localizedDescription)
        }
    }

    func testShotEventDecoderFromJSON() {
        do {
            let data = try Bar_Down_ModelTests.loadJsonFromFile("ShotEvent")
            let event = try decoder.decode(BDMLiveGameEvent.self, from: data)
            XCTAssertNotNil(event.about)
            XCTAssertNotNil(event.coordinates)
            XCTAssertNotNil(event.result)
            XCTAssertNil(event.result.strength)
            XCTAssertEqual(event.result.secondaryType, "Tip-In")
            XCTAssertNil(event.result.gameWinningGoal)
            XCTAssertNil(event.result.emptyNet)
            XCTAssertNotNil(event.team)
            XCTAssertEqual(event.about.eventID, 153)
            XCTAssertEqual(event.result.eventTypeID, "SHOT")
            XCTAssertEqual(event.players?.count, 2)
        } catch  {
            XCTFail(error.localizedDescription)
        }
    }

    func testHitEventDecoderFromJSON() {
        do {
            let data = try Bar_Down_ModelTests.loadJsonFromFile("HitEvent")
            let event = try decoder.decode(BDMLiveGameEvent.self, from: data)
            XCTAssertNotNil(event.about)
            XCTAssertNotNil(event.coordinates)
            XCTAssertNotNil(event.result)
            XCTAssertNil(event.result.strength)
            XCTAssertNil(event.result.secondaryType)
            XCTAssertNil(event.result.gameWinningGoal)
            XCTAssertNil(event.result.emptyNet)
            XCTAssertNotNil(event.team)
            XCTAssertEqual(event.about.eventID, 107)
            XCTAssertEqual(event.result.eventTypeID, "HIT")
            XCTAssertEqual(event.players?.count, 2)
        } catch  {
            XCTFail(error.localizedDescription)
        }
    }

    func testBlockedShotEventDecoderFromJSON() {
        do {
            let data = try Bar_Down_ModelTests.loadJsonFromFile("BlockedShotEvent")
            let event = try decoder.decode(BDMLiveGameEvent.self, from: data)
            XCTAssertNotNil(event.about)
            XCTAssertNotNil(event.coordinates)
            XCTAssertNotNil(event.result)
            XCTAssertNil(event.result.strength)
            XCTAssertNil(event.result.secondaryType)
            XCTAssertNil(event.result.gameWinningGoal)
            XCTAssertNil(event.result.emptyNet)
            XCTAssertNotNil(event.team)
            XCTAssertEqual(event.about.eventID, 159)
            XCTAssertEqual(event.result.eventTypeID, "BLOCKED_SHOT")
            XCTAssertEqual(event.players?.count, 2)
        } catch  {
            XCTFail(error.localizedDescription)
        }
    }

    func testTakeawayEventEventDecoderFromJSON() {
        do {
            let data = try Bar_Down_ModelTests.loadJsonFromFile("TakeawayEvent")
            let event = try decoder.decode(BDMLiveGameEvent.self, from: data)
            XCTAssertNotNil(event.about)
            XCTAssertNotNil(event.coordinates)
            XCTAssertNotNil(event.result)
            XCTAssertNil(event.result.strength)
            XCTAssertNil(event.result.secondaryType)
            XCTAssertNil(event.result.gameWinningGoal)
            XCTAssertNil(event.result.emptyNet)
            XCTAssertNotNil(event.team)
            XCTAssertEqual(event.about.eventID, 109)
            XCTAssertEqual(event.result.eventTypeID, "TAKEAWAY")
            XCTAssertEqual(event.players?.count, 1)
        } catch  {
            XCTFail(error.localizedDescription)
        }
    }

    func testGoalEventEventDecoderFromJSON() {
        do {
            let data = try Bar_Down_ModelTests.loadJsonFromFile("GoalEvent")
            let event = try decoder.decode(BDMLiveGameEvent.self, from: data)
            XCTAssertNotNil(event.about)
            XCTAssertNotNil(event.coordinates)
            XCTAssertNotNil(event.result)
            XCTAssertNotNil(event.team)
            XCTAssertNotNil(event.result.strength)
            XCTAssertEqual(event.result.secondaryType, "Slap Shot")
            XCTAssertTrue(event.result.gameWinningGoal!)
            XCTAssertFalse(event.result.emptyNet!)
            XCTAssertEqual(event.about.eventID, 193)
            XCTAssertEqual(event.result.eventTypeID, "GOAL")
            XCTAssertEqual(event.about.goals.away, 1)
            XCTAssertEqual(event.about.goals.home, 0)
            XCTAssertEqual(event.players?.count, 4)
        } catch  {
            XCTFail(error.localizedDescription)
        }
    }

    func testMissedShotEventEventDecoderFromJSON() {
        do {
            let data = try Bar_Down_ModelTests.loadJsonFromFile("MissedShotEvent")
            let event = try decoder.decode(BDMLiveGameEvent.self, from: data)
            XCTAssertNotNil(event.about)
            XCTAssertNotNil(event.coordinates)
            XCTAssertNotNil(event.result)
            XCTAssertNotNil(event.team)
            XCTAssertNil(event.result.strength)
            XCTAssertNil(event.result.secondaryType)
            XCTAssertNil(event.result.gameWinningGoal)
            XCTAssertNil(event.result.emptyNet)
            XCTAssertEqual(event.about.eventID, 197)
            XCTAssertEqual(event.result.eventTypeID, "MISSED_SHOT")
            XCTAssertEqual(event.players?.count, 1)
        } catch  {
            XCTFail(error.localizedDescription)
        }
    }

    func testStoppageEventEventDecoderFromJSON() {
        do {
            let data = try Bar_Down_ModelTests.loadJsonFromFile("StoppageEvent")
            let event = try decoder.decode(BDMLiveGameEvent.self, from: data)
            XCTAssertNotNil(event.about)
            XCTAssertNil(event.coordinates)
            XCTAssertNotNil(event.result)
            XCTAssertNil(event.team)
            XCTAssertEqual(event.result.resultDescription, "Goalie Stopped")
            XCTAssertEqual(event.about.eventID, 147)
            XCTAssertEqual(event.result.eventTypeID, "STOP")
            XCTAssertNil(event.players)
            XCTAssertNil(event.result.strength)
            XCTAssertNil(event.result.secondaryType)
            XCTAssertNil(event.result.gameWinningGoal)
            XCTAssertNil(event.result.emptyNet)

        } catch  {
            XCTFail(error.localizedDescription)
        }
    }

    func testGiveawayEventDecoderFromJSON() {
        do {
            let data = try Bar_Down_ModelTests.loadJsonFromFile("GiveawayEvent")
            let event = try decoder.decode(BDMLiveGameEvent.self, from: data)
            XCTAssertNotNil(event.about)
            XCTAssertNotNil(event.coordinates)
            XCTAssertNotNil(event.result)
            XCTAssertNotNil(event.team)
            XCTAssertEqual(event.about.eventID, 305)
            XCTAssertEqual(event.result.eventTypeID, "GIVEAWAY")
            XCTAssertEqual(event.players?.count, 1)

            XCTAssertNil(event.result.strength)
            XCTAssertNil(event.result.secondaryType)
            XCTAssertNil(event.result.gameWinningGoal)
            XCTAssertNil(event.result.emptyNet)

        } catch  {
            XCTFail(error.localizedDescription)
        }
    }

    func testPenaltyEventDecoderFromJSON() {
        do {
            let data = try Bar_Down_ModelTests.loadJsonFromFile("PenaltyEvent")
            let event = try decoder.decode(BDMLiveGameEvent.self, from: data)
            XCTAssertNotNil(event.about)
            XCTAssertNotNil(event.coordinates)
            XCTAssertNotNil(event.result)
            XCTAssertNotNil(event.team)
            XCTAssertEqual(event.about.eventID, 324)
            XCTAssertEqual(event.result.eventTypeID, "PENALTY")
            XCTAssertEqual(event.result.penaltyMinutes, 2)
            XCTAssertEqual(event.result.penaltySeverity, "Minor")
            XCTAssertEqual(event.players?.count, 2)

            XCTAssertNil(event.result.strength)
            XCTAssertEqual(event.result.secondaryType, "Holding")
            XCTAssertNil(event.result.gameWinningGoal)
            XCTAssertNil(event.result.emptyNet)

        } catch  {
            XCTFail(error.localizedDescription)
        }
    }

    func testLiveGamePlaysDecoderFromJSON() {
        do {
            let data = try Bar_Down_ModelTests.loadJsonFromFile("LiveGamePlays")
            let plays = try decoder.decode(BDMLiveGamePlays.self, from: data)
            print(plays.allPlays.count)
        } catch  {
            XCTFail(error.localizedDescription)
            print(error)
        }
    }

    func testLiveGameLinescoreDecoderFromJSON() {
        do {
            let data = try Bar_Down_ModelTests.loadJsonFromFile("Linescore")
            let linescore = try decoder.decode(BDMLiveGameLinescore.self, from: data)
            XCTAssertEqual(linescore.currentPeriod, 3)
            XCTAssertEqual(linescore.currentPeriodTimeRemaining, "Final")
            XCTAssertEqual(linescore.currentPeriodOrdinal, "3rd")
            XCTAssertEqual(linescore.periods.count, 3)
            XCTAssertEqual(linescore.intermissionInfo.timeElapsed, 0)
            XCTAssertEqual(linescore.intermissionInfo.timeRemaining, 0)
            XCTAssertEqual(linescore.intermissionInfo.inProgress, false)
            XCTAssertEqual(linescore.powerPlayInfo.timeElapsed, 114)
            XCTAssertEqual(linescore.powerPlayInfo.timeRemaining, 0)
            XCTAssertEqual(linescore.powerPlayInfo.inProgress, false)
        } catch  {
            XCTFail(error.localizedDescription)
            print(error)
        }
    }

    func testLiveGameGameDataDecoderFromJSON() {
        do {
            let data = try Bar_Down_ModelTests.loadJsonFromFile("LiveGameGameData")
            let gameData = try decoder.decode(BDMLiveGameGameData.self, from: data)
        } catch {
            XCTFail(error.localizedDescription)
            print(error)
        }
    }

    func testLiveGameBoxScoreDecoderFromJSON() {
        do {
            let data = try Bar_Down_ModelTests.loadJsonFromFile("LiveGameBoxScore")
            let boxscore = try decoder.decode(BDMLiveGameBoxScore.self, from: data)
            XCTAssertNil(boxscore.teams.home.players["ID8476439"]?.stats.skaterStats)
            XCTAssertNil(boxscore.teams.home.players["ID8476439"]?.stats.goalieStats)
        } catch {
            XCTFail(error.localizedDescription)
            print(error)
        }
    }

    func testLiveFeedDecoderFromJSON() {
        do {
            let data = try Bar_Down_ModelTests.loadJsonFromFile("LiveFeed")
            let liveGame = try decoder.decode(BDMLiveGame.self, from: data)
        } catch {
            XCTFail(error.localizedDescription)
            print(error)
        }
    }

    func testScheduleGamesDecoderFromJSON() {
        do {
            let data = try Bar_Down_ModelTests.loadJsonFromFile("ScheduledGames")
            let scheduled = try decoder.decode(BDMScheduledGames.self, from: data)
            XCTAssertEqual(scheduled.dates[0].games.count, 2)
        } catch {
            XCTFail(error.localizedDescription)
            print(error)
        }
    }

    func testNestedDictionaryJSON() {
        do {
            let data = try Bar_Down_ModelTests.loadJsonFromFile("NestedDictionaries")
            let dto = try decoder.decode(TestModel.self, from: data)
            XCTAssertNotNil(dto)
            XCTAssertEqual(dto.children["1"]?.bar, "bar1")
            XCTAssertEqual(dto.children["2"]?.bar, "bar2")
        } catch  {
            XCTFail(error.localizedDescription)
        }
    }

    func testPlayerDecoderFromJSON() {
        do {
            let data = try Bar_Down_ModelTests.loadJsonFromFile("BradMarchand")
            let dto = try decoder.decode(BDMLiveGamePlayer.self, from: data)
            XCTAssertNotNil(dto)
        } catch  {
            XCTFail(error.localizedDescription)
        }
    }

    func testTeamDecoderFromJSON() {
        do {
            let data = try Bar_Down_ModelTests.loadJsonFromFile("BostonBruins")
            let dto = try decoder.decode(BDMTeamDTO.self, from: data)
            XCTAssertNotNil(dto)
        } catch  {
            XCTFail(error.localizedDescription)
        }
    }

    func testLiveGameTeamDecoderFromJSON() {
        do {
            let data = try Bar_Down_ModelTests.loadJsonFromFile("LiveGameTeamBuffalo")
            let dto = try decoder.decode(BDMLiveGameTeam.self, from: data)
            XCTAssertNotNil(dto)
        } catch  {
            XCTFail(error.localizedDescription)
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

    static func loadJsonFromFile(_ name: String) throws -> Data {
        let bundle = Bundle(for: Bar_Down_ModelTests.self)
        let path = bundle.path(forResource: name, ofType: "json")
        let url = URL(fileURLWithPath: path!)
        return try Data(contentsOf: url)
    }
}
