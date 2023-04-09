//
//  WeatherServicing.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 10.04.23.
//

import Foundation
import Combine

protocol WeatherServicing {
    func fetchWeather(param: WeatherParameter) -> AnyPublisher<WeatherResponse, GenericError>
}
