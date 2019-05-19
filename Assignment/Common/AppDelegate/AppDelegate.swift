//
//  AppDelegate.swift
//  Assignment
//
//  Created by Kanika on 10/05/19.
//  Copyright © 2019 Kanika. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setRootViewController()
        setGoogleAPIKey()
        Fabric.with([Crashlytics.self])
        Fabric.sharedSDK().debug = true
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        CoreDataStack.sharedManager.saveContext()
    }
    
    func setRootViewController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let rootViewController = ProductListVC()
        let navController = UINavigationController(rootViewController: rootViewController)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
    
    func setGoogleAPIKey() {
        GMSServices.provideAPIKey(Constant.Keys.googleAPIKey)
        GMSPlacesClient.provideAPIKey(Constant.Keys.googleAPIKey)
    }
    
}
