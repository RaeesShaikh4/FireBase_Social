//
//  AppDelegate.swift
//  Firebase_Insta
//
//  Created by Vishal on 29/11/23.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if UserDefaults.standard.string(forKey: "userEmail") != nil, UserDefaults.standard.string(forKey: "userPassword") != nil {
            let tableVC = storyboard.instantiateViewController(withIdentifier: "TableViewController") as! TableViewController
            window?.rootViewController = UINavigationController(rootViewController: tableVC)
        }else{
            let logInVC = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            window?.rootViewController = UINavigationController(rootViewController: logInVC)
        }
        
        window?.makeKeyAndVisible()

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

