//
//  WeatherIconDownloadServicing.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 10.04.23.
//

import Foundation
import Combine

protocol WeatherIconDownloadServicing {
    func downloadWeatherIcon(routing: WeatherIconParameter) -> AnyPublisher<Data, GenericError>
}
