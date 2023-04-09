//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 09.04.23.
//

import UIKit

final class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        RealmDataBase.start()

        return true
    }
}
