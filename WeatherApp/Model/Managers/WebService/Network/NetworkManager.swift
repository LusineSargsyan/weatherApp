//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 05.04.23.
//

import Foundation
import Combine

struct NetworkManager: Networking {
    func fetch(routing: Routing) -> AnyPublisher<(Data, URLResponse), Error> {
        let urlRequest = routing.urlRequest

        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map { ($0.data, $0.response)}
            .mapError { $0 }
            .eraseToAnyPublisher()
    }
}
