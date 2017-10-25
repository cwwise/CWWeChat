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

    let groupManager = ChatClient.share.groupManager

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "群聊"

        fetchGroupChat()
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createGroupChat))
        self.navigationItem.rightBarButtonItem = barButtonItem
        
        groupManager.addGroupDelegate(self, delegateQueue: DispatchQueue.main)
    }
    
    @objc
    func createGroupChat() {
        let options = GroupOptions()
        groupManager.createGroup(title: "测试数据", invitees: [], message: "邀请朋友", setting: options, completion: nil)
    }
    
    //
    func fetchGroupChat() {
        groupManager.fetchJoinGroups()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CWGroupChatController: GroupManagerDelegate {
    
    func groupListDidUpdate(_ groupList: [Group]) {
        print(groupList)
    }
    
}
