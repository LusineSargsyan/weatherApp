//
//  WebService.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 05.04.23.
//

import Foundation
import Combine

class WebService {
    private let networkDataFetcher: NetworkDataFetching

    init(networkDataFetcher: NetworkDataFetching) {
        self.networkDataFetcher = networkDataFetcher
    }

    func execute<T: Decodable>(routing: Routing) -> AnyPublisher<T, GenericError> {
        return networkDataFetcher.fetchData(routing: routing)
    }
}
