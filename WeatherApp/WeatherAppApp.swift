//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 04.04.23.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    @UIApplicationDelegateAdaptor var appDelegate: AppDelegate

    var body: some Scene {
        WindowGroup {
            CityListView()
        }
    }
}
