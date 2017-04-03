//
//  CWChatMessageController.swift
//  CWWeChat
//
//  Created by chenwei on 2017/3/27.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

private let kMaxShowTimeMessageCount = 30
private let kMaxShowtimeMessageInterval: Double = 3*60.0

class CWChatMessageController: UIViewController {
    // 目标会话
    public var conversation: CWChatConversation!
    /// 消息数据数组
    public var messageList = Array<CWChatMessageModel>()
    
    /// 显示消息时间相关的
    var lastDateInterval:TimeInterval = 0
    var messageAccumulate:Int = 0
    var currentDate:Date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        setupUI()
        
        let chatManager = CWChatClient.share.chatManager
        chatManager.addChatDelegate(self, delegateQueue: DispatchQueue.main)
        
        self.conversation.fetchMessagesStart { (list, error) in
            if error == nil {
                for message in list {
                    let messageModel = CWChatMessageModel(message: message)
                    self.messageList.append(messageModel)
                }
                self.tableView.reloadData()
            }
        }
    }
    
    func setupUI() {
        self.view.addSubview(tableView)
        self.view.addSubview(chatToolBar)
        
        registerKeyboardNotifacation()
        registerCell()

    }
    
    /**
     注册cell class
     */
    func registerCell() {
        tableView.register(CWChatMessageCell.self, forCellReuseIdentifier: CWMessageType.none.identifier())
        tableView.register(CWTextMessageCell.self, forCellReuseIdentifier: CWMessageType.text.identifier())
    }
    

    
    //MARK: UI属性
    /// TableView
    lazy var tableView: UITableView = {
        let frame = CGRect(x: 0, y: 0,
                           width: kScreenWidth, height: kScreenHeight-45)
        let tableView = UITableView(frame: frame, style: .plain)
        tableView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        tableView.backgroundColor = UIColor("#EBEBEB")
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 50
        tableView.dataSource = self
        return tableView
    }()
    
    lazy var chatToolBar: CWInputToolBar = {
        let frame = CGRect(x: 0, y: kScreenHeight-45,
                           width: kScreenWidth, height: 45)
        let chatToolBar = CWInputToolBar(frame:frame)
        chatToolBar.delegate = self
        return chatToolBar
    }()
    
    deinit {
        log.debug(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension CWChatMessageController {
    
    public func messageNeedShowTime(_ date:Date) -> Bool {
        messageAccumulate += 1
        let messageInterval = date.timeIntervalSince1970 - lastDateInterval
        //消息间隔
        if messageAccumulate > kMaxShowTimeMessageCount ||
            lastDateInterval == 0 ||
            messageInterval > kMaxShowtimeMessageInterval{
            lastDateInterval = date.timeIntervalSince1970
            messageAccumulate = 0
            return true
        }
        return false
    }
    
    /// 滚动到底部
    public func updateMessageAndScrollBottom(_ animated:Bool = true) {
        if messageList.count == 0 {
            return
        }
        let indexPath = IndexPath(row: messageList.count-1, section: 0)
        self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: animated)
    }
    
    
}

// MARK: - UITableViewDelegate && UITableViewDataSource
extension CWChatMessageController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let messageModel = messageList[indexPath.row]
        let identifier = messageModel.message.messageType.identifier()
    
        // 时间和tip消息 是例外的种类 以后判断
        let messageCell = self.tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! CWChatMessageCell
        
        messageCell.updateMessage(messageModel)
        
        return messageCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let messageModel = messageList[indexPath.row]
        return messageModel.messageFrame.heightOfCell
    }
    
}


// MARK: - CWChatManagerDelegate
extension CWChatMessageController: CWChatManagerDelegate {
    
    func messageStatusDidChange(_ message: CWChatMessage, error: CWChatError?) {
        
    }
    
    func messagesDidReceive(_ message: CWChatMessage) {
        let messageModel = CWChatMessageModel(message: message)
        messageList.append(messageModel)
        
        let indexPath = IndexPath(row: messageList.count-1, section: 0)
        self.tableView.insertRows(at: [indexPath], with: .none)
        updateMessageAndScrollBottom()
    }
}

// MARK: - CWInputToolBarDelegate
extension CWChatMessageController: CWInputToolBarDelegate {
    //
    func chatInputView(_ inputView: CWInputToolBar, sendText text: String) {
        
        let textObject = CWTextMessageBody(text: text)
        let message = CWChatMessage(targetId: conversation.targetId,
                                    direction: .send,
                                    messageBody: textObject)
        self.sendMessage(message)
    
    }
    
    func chatInputView(_ inputView: CWInputToolBar, imageName: String, extentInfo: Dictionary<String, String>) {
        
    }
    
    func sendMessage(_ message: CWChatMessage) {
        
        let messageModel = CWChatMessageModel(message: message)
        self.messageList.append(messageModel)
        
        let indexPath = IndexPath(row: messageList.count-1, section: 0)
        self.tableView.insertRows(at: [indexPath], with: .none)
//        updateMessageAndScrollBottom(true)
        
        let chatManager = CWChatClient.share.chatManager
        chatManager.sendMessage(message, progress: { (progress) in
            
        }) { (message, error) in
    
            // 发送消息失败
            if error != nil {
                
            } else {
                
            }
            
        }
        
    }
    
}

