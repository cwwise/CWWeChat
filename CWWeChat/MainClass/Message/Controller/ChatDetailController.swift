//
//  ChatDetailController.swift
//  CWWeChat
//
//  Created by wei chen on 2017/4/10.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import TableViewManager

class ChatDetailController: CWBaseTableViewController {

    lazy var tableViewManager: TableViewManager = {
        let tableViewManager = TableViewManager(tableView: self.tableView)
        tableViewManager.delegate = self
        tableViewManager.dataSource = self
        return tableViewManager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "聊天详情"       
        setupSignleChatItems()
    }
  
    func setupSignleChatItems() {
        
        let item1 = BoolItem(title: "置顶聊天", value: false ) { (item) in
            
        }
        let item2 = BoolItem(title: "消息免打扰", value: false) { (item) in
            
        }
        let section1 = Section(items: [item1, item2])
        
        let item2_1 = Item(title: "聊天文件")
        let item3 = Item(title: "设置当前聊天背景")
        let item4 = Item(title: "查找聊天内容")
        let section2 = Section(items: [item2_1, item3, item4])

        let item5 = Item(title: "清空聊天记录")
        let section3 = Section(items: [item5])

        let item6 = Item(title: "投诉")
        let section4 = Section(items: [item6])

        tableViewManager.append(contentsOf: [section1, section2, section3, section4])
    }
    
    func setupGroupChatItems() {

        let item1 = Item(title: "群聊名称", subTitle: "demo")
        let item2 = Item(title: "群二维码")
        let _ = Item(title: "群公告")
        tableViewManager.append(itemsOf: [item1, item2])
        
        let item4 = BoolItem(title: "消息免打扰", value: false)
        let item5 = BoolItem(title: "置顶聊天", value: false)
        let item6 = BoolItem(title: "保存到通讯录", value: false)
        tableViewManager.append(itemsOf: [item4, item5, item6])

        let item7 = Item(title: "我在本群的昵称", subTitle: "武藤游戏boy")
        let item8 = BoolItem(title: "显示群成员昵称", value: true)
        tableViewManager.append(itemsOf: [item7, item8])

        let item9_1 = Item(title: "聊天文件")
        let item9 = Item(title: "设置当前聊天背景")
        let item10 = Item(title: "查找聊天内容")
        let item11 = Item(title: "投诉")
        tableViewManager.append(itemsOf: [item9_1, item9, item10, item11])

        let item12 = Item(title: "删除聊天记录")
        item12.showDisclosureIndicator = false
        tableViewManager.append(itemsOf: [item12])

        let item13 = ButtonItem(title: "删除并退出") { (item) in
            
        }
        tableViewManager.append(itemsOf: [item13])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ChatDetailController: TableViewManagerDelegate {

}

extension ChatDetailController: TableViewManagerDataSource {
    
    
}

