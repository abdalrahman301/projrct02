//
//  AppDelegate.swift
//  projrct
//
//  Created by htu on 7/28/22.
//  Copyright © 2022 htu. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseMessaging
import Firebase
import UserNotifications


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert , .sound]) { (granted, error) in
            
            
        }
        let content = UNMutableNotificationContent()
        content.title = "Hey"
        content.body = "notify!"
        let date = Date().addingTimeInterval(10)
        let dateComponents = Calendar.current.dateComponents([.year , .month , .day ,.hour ,.minute ,.second], from: date)
        let uuidString = UUID().uuidString
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        center.add(request) { (error) in
            //yes
        }
        FirebaseApp.configure()
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

