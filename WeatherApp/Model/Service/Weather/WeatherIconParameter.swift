//
//  WeatherIconParameter.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 06.04.23.
//

import Foundation

struct WeatherIconParameter: Routing {
    private let iconName: String

    init(iconName: String) {
        self.iconName = iconName
    }

    var path: String { return "img/wn/\(iconName)@2x.png" }
    var baseURL: URL { return URL(string: "https://openweathermap.org")! }
}
