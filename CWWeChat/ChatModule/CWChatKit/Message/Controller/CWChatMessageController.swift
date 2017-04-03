//
//  CWChatMessageController.swift
//  CWWeChat
//
//  Created by chenwei on 2017/3/27.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class CWChatMessageController: UIViewController {
    // 目标id
    public var targetId: String!
    /// 消息数据数组
    public var messageList = Array<CWChatMessageModel>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 消息
        let textObject = CWTextMessageBody(text: "1234")
        let message = CWChatMessage(targetId: "chenwei", messageBody: textObject)
        
        let messageModel = CWChatMessageModel(message: message)
        messageList.append(messageModel)
        
        self.view.backgroundColor = UIColor.white
        setupUI()
        registerCell()
        
        let chatManager = CWChatClient.share.chatManager
        chatManager.addChatDelegate(self, delegateQueue: DispatchQueue.main)
    }
    
    func setupUI() {
        self.view.addSubview(tableView)
        self.view.addSubview(chatToolBar)
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

// MARK: - UITableViewDelegate
extension CWChatMessageController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
}

// MARK: - UITableViewDataSource
extension CWChatMessageController: UITableViewDataSource {
    
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
    
    func messageStatusDidChange(_ message: CWChatMessage, error: NSError?) {
        
    }
    
    func messagesDidReceive(_ message: CWChatMessage) {
        let messageModel = CWChatMessageModel(message: message)
        messageList.append(messageModel)
        
        let indexPath = IndexPath(row: messageList.count-1, section: 0)
        self.tableView.insertRows(at: [indexPath], with: .none)
    }
}

// MARK: - CWInputToolBarDelegate
extension CWChatMessageController: CWInputToolBarDelegate {
    //
    func chatInputView(_ inputView: CWInputToolBar, sendText text: String) {
        
        let textObject = CWTextMessageBody(text: text)
        let message = CWChatMessage(targetId: "chenwei",
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

