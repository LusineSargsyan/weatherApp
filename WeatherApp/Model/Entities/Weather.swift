//
//  Weather.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 06.04.23.
//

import Foundation
import RealmSwift
import Realm

@objcMembers final class WeatherResponse: Object, Decodable {
    dynamic var id: Int = 0
    dynamic var weather: Weather? = nil
    dynamic var temp: Double = 0.0
    dynamic var maxTemp: Double = 0.0
    dynamic var minTemp: Double = 0.0
    dynamic var humidity: Double = 0.0
    dynamic var windSpeed: Double = 0.0
    dynamic var iconData: Data?
    dynamic var name: String = ""
    dynamic var feelsLike: Double = 0.0

    enum CodingKeys: String, CodingKey {
        case id
        case weather
        case main
        case wind
        case name
    }

    enum NestedCodingKeys: String, CodingKey {
        case maxTemp = "temp_max"
        case minTemp = "temp_min"
        case feelsLike = "feels_like"
        case humidity
        case temp
        case speed
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let nestedContainer = try container.nestedContainer(keyedBy: NestedCodingKeys.self, forKey: .main)
        let nestedWindContainer = try container.nestedContainer(keyedBy: NestedCodingKeys.self, forKey: .wind)

        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.feelsLike = try nestedContainer.decode(Double.self, forKey: .feelsLike)
        self.weather = try container.decode([Weather].self, forKey: .weather).first
        self.maxTemp = try nestedContainer.decode(Double.self, forKey: .maxTemp)
        self.minTemp = try nestedContainer.decode(Double.self, forKey: .minTemp)
        self.temp = try nestedContainer.decode(Double.self, forKey: .temp)
        self.humidity = try nestedContainer.decode(Double.self, forKey: .humidity)
        self.windSpeed = try nestedWindContainer.decode(Double.self, forKey: .speed)
    }

    override static func primaryKey() -> String? {
        return "id"
    }

    required override init() {
        super.init()
    }
}

@objcMembers final class Weather: Object, Decodable {
    dynamic var id: Int = 0
    dynamic var desc: String = ""
    dynamic var icon: String = ""
    dynamic var main: String = ""

    enum CodingKeys: String, CodingKey {
        case id
        case desc = "description"
        case icon
        case main
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.desc = try container.decode(String.self, forKey: .desc)
        self.icon = try container.decode(String.self, forKey: .icon)
        self.main = try container.decode(String.self, forKey: .main)
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }

    required override init() {
        super.init()
    }
}
