//
//  WeatherDetailContentViewModel.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 08.04.23.
//

import UIKit
import SwiftUI

struct WeatherDetailContentViewModel {
    @AppStorage("UpdatedDate", store: .standard) var updatedDate = ""

    var state: WeatherDetailScreenState {
        didSet {
            setup()
        }
    }
    var mainInfoViewModel: WeatherMainInfoViewModel?
    var moreInfoViewModel: MoreInfoViewModel?

    var image: UIImage? {
        didSet {
            setup()
        }
    }
    var weather: WeatherResponse? {
        return state.weather
    }

    init(state: WeatherDetailScreenState) {
        self.state = state

        setup()
    }

    // MARK: - Private API
    mutating private func setup() {
        guard let weather = state.weather else { return }

        mainInfoViewModel = WeatherMainInfoViewModel(updatedDate: updatedDate,
                                                     description: weather.weather?.desc.capitalized ?? "",
                                                     tempreture: "\(weather.temp) °C",
                                                     feelsLike: "\(weather.feelsLike) °C",
                                                     image: image)
        moreInfoViewModel = MoreInfoViewModel(weather: weather)
    }
}
