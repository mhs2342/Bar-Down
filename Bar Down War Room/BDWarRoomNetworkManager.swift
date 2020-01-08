//
//  BDWarRoomNetworkManager.swift
//  Bar Down War Room
//
//  Created by Matthew Sanford on 1/7/20.
//  Copyright © 2020 sanch. All rights reserved.
//

import Bar_Down_Model
import Foundation

struct APIEndpoint: RawRepresentable {
    var rawValue: String
    typealias RawValue = String

    init?(rawValue: String) {
        self.rawValue = rawValue
    }

    static let schedule = APIEndpoint(rawValue: "schedule")!
    static let liveFeed: (Int) -> APIEndpoint = { id in
        return APIEndpoint(rawValue: "game/\(id)/feed/live")!
    }

    static let teams: (Int?) -> APIEndpoint = { id in
        if let id = id {
            return APIEndpoint(rawValue: "teams/\(id)/")!
        }
        return APIEndpoint(rawValue: "teams/")!
    }
}

public class BDWarRoomNetworkManager: NSObject {
    private var queue = OperationQueue()
    private let baseURL = "https://statsapi.web.nhl.com/api/v1/"

    override init() {
        super.init()
        queue.maxConcurrentOperationCount = 10
    }

    // MARK:- Public API

    /// Get the games scheduled for a given date
    /// - Parameters:
    ///   - date: default date is Today
    ///   - teamID: Filter by a team ID
    ///   - completion: Completion handler using the result type for the scheduled games
    public func getSchedule(_ date: Date = Date(), teamID: Int? = nil, completion: @escaping (Result<BDMScheduledGames, Error>) -> Void) {
        let params = generateScheduleParams(date, teamID)
        guard let request = generateRequest(endpoint: APIEndpoint.schedule, params: params) else { return }
        queue.addOperation {
            self.performRequest(request, completion: completion)
        }
    }

    /// Subscribe to a games live feed
    /// - Parameters:
    ///   - gameID: id of game
    ///   - completion: Completion handler that returns a result for a live game
    public func getLiveFeed(_ gameID: Int, completion: @escaping (Result<BDMLiveGame, Error>) -> Void) {
        guard let request = generateRequest(endpoint: APIEndpoint.liveFeed(gameID), params: nil) else { return }
        queue.addOperation {
            self.performRequest(request, completion: completion)
        }
    }

    public func getAllTeams(completion: @escaping (Result<BDMTeams, Error>) -> Void) {
        guard let request = generateRequest(endpoint: APIEndpoint.teams(nil), params: nil) else { return }
        queue.addOperation {
            self.performRequest(request, completion: completion)
        }
    }


    func generateRequest(endpoint: APIEndpoint, params: [String: String]?) -> URLRequest? {
        guard var url = URL(string: baseURL) else { return nil }
        url.appendPathComponent(endpoint.rawValue)

        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return nil }
        components.queryItems = params?.compactMap({ URLQueryItem(name: $0, value: $1) })

        var request = URLRequest(url: components.url!)
        request.allHTTPHeaderFields = params
        return request
    }

    func generateScheduleParams(_ date: Date, _ teamID: Int? = nil) -> [String: String] {
        let dateString = format(date, formatString: "yyyy-MM-dd")
        // generate header dictionary
        var paramDictionary: [String: String] = [
            "startDate": dateString,
            "endDate": dateString
        ]
        if let teamID = teamID {
            paramDictionary["teamId"] = String(describing: teamID)
        }

        return paramDictionary
    }

    private func performRequest<T: Codable>(_ request: URLRequest,
                                completion: @escaping (Result<T, Error>) -> Void) {
        let session = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let data = data {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                do {
                    let scheduled = try decoder.decode(T.self, from: data)
                    completion(.success(scheduled))
                } catch  {
                    completion(.failure(error))
                }
            }
        }
        session.resume()
    }


    private func format(_ date: Date, formatString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = formatString
        return formatter.string(from: date)
    }
}
