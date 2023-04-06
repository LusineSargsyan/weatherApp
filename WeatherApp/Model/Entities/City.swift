//
//  City.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 05.04.23.
//

import Foundation
import CoreLocation
import Combine

struct City: Decodable {
    let id: Int
    let name: String
    let country: String
    let coordinates: CLLocationCoordinate2D

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case country
        case coord
    }

    enum NestedCodingKeys: String, CodingKey {
        case lat
        case lon
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let nestedContainer = try container.nestedContainer(keyedBy: NestedCodingKeys.self, forKey: .coord)
        let lat = try nestedContainer.decode(Double.self, forKey: .lat)
        let lon = try nestedContainer.decode(Double.self, forKey: .lon)

        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.country = try container.decode(String.self, forKey: .country)
        self.coordinates = CLLocationCoordinate2D(latitude: lat, longitude: lon)
    }
}

