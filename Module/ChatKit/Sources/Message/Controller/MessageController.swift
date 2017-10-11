//
//  MessageController.swift
//  ChatKit
//
//  Created by chenwei on 2017/10/3.
//

import UIKit
import ChatClient

open class MessageController: UIViewController {

    public var conversation: Conversation
    
    public lazy var backgroundImageView: UIImageView = {
        let backgroundImageView = UIImageView()
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.frame = self.view.bounds
        backgroundImageView.clipsToBounds = true
        return backgroundImageView
    }()
    
    convenience public init(conversationId: String) {
        let chatManager = ChatClient.share.chatManager
        let conversation = chatManager.fecthConversation(chatType: .single,
                                                         conversationId: conversationId)
        self.init(conversation: conversation)
    }
    
    public init(conversation: Conversation) {
        self.conversation = conversation
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(backgroundImageView)
        self.view.backgroundColor = UIColor.white
        
        // 获取数据
        
    }

    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}







