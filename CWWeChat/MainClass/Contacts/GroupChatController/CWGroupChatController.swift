//
//  CWGroupChatController.swift
//  CWWeChat
//
//  Created by chenwei on 2017/4/8.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class CWGroupChatController: CWBaseConversationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "群聊"

        fetchGroupChat()
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createGroupChat))
        self.navigationItem.rightBarButtonItem = barButtonItem
    }
    
    @objc func createGroupChat() {
        
        let groupManager = CWChatClient.share.groupManager
        let setting = CWChatGroupOptions()
        groupManager.createGroup(title: "测试聊天", invitees: [], message: "", setting: setting, completion: nil)
        //let chatroomManager = CWChatClient.share.chatroomManager
       // chatroomManager.createChatroom(title: "测试", invitees: [], message: "")
        
    }
    
    // TODO: 应该只显示本地保存的群聊，后期修改
    func fetchGroupChat() {
        let groupManager = CWChatClient.share.groupManager
        groupManager.fetchJoinGroups()   
        
       // let chatroomManager = CWChatClient.share.chatroomManager
        //chatroomManager.fetchChatrooms()
        
        /*
        let jid = "demo@conference.hellochatim.p1.im"
        let conversation = self.chatManager.fecthConversation(chatType: .group, targetId: jid)
        conversationList.append(CWChatConversationModel(conversation: conversation))
        */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
