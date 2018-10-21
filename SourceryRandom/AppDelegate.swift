//
//  AppDelegate.swift
//  SourceryRandom
//
//  Created by Петрічук Олег Аркадійовіч on 23.09.2018.
//  Copyright © 2018 Oleg Petrychuk. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        [
            Dog.autoRandom(firstName: "I am first"),
            Dog.autoRandom(),
            Dog.autoRandom(),
            Dog.autoRandom(),
            Dog.autoRandom(),
            Dog.autoRandom(),
            Dog.autoRandom()
        ].forEach {
            dump($0)
            print("\n")
        }
        return true
    }
}

