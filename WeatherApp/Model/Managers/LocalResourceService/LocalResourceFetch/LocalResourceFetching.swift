//
//  LocalResourceFetching.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 05.04.23.
//

import Foundation
import Combine

protocol LocalResourceFetching {
    func fetch(from localResource: LocalResourced) -> AnyPublisher<Data, GenericError>
}
