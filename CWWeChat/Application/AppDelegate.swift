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
        self.window = UIWindow(frame: UIScreen.main.bounds)
        setupController()
        self.window?.backgroundColor = UIColor.white
        self.window?.makeKeyAndVisible()
        setupLogger()
        //注册推送信息
        registerRemoteNotification()
        
        DispatchQueue.main.async {
            if let window = self.window {
                let label = FPSLabel(frame: CGRect(x: window.bounds.width - 55 - 8, y: 20, width: 55, height: 20))
                label.autoresizingMask = [.flexibleLeftMargin, .flexibleBottomMargin]
                window.addSubview(label)
            }
        }
        return true
    }
    
    func setupController() {
        // 如果当前已经登录
        var account: CWAccount?
        do {
            account = try CWAccount.userAccount()
        } catch {
        }
        
        guard let current = account else {
            let loginVC = UIStoryboard.welcomeViewController()
            self.window?.rootViewController = loginVC
            return
        }
        
        if current.isLogin {
            let tabBarController = CWChatTabBarController()
            self.window?.rootViewController = tabBarController
            loginChatWithAccount(current)
        } else {
            let loginVC = UIStoryboard.welcomeViewController()
            self.window?.rootViewController = loginVC
        }
    }
    
    func loginChatWithAccount(_ account: CWAccount) {
        let options = CWChatClientOptions(host: "cwwise.com", domain: "cwwise.com")
        let chatClient = CWChatClient.share
        chatClient.initialize(with: options)
        
        chatClient.loginManager.login(username: account.username,
                                      password: account.password) { (username, error) in
                                        
                                        if let username = username {
                                            log.debug("登录成功...\(username)")
                                        }
        }
     
    }
    
    func loginSuccess() {
        let tabBarController = CWChatTabBarController()
        self.window?.rootViewController = tabBarController
    }
    
    func loginMap() {
        let map = MapShowController()
        self.window?.rootViewController = CWChatNavigationController(rootViewController: map)
    }
    
    func loginEmoticonSuccess() {
        let emoticonController = CWEmoticonListController()
        self.window?.rootViewController = CWChatNavigationController(rootViewController: emoticonController)
    }
    
    func loginMomentSuccess() {
        let momentController = CWMomentController()
        self.window?.rootViewController = CWChatNavigationController(rootViewController: momentController)
    }
    
    func logoutSuccess() {
        let loginVC = UIStoryboard.welcomeViewController()
        self.window?.rootViewController = loginVC
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


