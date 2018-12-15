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
        
        
        let rootVC = TestViewController()
        window = WindowWithStatusBar(frame: UIScreen.main.bounds)
        let rootNavController = UINavigationController(rootViewController: rootVC)
        
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

    
    
 

}

