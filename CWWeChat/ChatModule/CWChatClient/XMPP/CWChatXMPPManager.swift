//
//  CWChatXMPPManager.swift
//  CWWeChat
//
//  Created by chenwei on 2017/2/12.
//  Copyright © 2017年 chenwei. All rights reserved.
//

import UIKit
import XMPPFramework
import Alamofire

// xmpp管理实例
class CWChatXMPPManager: NSObject {
    
    public static let share = CWChatXMPPManager()

    /// xmpp流
    private(set) var xmppStream: XMPPStream
    /// xmpp重新连接
    fileprivate var xmppReconnect: XMPPReconnect
    /// xmpp队列
    fileprivate var xmppQueue: DispatchQueue

    /// 发送消息
    fileprivate(set) var messageTransmitter: CWMessageTransmitter
    /// 消息发送队列
    fileprivate(set) var messageDispatchQueue: CWMessageDispatchQueue

    var options: CWChatClientOptions!
    
    /// 网络状态监听
    var reachable: NetworkReachabilityManager?
    
    var isLogin: Bool = true

    
    /// 初始化方法
    private override init() {
        xmppQueue = DispatchQueue(label: "com.cwxmppchat.cwcoder", attributes: DispatchQueue.Attributes.concurrent)
        
        xmppStream = XMPPStream()
        xmppReconnect = XMPPReconnect()

        //实际发送消息者
        messageTransmitter = CWMessageTransmitter()
        messageDispatchQueue = CWMessageDispatchQueue()
        
        super.init()
        
        ///xmpp
        xmppStream.enableBackgroundingOnSocket = true
        xmppStream.addDelegate(self, delegateQueue: xmppQueue)
        
        ///配置xmpp重新连接的服务
        xmppReconnect.reconnectDelay = 3.0
        xmppReconnect.reconnectTimerInterval = DEFAULT_XMPP_RECONNECT_TIMER_INTERVAL
        xmppReconnect.activate(xmppStream)
        xmppReconnect.addDelegate(self, delegateQueue: xmppQueue)
        
        setupNetworkReachable()
        registerApplicationNotification()
    }
    
    /// 注册观察者
    func registerApplicationNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillEnterForeground(_:)), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillResignActive(_:)), name: NSNotification.Name.UIApplicationWillResignActive, object: nil)
    }
    
    func setupNetworkReachable() {
        ///监视网络变化
        reachable = NetworkReachabilityManager(host: "https://www.baidu.com")
        reachable?.startListening()
        let listener = { (status: NetworkReachabilityManager.NetworkReachabilityStatus) in
            
        }
        reachable?.listener = listener
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    func loginServer(with userName: String, password: String) {
        
        //判断xmpp状态
        guard xmppStream.isConnecting() || !xmppStream.isAuthenticated() else {
            return
        }
        
        let timeoutInterval:TimeInterval = 30
        
        let resource = options.chatResource
        let domain = options.chatDomain
        
        xmppStream.hostName = options.chatServer
        xmppStream.hostPort = options.chatPort
        xmppStream.myJID = XMPPJID(user: userName, domain: domain, resource: resource)
        
        do {
            try xmppStream.connect(withTimeout: timeoutInterval)
        } catch {
            log.error(error)
        }
        
    }
    
    
    //发送在线信息
    func goOnline() {
        let presence = XMPPPresence()
        xmppStream.send(presence)
    }
    
    func goOffline() {
        let offline = XMPPPresence()
        xmppStream.send(offline)
    }
    
    // MARK: 监听xmpp链接状态
    func xmppStatusChange(_ status: Int) {
     
        
    }
    
    // MARK: 销毁
    deinit {
        
        goOffline()
        
        xmppReconnect.removeDelegate(self, delegateQueue: xmppQueue)
        xmppReconnect.deactivate()
        
        xmppStream.removeDelegate(self, delegateQueue: xmppQueue)
        xmppStream.disconnect()
        
        reachable?.stopListening()
        
        NotificationCenter.default.removeObserver(self)
    }
    
}

// MARK: - XMPPStreamDelegate
extension CWChatXMPPManager: XMPPStreamDelegate {

    /// 开始连接
    func xmppStreamWillConnect(_ sender: XMPPStream!) {
        log.verbose("xmpp开始连接...")
    }
    
    /// 连接失败
    func xmppStreamDidDisconnect(_ sender: XMPPStream!, withError error: Error!) {
        log.error("xmpp连接断开...\(error)")
    }
    
    /// 已经连接，就输入密码
    func xmppStreamDidConnect(_ sender: XMPPStream!) {
        log.verbose("xmpp连接成功,开始认证...")
        do {
            let password = "1234567"
            try xmppStream.authenticate(withPassword: password)
        } catch {
            log.error(error)
        }
    }
    
    // 验证失败
    func xmppStream(_ sender: XMPPStream!, didNotAuthenticate error: DDXMLElement!) {
        log.error("xmpp验证失败...\(error)")
    }
    
    // 验证成功
    func xmppStreamDidAuthenticate(_ sender: XMPPStream!) {
        log.debug("xmpp连接成功")
        
        goOnline()
    }
    

}
