//
//  CWMessageController.swift
//  CWWeChat
//
//  Created by wei chen on 2017/4/10.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import ChatKit
import ChatClient

public class CWMessageController: MessageController {
        
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = rightBarItem
        //背景图
        if let path = Bundle.main.path(forResource: "chat_background", ofType: "png") {
            let image = UIImage(contentsOfFile: path)
            self.backgroundImageView.image = image
        }
        
        setupTestData()
    }
    
    func setupTestData() {
        
        let conversationId = self.conversation.conversationId
        let from = ChatKit.share.currentAccount
        // 文字
        let textList = ["小明，如果你暗恋的女神向你表白，你的第一反应是什么", "生下来吧，算我的。", "。。。。"]
        var tempMessageList = textList.map { (text) -> Message in
            let textMessage = TextMessageBody(text: text)
            return Message(conversationId: conversationId, from: from, body: textMessage)
        }
        
        // 语音
        let voicePath = ""
        let voice1 = VoiceMessageBody(voicePath: voicePath, voiceLength: 40)
        let voiceMessage = Message(conversationId: conversationId, from: from, body: voice1)
        tempMessageList.append(voiceMessage)
        
        // 图片
        let url1 = URL(string: "http://7xsmd8.com1.z0.glb.clouddn.com/cwwechat005.jpg")
        let size1 = CGSize(width: 600, height: 800)
        let image1 = ImageMessageBody(originalURL: url1, size: size1)
        let imageMessage1 = Message(conversationId: conversationId, from: from, body: image1)
        
        // 本地图片
        let path2 = Bundle.main.path(forResource: "cwwechat003", ofType: "jpg")
        let size2 = CGSize(width: 600, height: 800)
        let image2 = ImageMessageBody(path: path2, size: size2)
        let imageMessage2 = Message(conversationId: conversationId, from: from, body: image2)

        tempMessageList.append(imageMessage1)
        tempMessageList.append(imageMessage2)

        // 位置
        let location1 = LocationMessageBody(latitude: 122.0, longitude: 133.0, address: "测试位置")
        let locationMessage1 = Message(conversationId: conversationId, from: from, body: location1)
        tempMessageList.append(locationMessage1)

        let textModelList = tempMessageList.map { return MessageModel(message: $0) }
        self.messageList.append(contentsOf: textModelList)
        
        self.collectionView.reloadData()
        self.scrollToBottom(false)
    }
    
    @objc 
    func rightBarItemDown(_ barItem: UIBarButtonItem) {
        let chatDetailVC = CWChatDetailViewController()
        self.navigationController?.pushViewController(chatDetailVC, animated: true)
    }
    
    lazy var rightBarItem: UIBarButtonItem = {
        let image = self.conversation.type == .single ? CWAsset.Nav_chat_single.image : CWAsset.Nav_chat_single.image
        let rightBarItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(rightBarItemDown(_:)))
        return rightBarItem
    }()
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

