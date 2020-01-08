//
//  Bar_DownTests.swift
//  Bar DownTests
//
//  Created by Matthew Sanford on 12/25/19.
//  Copyright © 2019 sanch. All rights reserved.
//

import XCTest
@testable import Bar_Down
@testable import Bar_Down_War_Room
class Bar_DownTests: XCTestCase {
    var networkManager: BDWarRoomNetworkManager!

    override func setUp() {
        networkManager = BDWarRoomNetworkManager()
    }

    func testGenerateScheduleParams() {
        let components = DateComponents(year: 2020, month: 1, day: 1)
        guard let date = Calendar.current.date(from: components) else {
            XCTFail()
            return
        }
        let params = networkManager.generateScheduleParams(date)
        XCTAssertEqual(params["startDate"], "2020-01-01")
        XCTAssertEqual(params["endDate"], "2020-01-01")
        XCTAssertNil(params["teamId"])
        let paramsWithTeamID = networkManager.generateScheduleParams(date, 10)
        XCTAssertEqual(paramsWithTeamID["startDate"], "2020-01-01")
        XCTAssertEqual(paramsWithTeamID["endDate"], "2020-01-01")
        XCTAssertEqual(paramsWithTeamID["teamId"], "10")
    }

    func testGenerateScheduleRequest() {
        let components = DateComponents(year: 2020, month: 1, day: 1)
        guard let date = Calendar.current.date(from: components) else {
            XCTFail()
            return
        }
        let headersWithTeamID = networkManager.generateScheduleParams(date, 10)
        guard let request = networkManager.generateRequest(endpoint: .schedule, params: headersWithTeamID) else {
            XCTFail()
             return
        }
        var params = URLComponents(string: request.url!.absoluteString)
        params?.queryItems?.sort(by: { $0.name < $1.name })
        XCTAssertEqual(params?.queryItems?[0].name, "endDate")
        XCTAssertEqual(params?.queryItems?[0].value, "2020-01-01")
        XCTAssertEqual(params?.queryItems?[1].name, "startDate")
        XCTAssertEqual(params?.queryItems?[1].value, "2020-01-01")
        XCTAssertEqual(params?.queryItems?[2].name, "teamId")
        XCTAssertEqual(params?.queryItems?[2].value, "10")
    }

    func testGenerateLiveFeedRequest() {
        let gameID = 2019020582
        guard let request = networkManager.generateRequest(endpoint: .liveFeed(gameID), params: nil) else {
            XCTFail()
             return
        }
        XCTAssertEqual(request.url?.absoluteString, "https://statsapi.web.nhl.com/api/v1/game/2019020582/feed/live")
    }

    func testGetLiveFeed() {
        let gameID = 2019020582
        let expectation = XCTestExpectation(description: "com.sanch.bar-down-war-room.get-live-feed")
        self.measure {
            networkManager.getLiveFeed(gameID) { (result) in
                switch result {
                case .success(let liveGame):
                    XCTAssertEqual(liveGame.gameData.teams.away.name, "Boston Bruins")
                    XCTAssertEqual(liveGame.gameData.teams.home.name, "Buffalo Sabres")
                case .failure(let error):
                    print(error)
                    XCTFail(error.localizedDescription)
                }
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 15)
    }

    func testGetAllTeams() {
        let expectation = XCTestExpectation(description: "com.sanch.bar-down-war-room.get-all-teams")
        self.measure {
            networkManager.getAllTeams { (result) in
                switch result {
                case .success(let obj):
                    XCTAssertFalse(obj.teams.isEmpty)
                case .failure(let error):
                    print(error)
                    XCTFail(error.localizedDescription)
                }
                expectation.fulfill()
            }
        }
    }

    func testGetSchedule() {
        let components = DateComponents(year: 2020, month: 1, day: 8)
        guard let date = Calendar.current.date(from: components) else {
            XCTFail()
            return
        }
        let expectation = XCTestExpectation(description: "com.sanch.bar-down-war-room.get-schedule")
        self.measure {
            self.networkManager.getSchedule(date) { (result) in
                switch result {
                case .success(let scheduled):
                    XCTAssertEqual(scheduled.totalGames, 3)
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                    print(error)
                }
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 15)
    }

    func testGetScheduleForJanuary() {
        for i in 1...30 {
            let components = DateComponents(year: 2020, month: 1, day: i)
            guard let date = Calendar.current.date(from: components) else {
                XCTFail()
                return
            }
            let expectation = XCTestExpectation(description: "com.sanch.bar-down-war-room.get-schedule")
                self.networkManager.getSchedule(date) { (result) in
                    switch result {
                    case .success:
                        print("success for \(date)")
                    case .failure(let error):
                        XCTFail(error.localizedDescription)
                        print(date, error)
                    }
                    expectation.fulfill()
                }
            wait(for: [expectation], timeout: 15)
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
