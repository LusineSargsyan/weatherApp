//
//  LocalResourceService.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 05.04.23.
//

import Foundation
import Combine

class LocalResourceService {
    private let NetworkDataFetcher: LocalResourceDataFetching

    init(NetworkDataFetcher: LocalResourceDataFetching) {
        self.NetworkDataFetcher = NetworkDataFetcher
    }

    func execute<T: Decodable>(localResource: LocalResourced) -> AnyPublisher<T, GenericError> {
        return NetworkDataFetcher.fetchData(localResource: localResource)
    }
}
