//
//  CWGroupChatController.swift
//  CWWeChat
//
//  Created by chenwei on 2017/4/8.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import ChatKit

class CWGroupChatController: ConversationListController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "群聊"

        fetchGroupChat()
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createGroupChat))
        self.navigationItem.rightBarButtonItem = barButtonItem
    }
    
    @objc func createGroupChat() {

    }
    
    // TODO: 应该只显示本地保存的群聊，后期修改
    func fetchGroupChat() {
       

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
