//
//  ServiceProvider.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 07.04.23.
//

import Foundation
import RealmSwift

enum ServiceProvider {
    static var cityList: CityListServicing {
        return CityListService(localResourceDataFetcher: ManagerProvider.localResourceDataFetcher())
    }

    static var weather: WeatherServicing {
        return WeatherWebService(networkDataFetcher: ManagerProvider.networkDataFetcher())
    }

    static var reachableService: Reachable {
        return ReachableService()
    }

    static func weatherIcon(networking: Networking = NetworkManager()) -> WeatherIconDownloadServicing {
        return WeatherIconDownloadService(networking: networking)
    }

    static func realmService<T: Object>() -> RealmService<T> {
        return RealmService<T>(dataBase: RealmDataBase<T>())
    }
}
