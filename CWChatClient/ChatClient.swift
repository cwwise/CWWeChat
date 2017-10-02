//
//  CWChatClient.swift
//  CWChatClient
//
//  Created by chenwei on 2017/10/2.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import Foundation
import SwiftyBeaver

let log = SwiftyBeaver.self

public class ChatClient {
    
    static let share = ChatClient()
    /// 版本
    private(set) var version: String
    /// login
    private(set) var loginManager: LoginManager
 
    
    public var currentAccount: String {
        return self.loginManager.currentAccount
    }
    
    private init() {
        version = "0.0.1"
        
        let xmppManager = XMPPManager()
        self.loginManager = xmppManager
        
        setupLogger()
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
    
}
