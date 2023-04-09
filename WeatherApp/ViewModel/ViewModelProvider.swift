//
//  ViewModelProvider.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 07.04.23.
//

import Foundation

enum ViewModelProvider {
    static var cityList: CityListViewModel {
        let cityListInputs = CityListInputs(service: ServiceProvider.cityList)

        return CityListViewModel(inputs: cityListInputs)
    }

    static func weatherDetail(cityName: String) -> WeatherDetailViewModel {
        let weatherDetailInputs = WeatherDetailInputs(service: ServiceProvider.weather,
                                                      weatherRealmService: ServiceProvider.realmService(),
                                                      downloadService: ServiceProvider.download())

        return WeatherDetailViewModel(cityName: cityName, inputs: weatherDetailInputs)
    }
}
