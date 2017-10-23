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
        let textMessageList = textList.map { (text) -> Message in
            let textMessage = TextMessageBody(text: "测试数据")
            return Message(conversationId: conversationId, from: from, body: textMessage)
        }
        
        // 语音
        
        
        // 图片
        
        // 位置
        
        let textModelList = textMessageList.map { return MessageModel(message: $0) }
        self.messageList.append(contentsOf: textModelList)
        self.collectionView.reloadData()
        self.updateMessageAndScrollBottom(false)
    }
    
    @objc func rightBarItemDown(_ barItem: UIBarButtonItem) {
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

