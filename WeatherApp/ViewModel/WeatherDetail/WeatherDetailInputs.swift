//
//  WeatherDetailInputs.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 08.04.23.
//

import Foundation
import Reachability

protocol Reachable {
    var isConnected: Bool { get }
}

struct ReachableService: Reachable {
    var isConnected: Bool {
        guard let reachibility = try? Reachability() else { return false }

        return reachibility.connection != .unavailable
    }
}

class WeatherDetailInputs {
    let service: WeatherServicing
    let weatherRealmService: RealmService<WeatherResponse>
    let downloadService: WeatherIconDownloadServicing
    let reachibility: Reachable

    init(service: WeatherServicing,
         weatherRealmService: RealmService<WeatherResponse>,
         downloadService: WeatherIconDownloadServicing,
         reachibility: Reachable) {
        self.service = service
        self.weatherRealmService = weatherRealmService
        self.downloadService = downloadService
        self.reachibility = reachibility
    }
}
