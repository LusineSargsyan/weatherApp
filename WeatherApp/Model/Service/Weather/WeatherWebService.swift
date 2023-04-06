//
//  WeatherWebService.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 06.04.23.
//

import Foundation
import Combine

final class WeatherWebService: WebService {
    func fetchweather(param: WeatherParameter) -> AnyPublisher<WeatherResponse, GenericError> {
        return execute(routing: param)
    }
}
