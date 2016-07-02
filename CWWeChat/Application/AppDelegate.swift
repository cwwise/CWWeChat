//
//  AppDelegate.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/22.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit
import CocoaLumberjack

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var userModel: CWUserAccount?
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        //设置logger
        setupLogger()
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
//        showGuideViewController()
        loginSuccess()
        
        self.window?.backgroundColor = UIColor.whiteColor()
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
        
        let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let account = CWUserAccount(chatuser: user)
        appdelegate.userModel = account
        
        let tabbarVC = CWChatTabBarController()
        self.window?.rootViewController = tabbarVC
        
        loadDB()
    }
    
    //初始化数据库
    func loadDB() {
        dispatch_async(dispatch_get_global_queue(0, 0)) { 
            let _ = CWChatDBDataManager.sharedInstance
        }
    }
    
    ///设置Log日志
    func setupLogger() {
        DDLog.addLogger(DDTTYLogger.sharedInstance()) // TTY = Xcode console
        DDLog.addLogger(DDASLLogger.sharedInstance()) // ASL = Apple System Logs
        let fileLogger: DDFileLogger = DDFileLogger() // File Logger
        fileLogger.rollingFrequency = 60*60*24  // 24 hours
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7
        DDLog.addLogger(fileLogger)
        
        defaultDebugLevel = .Debug
    }
    
    func registerRemoteNotification() {
        
        UIApplication.sharedApplication().registerForRemoteNotifications()
        let userSetting = UIUserNotificationSettings(forTypes: [.Sound,.Alert, .Badge], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(userSetting)

    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        CWLogDebug(deviceToken.description)
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

