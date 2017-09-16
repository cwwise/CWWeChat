//
//  CWCollectionViewController.swift
//  CWWeChat
//
//  Created by wei chen on 2017/7/15.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import CWActionSheet

class CWCollectionViewController: UIViewController {

    public var conversation: CWConversation

    convenience public init(targetId: String) {
        let conversation = CWChatClient.share.chatManager.fecthConversation(chatType: .single, targetId: targetId)
        self.init(conversation: conversation)
    }
    
    public init(conversation: CWConversation) {
        self.conversation = conversation
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // 显示时间
    var messageList: [CWMessageModel] = [CWMessageModel]()
        
    var keyboard: CWChatKeyboard = CWChatKeyboard()
    
    lazy var collectionView: UICollectionView = {
        let frame = self.view.bounds
        let layout = CWMessageViewLayout()
        layout.delegate = self
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.alwaysBounceVertical = true
        collectionView.register(CWBaseMessageCell.self, forCellWithReuseIdentifier: CWMessageType.none.identifier)
        collectionView.register(CWBaseMessageCell.self, forCellWithReuseIdentifier: CWMessageType.text.identifier)
        collectionView.register(CWBaseMessageCell.self, forCellWithReuseIdentifier: CWMessageType.image.identifier)
        
        collectionView.register(CWBaseMessageCell.self, forCellWithReuseIdentifier: CWMessageType.voice.identifier)


        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        sendTextMessage(isSend: true)
        sendTextMessage(isSend: false)
        
        sendImageMessage(isSend: true)
        sendImageMessage(isSend: false)
        
        sendVoiceMessage(isSend: true)
        sendVoiceMessage(isSend: false)
    }
    
    func setupUI() {
        self.view.addSubview(collectionView)
        
        var groupList = [EmoticonGroup]()
        if let qqemoticon = EmoticonGroup(identifier: "com.qq.classic") {
            groupList.append(qqemoticon)
        }
        
        if let liemoticon = EmoticonGroup(identifier: "cn.com.a-li") {
            liemoticon.type = .big
            groupList.append(liemoticon)
        }
        
        keyboard.delegate = self
        keyboard.emoticonInputView.loadData(groupList)
        keyboard.moreInputView.delegate = self
        keyboard.associateTableView = collectionView
        self.view.addSubview(keyboard)
        
    }
    
    @objc func sendMessage() {
        let index = arc4random() % 3
        if index == 0 {
            sendTextMessage()
        } else if index == 1 {
            sendImageMessage()
        } else {
            sendVoiceMessage()
        }
        
        
    }
    
    func sendTextMessage(isSend: Bool = false) {
        let message = CWMessage(targetId: conversation.targetId,
                                text: "测试数据\(messageList.count)条")
        message.direction = isSend ? .send : .receive
        let messageModel = CWMessageModel(message: message)
        messageList.append(messageModel)
        
        collectionView.reloadData()
    }
    
    func sendImageMessage(isSend: Bool = false) {
        let url = URL(string: "http://7xsmd8.com1.z0.glb.clouddn.com/cwwechat002.jpg")
        let size = CGSize(width: 200, height: 300)
        let messageBody = CWImageMessageBody(path: nil, originalURL: url, size: size)
        let message = CWMessage(targetId: conversation.targetId, messageBody: messageBody)
        message.direction = isSend ? .send : .receive
        
        let messageModel = CWMessageModel(message: message)
        messageList.append(messageModel)
        
        collectionView.reloadData()
        
    }
    
    func sendVoiceMessage(isSend: Bool = false) {
        
        let messageBody = CWVoiceMessageBody(voiceLength: 30)
        let message = CWMessage(targetId: conversation.targetId, messageBody: messageBody)
        message.direction = isSend ? .send : .receive
        
        let messageModel = CWMessageModel(message: message)
        messageList.append(messageModel)
        
        collectionView.reloadData()
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension CWCollectionViewController {
    /// 滚动到底部
    public func updateMessageAndScrollBottom(_ animated:Bool = true) {
        if messageList.count == 0 {
            return
        }
        let indexPath = IndexPath(row: messageList.count-1, section: 0)
        self.collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
    }
    
}

extension CWCollectionViewController: CWMessageViewLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, itemAt indexPath: IndexPath) -> CWMessageModel {
        return messageList[indexPath.row]
    }
}

extension CWCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let message = messageList[indexPath.row]
        let identifier = message.messageType.identifier
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! CWBaseMessageCell
        cell.delegate = self
        cell.refresh(message: message)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
}

extension CWCollectionViewController: CWBaseMessageCellDelegate {
    

    func messageCellDidTap(_ cell: CWBaseMessageCell) {
        
        guard let message = cell.message else {
            return
        }
        
        switch message.messageType{
        case .image:
            log.debug("点击图片")
            
        case .voice:
            
            guard let voiceView = cell.messageContentView as? VoiceMessageContentView else {
                return
            }
            
            if message.playStatus == .playing {
                message.playStatus = .played
            } else {
                message.playStatus = .playing
            }
            voiceView.updateState()
            log.debug("点击声音")
        default:
            log.debug("其他类型")
        }
    }
    
    func messageCellResendButtonClick(_ cell: CWBaseMessageCell) {
        
    }
    
    /// 头像点击的回调方法
    func messageCellUserAvatarDidClick(_ userId: String) {
        log.debug("cell头像 点击...\(userId)")

    }
    
    func messageCellDidTap(_ cell: CWBaseMessageCell, link: URL) {
        let webViewController = CWWebViewController(url: link)
        self.navigationController?.pushViewController(webViewController, animated: true)
    }
    
    func messageCellDidTap(_ cell: CWBaseMessageCell, phone: String) {
        let title = "\(phone)可能是一个电话号码，你可以"
        let otherButtonTitle = ["呼叫","复制号码","添加到手机通讯录"]
        
        let clickedHandler = { (actionSheet: ActionSheetView, index: Int) in
            
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
        
        let actionSheet = ActionSheetView(title: title, 
                                          cancelButtonTitle: "取消", 
                                          otherButtonTitles: otherButtonTitle,
                                          clickedHandler: clickedHandler)
        
        
        actionSheet.show()
    }
    
}



