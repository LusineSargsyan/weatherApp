//
//  CityListViewModel.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 06.04.23.
//

import Foundation
import Combine

final class CityListViewModel: ViewModel<CityListInputs> {
    @Published var cityNames: [String] = []

    func getCityList() {
        execute(service: inputs.service.fetchCities(param: CityParameters())) { [weak self] cities in
            self?.cityNames = cities.map { $0.name }
        }
    }
}
