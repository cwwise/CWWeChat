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

        // Do any additional setup after loading the view.
    }

    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
