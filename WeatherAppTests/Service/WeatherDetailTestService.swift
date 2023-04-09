//
//  WeatherDetailTestService.swift
//  WeatherAppTests
//
//  Created by Lusine Sargsyan on 10.04.23.
//

import Foundation
import Combine
@testable import WeatherApp

struct WeatherDetailTestService: WeatherServicing {
    func fetchWeather(param: WeatherParameter) -> AnyPublisher<WeatherResponse, GenericError> {
        return Future { promise in
            let weather = Weather(id: 1, desc: "Cloudy", icon: "10d", main: "main")
            let weatherResponse = WeatherResponse(id: 5,
                                                  weather: weather,
                                                  temp: 13,
                                                  maxTemp: 15,
                                                  minTemp: 11,
                                                  humidity: 60,
                                                  windSpeed: 10,
                                                  iconData: nil,
                                                  name: "Gyumri",
                                                  feelsLike: 12.5)
            promise(.success(weatherResponse))
        }
        .eraseToAnyPublisher()
    }
}
