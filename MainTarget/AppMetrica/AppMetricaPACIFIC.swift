//
//  File.swift
//  PacificOcaen
//
//  Created by Vlad Lesnichiy on 15.11.24.
//

import Foundation
import AppMetricaCore

final class AppMetricaPACIFIC {
    func start() {
        guard let configuration = AppMetricaConfiguration(apiKey: "e08abc84-e661-43c4-a5f7-a160a1eac476") else { return }
        AppMetrica.activate(with: configuration)
    }

    func logExample() {
        AppMetrica.reportEvent(name: "First event from iOS", parameters: ["parameter key" : "pararameter value"])
    }

    func testData() {
        print("--- AppMetrica.deviceID", AppMetrica.deviceID)
        print("--- AppMetrica.deviceIDHash", AppMetrica.deviceIDHash)
        print("--- AppMetrica.userProfileID", AppMetrica.userProfileID)
        print("--- AppMetrica.uuid", AppMetrica.uuid)
    }
}
