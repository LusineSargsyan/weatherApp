//
//  LocalResourceDataFetcher.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 05.04.23.
//

import Foundation
import Combine

struct LocalResourceDataFetcher: LocalResourceDataFetching {
    private let localResourceFetcher: LocalResourceFetching
    private let parser: Parsing
    private let responseValidator: LocalResourceValidating
    private let errorHandler: ErrorHandling

    init(localResourceFetcher: LocalResourceFetching,
         parser: Parsing,
         responseValidator: LocalResourceValidating,
         errorHandler: ErrorHandling) {
        self.localResourceFetcher = localResourceFetcher
        self.parser = parser
        self.responseValidator = responseValidator
        self.errorHandler = errorHandler
    }

    func fetchData<T>(localResource: LocalResourced) -> AnyPublisher<T, GenericError> where T : Decodable {
        localResourceFetcher.fetch(from: localResource)
            .tryMap { data in
                do {
                    try responseValidator.validate(data: data)
                    let parsedData: T = try parser.parse(from: data)

                    return parsedData
                }
            }
            .mapError {
                errorHandler.handleError(error: $0)
            }
            .eraseToAnyPublisher()
    }
}
