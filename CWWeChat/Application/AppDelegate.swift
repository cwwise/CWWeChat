//
//  AppDelegate.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/22.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit
import SwiftyBeaver
import UserNotifications

let log = SwiftyBeaver.self

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
        
        loginXMPP()
        //注册推送信息
        registerRemoteNotification()
        
        return true
    }
    
    func loginXMPP() {
        
        //        let options = CWChatClientOptions(chatServer: "localhost", chatDomain: "localhost")
        let options = CWChatClientOptions(chatServer: "hosted.im", chatDomain: "hellochatim.p1.im")
        let chatClient = CWChatClient.share
        chatClient.initialize(with: options)
        
        chatClient.login(username: "haohao", password: "1234567") { (username, error) in
            
        }
        
    }
    
    func loginSuccess() {
        let tabBarController = CWChatTabBarController()
        self.window?.rootViewController = tabBarController
    }
    
    ///设置Log日志
    func setupLogger() {
        
        // add log destinations. at least one is needed!
        let console = ConsoleDestination()  // log to Xcode Console
        console.minLevel = .debug // just log .info, .warning & .error
        let file = FileDestination()  // log to default swiftybeaver.log file
        log.addDestination(console)
        log.addDestination(file)
        
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


