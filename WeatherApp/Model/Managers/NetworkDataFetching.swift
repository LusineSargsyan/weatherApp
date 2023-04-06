//
//  NetworkDataFetching.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 05.04.23.
//

import Foundation
import Combine

protocol NetworkDataFetching {
    init(networkManager: Networking,
         parser: Parsing,
         responseValidator: ResponseValidating,
         errorHandler: ErrorHandling)

    func fetchData<T: Decodable>(routing: Routing) -> AnyPublisher<T, GenericError>
}
