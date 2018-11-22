//
//  AppDelegate.swift
//  performance_fly
//
//  Created by dengjiangzhou on 2018/11/2.
//  Copyright © 2018 dengjiangzhou. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        window = WindowWithStatusBar(frame: UIScreen.main.bounds)
        let rootNavController = UINavigationController(rootViewController: CatFeedViewController())
        
        let font = UIFont(name: "OleoScript-Regular", size: 20.0)!
        rootNavController.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: font]
        rootNavController.navigationBar.barTintColor = UIColor.white
        rootNavController.navigationBar.isOpaque = true
        rootNavController.navigationItem.titleView?.isOpaque = true
        rootNavController.navigationBar.isTranslucent = false
        window?.rootViewController = rootNavController
        window?.makeKeyAndVisible()

        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
       NetManager.shared.sendLogs()
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

