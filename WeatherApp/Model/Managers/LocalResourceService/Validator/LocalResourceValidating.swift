//
//  LocalResourceValidating.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 05.04.23.
//

import Foundation

protocol LocalResourceValidating {
    func validate(data: Data) throws
}
