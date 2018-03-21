//
//  CWMessageNoticeController.swift
//  CWWeChat
//
//  Created by chenwei on 2017/4/12.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import TableViewManager

class CWMessageNoticeController: CWBaseTableViewController {
    
    lazy var tableViewManager: TableViewManager = {
        return TableViewManager(tableView: self.tableView)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "新消息通知"
        setupItemData()
        // Do any additional setup after loading the view.
    }

    func setupItemData() {
        
        let item1 = BoolItem(title: "接受新消息通知", value: true) { (_) in
            
        }
        let item2 = BoolItem(title: "接收语音和视频聊天邀请通知", value: true) { (_) in
            
        }
        tableViewManager.append(itemsOf: item1,item2)
        
        let section2FooterTitle = "关闭后，当收到微信消息时，通知提示将不显示发信人和内容摘要。"
        let item3 = BoolItem(title: "通知显示消息详情", value: true) { (_) in
            
        }
        let section2 = Section(footerTitle: section2FooterTitle, items: [item3])
        tableViewManager.append(section2)
        
        let item4 = Item(title: "功能消息免打扰")
        let section3FooterTitle = "设置系统功能消息提示声音和振动时段。"
        let section3 = Section(footerTitle: section3FooterTitle, items: [item4])
        tableViewManager.append(section3)

        let item5 = BoolItem(title: "声音") { (_) in
            
        }
        let item6 = BoolItem(title: "振动") { (_) in
            
        }
        let section4FooterTitle = "当微信在运行时，你可以设置是否需要声音或者振动。"
        let section4 = Section(footerTitle: section4FooterTitle, items: [item5, item6])
        tableViewManager.append(section4)
    }
}
