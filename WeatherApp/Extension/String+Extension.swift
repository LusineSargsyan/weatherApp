//
//  String+Extension.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 09.04.23.
//

import Foundation

extension String {
    func placeholderIfEmpty(count: Int = 7) -> String {
        return self.isEmpty ? String(repeating: " ", count: count) : self
    }
}
