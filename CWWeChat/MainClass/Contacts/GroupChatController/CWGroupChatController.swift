//
//  CWGroupChatController.swift
//  CWWeChat
//
//  Created by chenwei on 2017/4/8.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class CWGroupChatController: CWChatConversationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchGroupChat()
    }
    
    // TODO: 应该只显示本地保存的群聊，后期修改
    func fetchGroupChat() {
        let groupManager = CWChatClient.share.groupManager
        groupManager.fetchJoinGroups()   
        
        let jid = "demo@conference.hellochatim.p1.im"
        let conversation = self.chatManager.fecthConversation(chatType: .group, targetId: jid)
        conversationList.append(CWChatConversationModel(conversation: conversation))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
