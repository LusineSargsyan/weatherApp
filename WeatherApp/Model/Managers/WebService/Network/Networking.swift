//
//  Networking.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 05.04.23.
//

import Foundation
import Combine

protocol Networking {
    func fetch(routing: Routing) -> AnyPublisher<(Data, URLResponse), Error>
}
