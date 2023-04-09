//
//  WeatherIconDownloadService.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 06.04.23.
//

import Foundation
import Combine

final class WeatherIconDownloadService: DownloadService, WeatherIconDownloadServicing {
    func downloadWeatherIcon(routing: WeatherIconParameter) -> AnyPublisher<Data, GenericError> {
        return download(routing: routing)
    }
}
