//
//  CWGroupChatController.swift
//  CWWeChat
//
//  Created by chenwei on 2017/4/8.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import ChatKit
import ChatClient

class CWGroupChatController: ConversationListController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "群聊"

        fetchGroupChat()
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createGroupChat))
        self.navigationItem.rightBarButtonItem = barButtonItem
    }
    
    @objc
    func createGroupChat() {
        let groupManager = ChatClient.share.groupManager
        let options = GroupOptions()
        groupManager.createGroup(title: "测试数据", invitees: [], message: "邀请朋友", setting: options, completion: nil)
    }
    
    // TODO: 应该只显示本地保存的群聊，后期修改
    func fetchGroupChat() {
       
        let groupManager = ChatClient.share.groupManager
        groupManager.fetchJoinGroups()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
