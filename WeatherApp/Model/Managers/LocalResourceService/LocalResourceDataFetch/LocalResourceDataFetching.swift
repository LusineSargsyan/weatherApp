//
//  LocalResourceDataFetching.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 05.04.23.
//

import Foundation
import Combine

protocol LocalResourceDataFetching {
    init(localResourceFetcher: LocalResourceFetching,
         parser: Parsing,
         responseValidator: LocalResourceValidating,
         errorHandler: ErrorHandling)

    func fetchData<T: Decodable>(localResource: LocalResourced) -> AnyPublisher<T, GenericError>
}
