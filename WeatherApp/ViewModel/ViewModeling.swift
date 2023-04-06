//
//  ViewModeling.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 05.04.23.
//

import Foundation

protocol ViewModeling {
    var isLoading: Bool { get set }
    var alertItem: AlertItem? { get set }
}
