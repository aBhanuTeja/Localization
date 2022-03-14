//
//  AppDelegate.swift
//  Localization
//
//  Created by Bhanuteja on 14/03/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Localizer.DoTheMagic()
        return true
    }
}

