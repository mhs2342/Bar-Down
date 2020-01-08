//
//  BDWarRoomErrorHandler.swift
//  Bar Down War Room
//
//  Created by Matthew Sanford on 1/7/20.
//  Copyright © 2020 sanch. All rights reserved.
//

import Foundation
import OSLog

extension OSLog {
    static let network = OSLog(subsystem: Bundle.main.bundleIdentifier!, category: "network")
}

class BDWarRoomErrorHandler: NSObject {
    static let shared = BDWarRoomErrorHandler()

    private override init() {
        super.init()
    }

    func log_network_error(_ error: Error) {
        os_log("Network Error: %{PUBLIC}@", log: OSLog.network, type: .error, error.localizedDescription)
    }
}
