//
//  WebService.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 05.04.23.
//

import Foundation
import Combine

class WebService {
    private let NetworkDataFetcher: NetworkDataFetching

    init(NetworkDataFetcher: NetworkDataFetching) {
        self.NetworkDataFetcher = NetworkDataFetcher
    }

    func execute<T: Decodable>(routing: Routing) -> AnyPublisher<T, GenericError> {
        return NetworkDataFetcher.fetchData(routing: routing)
    }
}
