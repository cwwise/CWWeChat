//
//  CWMessageNoticeController.swift
//  CWWeChat
//
//  Created by chenwei on 2017/4/12.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class CWMessageNoticeController: CWBaseTableViewController {
    
    lazy var tableViewManager: CWTableViewManager = {
        return CWTableViewManager(tableView: self.tableView)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "新消息通知"
        setupItemData()
        // Do any additional setup after loading the view.
    }
    
}

extension CWMessageNoticeController {
    func setupItemData() {
        
        let item1 = CWBoolItem(title: "接受新消息通知", value: true)
        let item2 = CWBoolItem(title: "接收语音和视频聊天邀请通知", value: true)
        let section1 = CWTableViewSection(items: [item1, item2])
        
        
        let section2FooterTitle = "关闭后，当收到微信消息时，通知提示将不显示发信人和内容摘要。"
        let item3 = CWBoolItem(title: "通知显示消息详情", value: true)        
        let section2 = CWTableViewSection(footerTitle: section2FooterTitle, items: [item3])
        
        let item4 = CWTableViewItem(title: "功能消息免打扰")  
        let section3FooterTitle = "设置系统功能消息提示声音和振动时段。"
        let section3 = CWTableViewSection(footerTitle: section3FooterTitle, items: [item4])
        
        let item5 = CWBoolItem(title: "声音")
        let item6 = CWBoolItem(title: "振动")
        let section4FooterTitle = "当微信在运行时，你可以设置是否需要声音或者振动。"
        let section4 = CWTableViewSection(footerTitle: section4FooterTitle, items: [item5, item6])
        
        
        let sections = [section1,section2,section3,section4]
        tableViewManager.addSection(contentsOf: sections)
    }
}
