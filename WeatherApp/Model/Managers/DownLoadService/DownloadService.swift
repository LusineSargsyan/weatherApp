//
//  DownloadService.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 06.04.23.
//

import Foundation
import Combine

class DownloadService {
    private let networking: Networking

    init(networking: Networking) {
        self.networking = networking
    }

    func download(routing: Routing) -> AnyPublisher<Data, GenericError> {
        networking.fetch(routing: routing)
            .map { (data, response) in data }
            .mapError { _ in GenericError.emptyData }
            .eraseToAnyPublisher()
    }
}
