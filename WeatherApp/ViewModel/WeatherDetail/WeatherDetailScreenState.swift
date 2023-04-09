//
//  WeatherDetailScreenState.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 08.04.23.
//

import Foundation

enum WeatherDetailScreenState: Equatable {
    case empty
    case success(weather: WeatherResponse)
    case loading

    var weather: WeatherResponse? {
        if case let .success(weather) = self {
            return weather
        }

        return nil
    }

    static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case (.empty, .empty),
            (.loading, .loading):
            return true
        case (let .success(weatherLhs), let .success(weatherRhs)):
            return weatherLhs == weatherRhs
        default:
            return false
        }
    }
}
