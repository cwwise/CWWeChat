//
//  AppDelegate.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/22.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit
import CocoaLumberjack
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var userModel: CWUserAccount?
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
    
    
    func showGuideViewController() {
        let guideVC = UIStoryboard.guideViewController()
        self.window?.rootViewController = guideVC
    }
    
    func showLoginViewController() {
        let guideVC = UIStoryboard.guideViewController()
        self.window?.rootViewController = guideVC
    }
    
    func loginSuccess() {
        
        //初始化当前用户模型
        let user = CWContactUser()
        user.userId = "tom"
        user.userName = "Tom"
        user.nikeName = "汤姆"
        user.avatarURL = "http://o7ve5wypa.bkt.clouddn.com/tom@chenweiim.com"
        
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        
        let account = CWUserAccount(chatuser: user)
        appdelegate.userModel = account
        
        let tabbarVC = CWChatTabBarController()
        self.window?.rootViewController = tabbarVC
        
        loadDB()
    }
    
    //初始化数据库
    func loadDB() {
        DispatchQueue.global().async {
            let _ = CWChatDBDataManager.sharedInstance
        }
    }
    
    ///设置Log日志
    func setupLogger() {
        let fileLogger: DDFileLogger = DDFileLogger() // File Logger
        fileLogger.rollingFrequency = TimeInterval(60*60*24)  // 24 hours
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7
        DDLog.add(fileLogger)
        DDLog.add(DDTTYLogger.sharedInstance(), with: .debug)
    }
    
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
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        DDLogDebug(deviceToken.description)
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
}

