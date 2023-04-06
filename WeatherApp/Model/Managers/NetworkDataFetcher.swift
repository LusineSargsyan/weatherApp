//
//  NetworkDataFetcher.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 05.04.23.
//

import Foundation
import Combine

struct NetworkDataFetcher: NetworkDataFetching {
    private let networkManager: Networking
    private let parser: Parsing
    private let responseValidator: ResponseValidating
    private let errorHandler: ErrorHandling

    init(networkManager: Networking,
         parser: Parsing,
         responseValidator: ResponseValidating,
         errorHandler: ErrorHandling) {
        self.networkManager = networkManager
        self.parser = parser
        self.responseValidator = responseValidator
        self.errorHandler = errorHandler
    }

    func fetchData<T>(routing: Routing) -> AnyPublisher<T, GenericError> where T : Decodable {
        networkManager.fetch(routing: routing)
            .tryMap { response in
                let data = try responseValidator.validate(routing: routing, response: response)
                let parsedData: T = try parser.parse(from: data)

                return parsedData
            }
            .mapError {
                errorHandler.handleError(error: $0)
            }
            .eraseToAnyPublisher()
    }
}
