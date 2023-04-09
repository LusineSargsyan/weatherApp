//
//  ServiceProvider.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 07.04.23.
//

import Foundation
import RealmSwift

enum ServiceProvider {
    static var cityList: CityListService {
        return CityListService(NetworkDataFetcher: ManagerProvider.localResourceDataFetcher())
    }

    static var weather: WeatherWebService {
        return WeatherWebService(NetworkDataFetcher: ManagerProvider.networkDataFetcher())
    }

    static func download(networking: Networking = NetworkManager()) -> DownloadService {
        return DownloadService(networking: networking)
    }

    static func realmService<T: Object>() -> RealmService<T> {
        return RealmService<T>(dataBase: RealmDataBase<T>())
    }
}
