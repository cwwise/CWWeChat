//
//  CWCommonSettingController.swift
//  CWWeChat
//
//  Created by chenwei on 2017/4/12.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class CWCommonSettingController: CWBaseTableViewController {
    
    lazy var tableViewManager: CWTableViewManager = {
        return CWTableViewManager(tableView: self.tableView)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "通用"
        setupItemData()
        // Do any additional setup after loading the view.
    }
}

extension CWCommonSettingController {
   
    func setupItemData() {
        let item1 = CWTableViewItem(title: "多语言")
        let section1 = CWTableViewSection(items: [item1])

        let item2 = CWTableViewItem(title: "字体大小")
        let item3 = CWTableViewItem(title: "聊天背景")
        let item4 = CWTableViewItem(title: "我的表情")
        let item5 = CWTableViewItem(title: "照片和视频")
        let section2 = CWTableViewSection(items: [item2, item3, item4, item5])

        let item6 = CWBoolItem(title: "听筒模式", value: false)
        let section3 = CWTableViewSection(items: [item6])

        let item7 = CWTableViewItem(title: "功能")
        let section4 = CWTableViewSection(items: [item7])

        let item8 = CWTableViewItem(title: "聊天记录迁移")
        let item9 = CWTableViewItem(title: "存储空间")
        let section5 = CWTableViewSection(items: [item8, item9])

        let item10 = CWButtonItem(title: "清空聊天记录")
        let section6 = CWTableViewSection(items: [item10])

        let sections = [section1,section2,section3,section4,section5,section6]
        tableViewManager.addSection(contentsOf: sections)
    }
}

