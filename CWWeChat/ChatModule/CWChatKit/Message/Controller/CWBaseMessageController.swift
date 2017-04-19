//
//  CWBaseMessageController.swift
//  CWWeChat
//
//  Created by chenwei on 2017/3/27.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import LCActionSheet

private let kMaxShowTimeMessageCount = 30
private let kMaxShowtimeMessageInterval: Double = 3*60.0

class CWBaseMessageController: UIViewController {
    // 目标会话
    public var conversation: CWChatConversation!
    /// 消息数据数组
    public var messageList = Array<AnyObject>()
    

    /// 显示消息时间相关的
    var messageTimeIntervalTag: Double = -1
    var messageAccumulate:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        setupUI()
        
        let chatManager = CWChatClient.share.chatManager
        chatManager.addChatDelegate(self, delegateQueue: DispatchQueue.main)
        
        self.conversation.fetchMessagesStart { (list, error) in
            if error == nil {
                let messageList = self.formatMessages(list)
                self.messageList.append(contentsOf: messageList)
                self.tableView.reloadData()
            }
        }
        
//        let voiceBody1 = CWVoiceMessageBody(voicePath: nil, voiceURL: nil, voiceLength: 10)
//        let message1 = CWChatMessage(targetId: conversation.targetId, messageBody: voiceBody1)
//        message1.sendStatus = .failed
//        self.messageList.append(CWChatMessageModel(message: message1))
//        
//        let voiceBody2 = CWVoiceMessageBody(voicePath: nil, voiceURL: nil, voiceLength: 10)
//        let message2 = CWChatMessage(targetId: conversation.targetId, direction: .receive, messageBody: voiceBody2)
//        message2.sendStatus = .failed
//
//        self.messageList.append(CWChatMessageModel(message: message2))
//        
//        self.tableView.reloadData()
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
        tableView.register(CWImageMessageCell.self, forCellReuseIdentifier: CWMessageType.image.identifier())
        tableView.register(CWVoiceMessageCell.self, forCellReuseIdentifier: CWMessageType.voice.identifier())

        tableView.register(CWTimeMessageCell.self, forCellReuseIdentifier: CWTimeMessageCell.identifier)
    }
    
    
    //MARK: UI属性
    /// TableView
    lazy var tableView: UITableView = {
        let frame = CGRect(x: 0, y: 0,
                           width: kScreenWidth, height: kScreenHeight-45)
        let tableView = UITableView(frame: frame, style: .plain)
        tableView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        tableView.backgroundColor = UIColor.tableViewBackgroundColor()
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

extension CWBaseMessageController {
    
    func refreshLocalMessage() {
        // 先将此条对话的未读条数设置0
        conversation.markAllMessagesAsRead()
    }
    
    func formatMessages(_ messages: [CWChatMessage]) -> [AnyObject] {
        
        var messageModelList = [AnyObject]()
        for message in messages {
            let interval = messageTimeIntervalTag - message.timestamp
            if messageTimeIntervalTag < 0 ||
                fabs(interval) > 60 {
                
                let messageDate = Date(timeIntervalSince1970: message.timestamp)
                let timeStr = " "+ChatTimeTool.timeStringFromSinceDate(messageDate)+" "
                
                messageModelList.append(timeStr as AnyObject)
                self.messageTimeIntervalTag = message.timestamp
            }
            
            let messageModel = CWChatMessageModel(message: message)
            messageModelList.append(messageModel)
            
        }
        return messageModelList
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
extension CWBaseMessageController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let message = messageList[indexPath.row]
        guard let messageModel = message as? CWChatMessageModel else {
            let timeCell = tableView.dequeueReusableCell(withIdentifier: CWTimeMessageCell.identifier) as! CWTimeMessageCell
            timeCell.timeLabel.text = message as? String
            return timeCell
        }
        let identifier = messageModel.message.messageType.identifier()
    
        // 时间和tip消息 是例外的种类 以后判断
        let messageCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! CWChatMessageCell
        messageCell.delegate = self
        messageCell.updateMessage(messageModel)
        messageCell.updateState()
        return messageCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let message = messageList[indexPath.row]
        
        guard let messageModel = message as? CWChatMessageModel else {
            return 30.0
        }
        return messageModel.messageFrame.heightOfCell
    }
    
}


// MARK: - CWChatManagerDelegate
extension CWBaseMessageController: CWChatManagerDelegate {
    
    func messageStatusDidChange(_ message: CWChatMessage, error: CWChatError?) {
        
    }
    
    func messagesDidReceive(_ message: CWChatMessage) {
        let messageModel = CWChatMessageModel(message: message)
        messageList.append(messageModel)
        
        self.tableView.reloadData()
    }
    
}


// MARK: - CWChatMessageCellDelegate
extension CWBaseMessageController: CWChatMessageCellDelegate {
    func messageCellUserAvatarDidClick(_ userId: String) {
        log.debug("cell头像 点击...\(userId)")
    }
    
    func messageCellDidTap(_ cell: CWChatMessageCell) {
        
        switch cell.messageModel.message.messageType{
        case .image:
            log.debug("点击图片")
            
        case .voice:
            
            guard let voiceCell = cell as? CWVoiceMessageCell else {
                return
            }
            
            if voiceCell.messageModel.mediaPlayStutus == .playing {
                voiceCell.messageModel.mediaPlayStutus = .played
            } else {
                voiceCell.messageModel.mediaPlayStutus = .playing
            }
            voiceCell.updateState()
            log.debug("点击声音")
        default:
            log.debug("其他类型")
        }
    }
    
    func messageCellResendButtonClick(_ cell: CWChatMessageCell) {
        let alert = UIAlertController(title: nil, message: "重发此消息？", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel) { (action) in
            
        }
        let sendAction = UIAlertAction(title: "重发", style: .default) { (action) in
            
        }
        alert.addAction(cancelAction)
        alert.addAction(sendAction)

        self.present(alert, animated: true, completion: nil)
    }
    
    func messageCellDidTapLink(_ cell: CWChatMessageCell, link: URL) {
        let webViewController = CWWebViewController(url: link)
        self.navigationController?.pushViewController(webViewController, animated: true)
    }
    
    func messageCellDidTapPhone(_ cell: CWChatMessageCell, phone: String) {
        let title = "\(phone)可能是一个电话号码，你可以"
        let otherButtonTitle = ["呼叫","复制号码","添加到手机通讯录"]
        let actionSheet = LCActionSheet(title: title, delegate: nil, cancelButtonTitle: "取消", otherButtonTitleArray: otherButtonTitle)
        
        actionSheet.clickedHandle = { (actionSheet, index) in
            
            if index == 0 {
                let phoneString = "telprompt://\(phone)"
                guard let URL = URL(string: phoneString) else {
                    return
                }
                UIApplication.shared.openURL(URL)
            } else if index == 1 {
                UIPasteboard.general.string = phone
            }
            
        }
        actionSheet.show()
    }
}



// MARK: - CWInputToolBarDelegate
extension CWBaseMessageController: CWInputToolBarDelegate {
    //
    func chatInputView(_ inputView: CWInputToolBar, sendText text: String) {
        
        let textObject = CWTextMessageBody(text: text)
        let message = CWChatMessage(targetId: conversation.targetId,
                                    direction: .send,
                                    messageBody: textObject)
        self.sendMessage(message)
    
    }
    
    func chatInputView(_ inputView: CWInputToolBar, image: UIImage) {
        
        let imageName = String.UUIDString()+".jpg"
        let path = kChatUserImagePath+imageName

        FileManager.saveContentImage(image, imagePath: path)
        
        let imageBody = CWImageMessageBody(path: imageName, size: image.size)
        let message = CWChatMessage(targetId: conversation.targetId,
                                    direction: .send,
                                    messageBody: imageBody)

        self.sendMessage(message)
    }
    
    func sendMessage(_ message: CWChatMessage) {
        // 添加当前聊天类型
        message.chatType = self.conversation.type
        
        let messageModel = CWChatMessageModel(message: message)
        self.messageList.append(messageModel)
        
        let indexPath = IndexPath(row: self.messageList.count-1, section: 0)
        
        self.tableView.reloadData()
        updateMessageAndScrollBottom(false)
        
        let chatManager = CWChatClient.share.chatManager
        chatManager.sendMessage(message, progress: { (progress) in
            
            //防止cell 不在显示区域崩溃的问题
            guard let cell = self.tableView.cellForRow(at: indexPath) as? CWChatMessageCell else {
                return
            }
            cell.updateState()
            
        }) { (message, error) in

            let chatManager = CWChatClient.share.chatManager
            chatManager.updateMessage(message, completion: { (message, error) in
                
            })
            // 发送消息成功
            if error == nil {
                
            } else {
                
            }
            
            //防止cell 不在显示区域崩溃的问题
            guard let cell = self.tableView.cellForRow(at: indexPath) as? CWChatMessageCell else {
                return
            }
            cell.updateState()
        }
        
    }
    
}
