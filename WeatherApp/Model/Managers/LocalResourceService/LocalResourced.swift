//
//  LocalResourced.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 05.04.23.
//

import Foundation

enum LocalResourceType: String {
    case json
    case xml // for example
}

protocol LocalResourced {
    var name: String { get }
    var type: LocalResourceType { get }
}

extension LocalResourced {
    var type: LocalResourceType { return .json }
}
