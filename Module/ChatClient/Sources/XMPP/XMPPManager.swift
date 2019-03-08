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
class XMPPManager: NSObject, XMPPStreamManagementDelegate, XMPPStreamDelegate {
    /// xmpp流
    private(set) var xmppStream: XMPPStream
    /// xmpp重新连接
    private var xmppReconnect: XMPPReconnect
    
    private var autoPing: XMPPAutoPing
    /// xmpp队列
    private var xmppQueue: DispatchQueue
    
    private var streamManagement: XMPPStreamManagement
    
    /// 网络状态监听
    public var reachable: NetworkReachabilityManager!
    
    var options: ChatClientOptions!

    /// 这3个变量 注册和登录 用来临时记录
    var isLoginUser: Bool = true
    var _username: String!
    var _password: String!
    var completion: LoginHandler?
    
    /// 初始化方法
    override init() {
        xmppQueue = DispatchQueue(label: "com.cwwise.cwchat", attributes: DispatchQueue.Attributes.concurrent)
        
        xmppStream = XMPPStream()
        xmppReconnect = XMPPReconnect()
        autoPing = XMPPAutoPing()
        
        let memoryStorage = XMPPStreamManagementMemoryStorage()
        streamManagement = XMPPStreamManagement(storage: memoryStorage)
        
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
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(applicationWillEnterForeground(_:)),
                                               name: NSNotification.Name.UIApplicationWillEnterForeground,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(applicationWillResignActive(_:)),
                                               name: NSNotification.Name.UIApplicationWillResignActive,
                                               object: nil)
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

    func connetService(username: String) {
        // 
        if reachable?.isReachable == false {
            self.completion?(nil, ChatClientError(error: "网络连接失败"))
            self.completion = nil
            return
        }
        
        let timeoutInterval: TimeInterval = 60
        
        xmppStream.hostName = options.host
        xmppStream.hostPort = options.port
        xmppStream.myJID = XMPPJID(string: username, resource: options.resource)
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
    
    func disconnect() {
        self.xmppStream.disconnectAfterSending()
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
    

    // MARK: - XMPPStreamDelegate
    /// 开始连接
    func xmppStreamWillConnect(_ sender: XMPPStream!) {
        log.verbose("xmpp开始连接...")
    }
    
    /// 连接失败
    func xmppStreamDidDisconnect(_ sender: XMPPStream!, withError error: Error!) {
        DispatchQueue.main.async {
            self.completion?(nil, ChatClientError(error: "连接服务器失败"))
            self.completion = nil
        }
    }
    
    /// 已经连接，就输入密码
    func xmppStreamDidConnect(_ sender: XMPPStream!) {
        do {
            if isLoginUser {
                try xmppStream.authenticate(withPassword: _password)
            } else {
                let result = xmppStream.supportsInBandRegistration
                log.debug("注册支持\(result)")
                try xmppStream.register(withPassword: _password)
            }
        } catch {
            log.error(error)
        }
    }
    
    // 验证失败
    func xmppStream(_ sender: XMPPStream!, didNotAuthenticate error: DDXMLElement!) {
        DispatchQueue.main.async {
            self.completion?(nil, ChatClientError(error: ""))
            self.completion = nil
        }
        //登陆失败之后 则断开连接
        sender.disconnect()
    }
    
    // 验证成功
    func xmppStreamDidAuthenticate(_ sender: XMPPStream!) {
        DispatchQueue.main.async {
            self.completion?(self.username, nil)
            self.completion = nil
        }
        goOnline()
        streamManagement.autoResume = true
        streamManagement.enable(withResumption: true, maxTimeout: 60)
    }
    
    func xmppStreamDidRegister(_ sender: XMPPStream!) {
        DispatchQueue.main.async {
            self.completion?(self.username, nil)
            self.completion = nil
        }
    }
    
    func xmppStream(_ sender: XMPPStream!, didNotRegister error: DDXMLElement!) {
        DispatchQueue.main.async {
            self.completion?(nil, ChatClientError(error: "注册失败"))
            self.completion = nil
        }
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
    // swiftlint_disable identifier_name
    func xmppStream(_ sender: XMPPStream!, didSend iq: XMPPIQ!) {
        log.debug(iq)
    }

    // swiftlint_disable identifier_name
    func xmppStream(_ sender: XMPPStream!, didReceive iq: XMPPIQ!) -> Bool {
        log.debug(iq)
        if iq.requiresResponse {
            
        } else {
            
        }
        return true
    }
    
    // MARK: - XMPPStreamManagement
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
        guard let messageid = stanzaIds as? [String], messageid.count != 0 else {
            return
        }
        NotificationCenter.default.post(name: kMessageDispatchSuccessNotification, object: messageid)
    }
}

extension XMPPManager: LoginManager {
    
    var username: String {
        assert(self._username.count != 0, "请调用Login方法")
        return self._username ?? ""
    }
    
    func login(username: String, password: String, completion: LoginHandler?) {
        // 保存变量
        self.isLoginUser = true
        self._password = password
        self._username = username

        self.completion = completion
        connetService(username: username)
    }
    
    func register(username: String, password: String, completion: LoginHandler?) {
        // 保存变量
        self.isLoginUser = false
        self._password = password
        self._username = username
        
        connetService(username: username)
    }
    
    func logout() {
        self.disconnect()
    }
    
    var isConnented: Bool {
        return xmppStream.isConnected
    }
    
    func addDelegate(_ delegate: LoginManagerDelegate) {

    }
    
    func removeDelegate(_ delegate: LoginManagerDelegate) {
        
    }
    
    var isLogined: Bool {
        return xmppStream.isAuthenticated
    }
    
}




