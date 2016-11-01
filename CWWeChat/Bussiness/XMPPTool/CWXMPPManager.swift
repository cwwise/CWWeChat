//
//  CWXMPPManager.swift
//  CWXMPPChat
//
//  Created by chenwei on 16/5/27.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit
import Alamofire
//主要是需要使用
import XMPPFramework

public typealias XMPPStatusListener = ((CWXMPPStatus) -> Void)

/// 管理xmpp的类
class CWXMPPManager: NSObject {
    ///单例
    static let shareXMPPManager = CWXMPPManager()
    
    fileprivate var xmppQueue: DispatchQueue
    ///xmpp流
    var xmppStream: XMPPStream
    ///xmpp重新连接
    fileprivate var xmppReconnect: XMPPReconnect
    
    ///消息发送
    fileprivate(set) var messageTransmitter: CWMessageTransmitter
    fileprivate(set) var messageDispatchQueue: CWMessageDispatchQueue
    ///消息解析
    fileprivate(set) var messageCracker: CWMessageCracker
    ///消息回执(XEP-0184)
//    private var deliveryReceipts: XMPPMessageDeliveryReceipts
    ///获取好友请求
    fileprivate var xmppRoster: XMPPRoster
    
    /// XMPP状态
    var statusListener: XMPPStatusListener?
    
    /// 网络状态监听
    var reachable: NetworkReachabilityManager?

    ///当前连接状态
    var currentState: CWXMPPStatus {
        var state: CWXMPPStatus = .None
        if xmppStream.isDisconnected() {
            state = .Disconnected
        }
        else if xmppStream.isConnected() && xmppStream.isAuthenticated() {
            state = .Connected
        } else {
            state = .Connecting
        }
        return state
    }
    
    
    ///初始化方法
    fileprivate override init() {
        xmppQueue = DispatchQueue(label: "com.cwxmppchat.cwcoder", attributes: DispatchQueue.Attributes.concurrent)
        
        xmppStream = XMPPStream()
        xmppReconnect = XMPPReconnect()
        //实际发送消息者
        messageTransmitter = CWMessageTransmitter()
        
        messageDispatchQueue = CWMessageDispatchQueue()
        messageCracker = CWMessageCracker()
        
        let xmppRosterStorage = XMPPRosterMemoryStorage()
        xmppRoster = XMPPRoster(rosterStorage: xmppRosterStorage, dispatchQueue: xmppQueue)
        
        ///消息回执
//        deliveryReceipts = XMPPMessageDeliveryReceipts()
        
        super.init()
        
        ///xmpp
        xmppStream.enableBackgroundingOnSocket = true
        xmppStream.addDelegate(self, delegateQueue: xmppQueue)
        xmppStream.hostName = CWXMPPConfigure.shareXMPPConfigure().hostName
        xmppStream.hostPort = CWXMPPConfigure.shareXMPPConfigure().hostPort
        
        ///好友
        xmppRoster.activate(xmppStream)
        xmppRoster.addDelegate(self, delegateQueue: xmppQueue)
        
        ///配置xmpp重新连接的服务
        xmppReconnect.reconnectDelay = 3.0
        xmppReconnect.reconnectTimerInterval = DEFAULT_XMPP_RECONNECT_TIMER_INTERVAL
        xmppReconnect.activate(xmppStream)
        xmppReconnect.addDelegate(self, delegateQueue: xmppQueue)
        
        ///消息回执
//        deliveryReceipts.activate(xmppStream)
//        deliveryReceipts.autoSendMessageDeliveryReceipts = true
        
        ///消息发送
        messageCracker.activate(xmppStream)
        
      
        setupNetworkReachable()
        registerApplicationNotification()
    }
    
    ///连接服务器
    func connectProcess() {
        
        guard xmppStream.isConnecting() || !xmppStream.isConnected() else {
            return
        }
        
        //可以添加是哪个端
        let timeoutInterval:TimeInterval = 10
        let xmppDomain = CWXMPPConfigure.shareXMPPConfigure().xmppDomain
        let userName = CWUserAccount.sharedUserAccount().userID
        let resource = CWUserAccount.sharedUserAccount().resource

        
        xmppStream.myJID = XMPPJID(user: userName, domain: xmppDomain, resource: resource)
    
        do {
            try xmppStream.connect(withTimeout: timeoutInterval)
        } catch let error as NSError {
            CWLogError(error.description)
        }
    }
    
    ///注册观察者
    func registerApplicationNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillEnterForeground(_:)), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillResignActive(_:)), name: NSNotification.Name.UIApplicationWillResignActive, object: nil)
    }
    
    func setupNetworkReachable() {
        ///监视网络变化
        reachable = NetworkReachabilityManager(host: "https://www.baidu.com")
        reachable?.startListening()
        let listener = { (status: NetworkReachabilityManager.NetworkReachabilityStatus) in
            CWLogDebug("网络状态:\(self.reachable?.isReachable)")
        }
        reachable?.listener = listener
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    
    //发送在线信息
    func goOnline() {
        let presence = XMPPPresence(type: CWUserStatus.Online.rawValue)
        xmppStream.send(presence)
    }
    
    func goOffline() {
        let offline = XMPPPresence(type: CWUserStatus.Offline.rawValue)
        xmppStream.send(offline)
    }
    
    // MARK: 监听
    func xmppStatusChange(_ status:CWXMPPStatus) {
        if let listenrer = self.statusListener {
            listenrer(status)
        }
    }
    
    ///MARK: 销毁
    deinit {
        xmppReconnect.removeDelegate(self, delegateQueue: xmppQueue)
        xmppReconnect.deactivate()
        
        xmppStream.removeDelegate(self, delegateQueue: xmppQueue)
        xmppStream.disconnect()
        
        reachable?.stopListening()
        
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - XMPPStreamDelegate
extension CWXMPPManager: XMPPStreamDelegate {
    
    ///
    func xmppStreamWillConnect(_ sender: XMPPStream!) {
        CWLogDebug("开始连接")
        xmppStatusChange(.Connecting)
    }
    
    ///连接失败
    func xmppStreamDidDisconnect(_ sender: XMPPStream!, withError error: Error!) {
        CWLogDebug("断开连接")
        xmppStatusChange(.Disconnected)
    }
    
    ///已经连接，就输入密码
    func xmppStreamDidConnect(_ sender: XMPPStream!) {
        CWLogDebug("连接成功")
        do {
            let password = CWUserAccount.sharedUserAccount().password
            try xmppStream.authenticate(withPassword: password)
        } catch let error as NSError {
            CWLogError(error.description)
        }
    }
    
    ///验证失败
    func xmppStream(_ sender: XMPPStream!, didNotAuthenticate error: DDXMLElement!) {
        CWLogDebug("认证失败")
        xmppStatusChange(.Error)
    }
    
    ///验证成功
    func xmppStreamDidAuthenticate(_ sender: XMPPStream!) {
        CWLogDebug("认证成功")
        xmppStatusChange(.Connected)
        //上线
        goOnline()
    }
    
    ///收到状态信息 TODO: 好友上下线的逻辑
    func xmppStream(_ sender: XMPPStream!, didReceive presence: XMPPPresence!) {
        
        let myUser = sender.myJID.user
        
        //好友的用户名
        let user = presence.from().user
    
        //用户所在的域
        let _ = presence.from().domain
        
        //状态
        let type = presence.type()
        
        guard user != myUser else {
            
            return
        }
        
        //如果是好友上下线
        //上线
        if type == CWUserStatus.Online.rawValue {
            
        }
        //下线
        else if type == CWUserStatus.Offline.rawValue {
            
        }
        
    }
    
    func xmppStream(_ sender: XMPPStream!, didReceive iq: XMPPIQ!) -> Bool {
        return true
    }
    
}

// MARK: - XMPPRosterDelegate 好友请求
extension CWXMPPManager: XMPPRosterDelegate {
    
    ///收到好友列表
    func xmppRosterDidEndPopulating(_ sender: XMPPRoster!) {
        CWLogDebug("获取好友信息界面")
        let story = sender.xmppRosterStorage as! XMPPRosterMemoryStorage
        let userArray = story.sortedUsersByName() as! [XMPPUser]
        
        for user in userArray {
            
            let chatUser = CWContactUser()
            chatUser.nikeName = user.nickname()
            chatUser.isOnline = user.isOnline()
            chatUser.userName = user.jid().user
            chatUser.userId = user.jid().full()
            
        }
        
        DispatchQueue.main.async { 
            NotificationCenter.default.post(name: Notification.Name(rawValue: CWFriendsNeedReloadNotification), object: nil)
        }
        //需要刷新好友列表
        
    }
}

