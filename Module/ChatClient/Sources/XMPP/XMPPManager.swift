//
//  XMPPManager.swift
//  ChatClient
//
//  Created by chenwei on 2017/10/2.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import XMPPFramework
import Alamofire

/// 消息发送成功
let kMessageDispatchSuccessNotification = NSNotification.Name("kMessageDispatchSuccessNotification")
/// 网络变化通知
let kNetworkReachabilityNotification = NSNotification.Name("kNetworkReachabilityNotification")

// xmpp管理实例
class XMPPManager: NSObject {
    
    /// xmpp流
    private(set) var xmppStream: XMPPStream
    /// xmpp重新连接
    private var xmppReconnect: XMPPReconnect
    
    private var autoPing: XMPPAutoPing
    /// xmpp队列
    private var xmppQueue: DispatchQueue
        
    private var multicastDelegate: GCDMulticastDelegate
    
    private var streamManagement: XMPPStreamManagement
    
    /// 网络状态监听
    public var reachable: NetworkReachabilityManager!
    
    var options: ChatClientOptions!

    /// 这3个变量 注册和登录 用来临时记录
    var isLoginUser: Bool = true
    var password: String!
    var completion: LoginHandler?
    
    /// 初始化方法
    override init() {
        xmppQueue = DispatchQueue(label: "com.cwwise.cwchat", attributes: DispatchQueue.Attributes.concurrent)
        
        xmppStream = XMPPStream()
        xmppReconnect = XMPPReconnect()
        autoPing = XMPPAutoPing()
        
        let memoryStorage = XMPPStreamManagementMemoryStorage()
        streamManagement = XMPPStreamManagement(storage: memoryStorage)
        
        multicastDelegate = GCDMulticastDelegate()
        super.init()
        
        /// xmpp
        xmppStream.enableBackgroundingOnSocket = true
        xmppStream.addDelegate(self, delegateQueue: xmppQueue)
        
        ///配置xmpp重新连接的服务
        xmppReconnect.reconnectDelay = 3.0
        xmppReconnect.reconnectTimerInterval = DEFAULT_XMPP_RECONNECT_TIMER_INTERVAL
        xmppReconnect.activate(xmppStream)
        xmppReconnect.addDelegate(self, delegateQueue: xmppQueue)
        
        streamManagement.activate(xmppStream)
        streamManagement.addDelegate(self, delegateQueue: xmppQueue)
        streamManagement.automaticallyRequestAcks(afterStanzaCount: 5, orTimeout: 2.0)
        streamManagement.automaticallySendAcks(afterStanzaCount: 5, orTimeout: 2.0)
        
        //心跳机制
        autoPing.activate(xmppStream)
        autoPing.respondsToQueries = true
        
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
        reachable = Alamofire.NetworkReachabilityManager(host: "www.baidu.com")
        let listener = { (status: NetworkReachabilityManager.NetworkReachabilityStatus) in
            
            var networkStatus = false
            switch status {
                
            case .notReachable:
                networkStatus = false
                
            case .unknown :
                networkStatus = false
                
            case .reachable(.ethernetOrWiFi):
                networkStatus = true
                
            case .reachable(.wwan):
                networkStatus = true
            }
            
            NotificationCenter.default.post(name: kNetworkReachabilityNotification, object: networkStatus)
        }
        reachable.listener = listener
        reachable.startListening()
    }
    
    @objc func applicationWillEnterForeground(_ application: UIApplication) {
        
    }
    
    @objc func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    
    func connetService(user: String) {
        // 
        if reachable?.isReachable == false {
            self.completion?(nil, ChatClientError(error: "网络连接失败"))
            self.completion = nil
            return
        }
        
        let timeoutInterval: TimeInterval = 60
        
        xmppStream.hostName = options.host
        xmppStream.hostPort = options.port
        xmppStream.myJID = XMPPJID(string: user, resource: options.resource)
        do {
            try xmppStream.connect(withTimeout: timeoutInterval)
        } catch {
            let error = ChatClientError(error: "连接超时")
            self.completion?(nil, error)
            self.completion = nil
        }
    }
    
    //
    func goOnline() {
        let presence = XMPPPresence()
        xmppStream.send(presence)
    }
    
    func goOffline() {
        let offline = XMPPPresence(name: "unavailable")
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
extension XMPPManager: XMPPStreamDelegate {
    
    /// 开始连接
    func xmppStreamWillConnect(_ sender: XMPPStream!) {
        log.verbose("xmpp开始连接...")
    }
    
    /// 连接失败
    func xmppStreamDidDisconnect(_ sender: XMPPStream!, withError error: Error!) {
        self.completion?(nil, ChatClientError(error: "连接服务器失败"))
        self.completion = nil
    }
    
    /// 已经连接，就输入密码
    func xmppStreamDidConnect(_ sender: XMPPStream!) {
        do {
            if isLoginUser {
                try xmppStream.authenticate(withPassword: password)
            } else {
                let result = xmppStream.supportsInBandRegistration
                log.debug("注册支持\(result)")
                try xmppStream.register(withPassword: password)
            }
        } catch {
            log.error(error)
        }
    }
    
    // 验证失败
    func xmppStream(_ sender: XMPPStream!, didNotAuthenticate error: DDXMLElement!) {
        self.completion?(nil, ChatClientError(error: ""))
        self.completion = nil
        
        //登陆失败之后 则断开连接
        sender.disconnect()
    }
    
    // 验证成功
    func xmppStreamDidAuthenticate(_ sender: XMPPStream!) {
        self.completion?(xmppStream.myJID!.user, nil)
        self.completion = nil
        
        goOnline()
        streamManagement.autoResume = true
        streamManagement.enable(withResumption: true, maxTimeout: 60)
    }
    
    func xmppStreamDidRegister(_ sender: XMPPStream!) {
        self.completion?(xmppStream.myJID!.user, nil)
        self.completion = nil
    }
    
    func xmppStream(_ sender: XMPPStream!, didNotRegister error: DDXMLElement!) {
        self.completion?(nil, ChatClientError(error: "注册失败"))
        self.completion = nil
    }
    
    // 收到错误信息
    func xmppStream(_ sender: XMPPStream!, didReceiveError error: DDXMLElement!) {
        
        /**
         <stream:error xmlns:stream="http://etherx.jabber.org/streams">
         <conflict xmlns="urn:ietf:params:xml:ns:xmpp-streams"/>
         <text xmlns="urn:ietf:params:xml:ns:xmpp-streams" lang="">
         Replaced by new connection
         </text>
         </stream:error>
         */
        let errormessage = error.elements(forName: "conflict")
        if errormessage.count > 0 {
            
            log.error("异常登录")
        }
    }
    
    func xmppStream(_ sender: XMPPStream!, didSend iq: XMPPIQ!) {
        log.debug(iq)
    }
    
    
    func xmppStream(_ sender: XMPPStream!, didReceive iq: XMPPIQ!) -> Bool {
        log.debug(iq)
        if iq.requiresResponse {
            
        } else {
            
        }
        return true
    }
    
    
}

extension XMPPManager: XMPPStreamManagementDelegate {
    
    func xmppStreamManagementDidRequestAck(_ sender: XMPPStreamManagement!) {
        
    }
    
    func xmppStreamManagement(_ sender: XMPPStreamManagement!, wasEnabled enabled: DDXMLElement!) {
        log.debug("xmppStreamManagement wasEnabled")
    }
    
    func xmppStreamManagement(_ sender: XMPPStreamManagement!, wasNotEnabled failed: DDXMLElement!) {
        log.error("xmppStreamManagement wasNotEnabled")
    }
    
    func xmppStreamManagement(_ sender: XMPPStreamManagement!, didReceiveAckForStanzaIds stanzaIds: [Any]!) {
        // 收到id
        guard let messageid = stanzaIds as? [String] , messageid.count != 0 else {
            return
        }
        NotificationCenter.default.post(name: kMessageDispatchSuccessNotification, object: messageid)
    }
}

extension XMPPManager: LoginManager {
    
    var isConnented: Bool {
        return xmppStream.isConnected
    }
    
    var isLogined: Bool {
        return xmppStream.isAuthenticated
    }
    
    var currentAccount: String {
        guard let jid = xmppStream.myJID,
        let user = jid.user else {
            return ""
        } 
        return user
    }
    
    func login(username: String, password: String, completion: LoginHandler?) {
        // 保存变量
        self.isLoginUser = true
        self.password = password
        self.completion = completion
        
        connetService(user: username)
    }
    
    func register(username: String, password: String, completion: LoginHandler?) {
        // 保存变量
        self.isLoginUser = false
        self.password = password
        self.completion = completion
        
        connetService(user: username)        
    }
    
    func addLoginDelegate(_ delegate: LoginManagerDelegate) {
        
    }
    
    func removeLoginDelegate(_ delegate: LoginManagerDelegate) {
        
    }
    
    func logout() {
        //停止发送消息
        
        //断开xmppStream
        self.xmppStream.disconnect()
    }
    
    
}
