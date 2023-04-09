//
//  LocalResourceService.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 05.04.23.
//

import Foundation
import Combine

class LocalResourceService {
    private let localResourceDataFetcher: LocalResourceDataFetching

    init(localResourceDataFetcher: LocalResourceDataFetching) {
        self.localResourceDataFetcher = localResourceDataFetcher
    }

    func execute<T: Decodable>(localResource: LocalResourced) -> AnyPublisher<T, GenericError> {
        return localResourceDataFetcher.fetchData(localResource: localResource)
    }
}
