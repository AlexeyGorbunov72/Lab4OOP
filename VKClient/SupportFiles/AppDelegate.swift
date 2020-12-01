//
//  AppDelegate.swift
//  VKClient
//
//  Created by Alexey on 17.11.2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window : UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if #available(iOS 13, *) {
                        // do only pure app launch stuff, not interface stuff
                    } else {
                        self.window = UIWindow(frame: UIScreen.main.bounds)
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let initialViewController = storyboard.instantiateViewController(withIdentifier: "start")
                        self.window?.rootViewController = initialViewController
                        self.window?.makeKeyAndVisible()
                    }
        return true
    }
}


