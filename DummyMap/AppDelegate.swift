//
//  AppDelegate.swift
//  DummyMap
//
//  Created by Ta Minh Quan on 02/12/2017.
//  Copyright © 2017 Ta Minh Quan. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        PersistenceManager.coreDataStack.saveContext()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        PersistenceManager.coreDataStack.saveContext()
    }

}

