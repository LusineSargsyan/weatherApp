//
//  CityService.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 06.04.23.
//

import Foundation
import Combine

final class CityListService: LocalResourceService, CityListServicing {
    func fetchCities(param: CityParameters) -> AnyPublisher<[City], GenericError> {
        return execute(localResource: param)
    }
}
