//
//  WeatherDetailInputs.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 08.04.23.
//

import Foundation
import Reachability

struct WeatherDetailInputs {
    let service: WeatherWebService
    let weatherRealmService: RealmService<WeatherResponse>
    let downloadService: DownloadService
    var reachibility: Reachability? { return try? Reachability() } // TODO: create a ReachableService please

    init(service: WeatherWebService,
         weatherRealmService: RealmService<WeatherResponse>,
         downloadService: DownloadService) {
        self.service = service
        self.weatherRealmService = weatherRealmService
        self.downloadService = downloadService
    }
}
