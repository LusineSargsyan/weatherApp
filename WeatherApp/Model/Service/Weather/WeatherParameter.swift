//
//  WeatherParameter.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 06.04.23.
//

import Foundation

struct WeatherParameter: Routing {
    private let city: String

    init(city: String) {
        self.city = city
    }

    var path: String { return "data/2.5/weather" }
    var params: RequestParam {
        return ["q": city,
                "appid": "7c3bfbdab0c74c5f2b3358f58b1da664",
                "units": "metric"]
    }
}
