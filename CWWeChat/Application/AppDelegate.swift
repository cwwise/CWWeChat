//
//  AppDelegate.swift
//  CWWeChat
//
//  Created by chenwei on 2017/3/26.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import CocoaLumberjack
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        //设置logger
        setupLogger()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        loginSuccess()
        self.window?.backgroundColor = UIColor.white
        self.window?.makeKeyAndVisible()
        
        //注册推送信息
        registerRemoteNotification()
        
        return true
    }
    
    func loginSuccess() {
        let tabBarController = CWChatTabBarController()
        self.window?.rootViewController = tabBarController
    }

    ///设置Log日志
    func setupLogger() {
        let fileLogger: DDFileLogger = DDFileLogger() // File Logger
        fileLogger.rollingFrequency = TimeInterval(60*60*24)  // 24 hours
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7
        DDLog.add(fileLogger)
        DDLog.add(DDTTYLogger.sharedInstance, with: .debug)
    }
    
    /// 注册通知
    func registerRemoteNotification() {
        
        UIApplication.shared.registerForRemoteNotifications()
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.badge,.alert,.sound]) { (result, error) in
                
            }
        } else {
            let userSetting = UIUserNotificationSettings(types: [.sound,.alert, .badge], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(userSetting)
        }
    }

    

}

