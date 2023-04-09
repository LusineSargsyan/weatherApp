//
//  MoreInfoDetail.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 07.04.23.
//

import Foundation

enum MoreInfoDetail {
    case maxTemp(value: Double)
    case minTemp(value: Double)
    case humidity(value: Double)
    case windSpeed(value: Double)

    var title: String {
        switch self {
        case .maxTemp:
            return "Max temp"
        case .minTemp:
            return "Min temp"
        case .humidity:
            return "Humidity"
        case .windSpeed:
            return "Wind Speed"
        }
    }

    var value: String {
        switch self {
        case .maxTemp(let value):
            return "\(value) °C"
        case .minTemp(let value):
            return "\(value) °C"
        case .humidity(let value):
            return "\(value) %"
        case .windSpeed(let value):
            return "\(value) m/s"
        }
    }
}


struct MoreInfoViewModel {
    let dataSource: [MoreInfoDetail]

    init(weather: WeatherResponse) {
        self.dataSource = [.minTemp(value: weather.minTemp),
                           .maxTemp(value: weather.maxTemp),
                           .humidity(value: weather.humidity),
                           .windSpeed(value: weather.windSpeed)]
    }
}
