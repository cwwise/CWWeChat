//
//  CWChatDetailViewController.swift
//  CWWeChat
//
//  Created by wei chen on 2017/4/10.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class CWChatDetailViewController: CWBaseTableViewController {

    lazy var tableViewManager: CWTableViewManager = {
        let tableViewManager = CWTableViewManager(tableView: self.tableView)
        tableViewManager.delegate = self
        tableViewManager.dataSource = self
        return tableViewManager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "聊天详情"       
        setupSignleChatItems()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension CWChatDetailViewController {
    
    func setupSignleChatItems() {
        
        let item1 = CWBoolItem(title: "置顶聊天", value: false)
        let item2 = CWBoolItem(title: "消息免打扰", value: false)
        let section1 = CWTableViewSection(items: [item1, item2])
        
        let item2_1 = CWTableViewItem(title: "聊天文件")
        let item3 = CWTableViewItem(title: "设置当前聊天背景")
        let item4 = CWTableViewItem(title: "查找聊天内容")
        let section2 = CWTableViewSection(items: [item2_1, item3, item4])

        let item5 = CWTableViewItem(title: "清空聊天记录")
        let section3 = CWTableViewSection(items: [item5])

        let item6 = CWTableViewItem(title: "投诉")
        let section4 = CWTableViewSection(items: [item6])

        self.tableViewManager.addSection(contentsOf: [section1, section2, section3, section4])
    }
    
    
    func setupGroupChatItems() {

        let item1 = CWTableViewItem(title: "群聊名称", subTitle: "demo")
        let item2 = CWTableViewItem(title: "群二维码")
        let _ = CWTableViewItem(title: "群公告")
        tableViewManager.addSection(itemsOf: [item1, item2])
        
        let item4 = CWBoolItem(title: "消息免打扰", value: false)
        let item5 = CWBoolItem(title: "置顶聊天", value: false)
        let item6 = CWBoolItem(title: "保存到通讯录", value: false)
        tableViewManager.addSection(itemsOf: [item4, item5, item6])

        let item7 = CWTableViewItem(title: "我在本群的昵称", subTitle: "武藤游戏boy")
        let item8 = CWBoolItem(title: "显示群成员昵称", value: true)
        tableViewManager.addSection(itemsOf: [item7, item8])

        let item9_1 = CWTableViewItem(title: "聊天文件")
        let item9 = CWTableViewItem(title: "设置当前聊天背景")
        let item10 = CWTableViewItem(title: "查找聊天内容")
        let item11 = CWTableViewItem(title: "投诉")
        tableViewManager.addSection(itemsOf: [item9_1, item9, item10, item11])

        let item12 = CWTableViewItem(title: "删除聊天记录")
        item12.showDisclosureIndicator = false
        tableViewManager.addSection(itemsOf: [item12])

        let item13 = CWButtonItem(title: "删除并退出", style: .operate(.delete))
        tableViewManager.addSection(itemsOf: [item13])

    }
    
}

extension CWChatDetailViewController: CWTableViewManagerDelegate {

}

extension CWChatDetailViewController: CWTableViewManagerDataSource {
    
    
}

