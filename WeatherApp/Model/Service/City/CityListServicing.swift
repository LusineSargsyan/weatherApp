//
//  CityListServicing.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 10.04.23.
//

import Foundation
import Combine

protocol CityListServicing {
    func fetchCities(param: CityParameters) -> AnyPublisher<[City], GenericError>
}
