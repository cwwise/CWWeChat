//
//  CWCommonSettingController.swift
//  CWWeChat
//
//  Created by chenwei on 2017/4/12.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import TableViewManager

class CWCommonSettingController: CWBaseTableViewController {
    
    lazy var tableViewManager: TableViewManager = {
        return TableViewManager(tableView: self.tableView)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "通用"
        setupItemData()
        // Do any additional setup after loading the view.
    }

    func setupItemData() {
        let item1 = Item(title: "多语言")
        let section1 = Section(items: [item1])

        let item2 = Item(title: "字体大小")
        let item3 = Item(title: "聊天背景")
        let item4 = Item(title: "我的表情")
        let item5 = Item(title: "照片和视频")
        let section2 = Section(items: [item2, item3, item4, item5])

        let item6 = BoolItem(title: "听筒模式", value: false) { (item) in
            
        }
        let section3 = Section(items: [item6])

        let item7 = Item(title: "功能")
        let section4 = Section(items: [item7])

        let item8 = Item(title: "聊天记录迁移")
        let item9 = Item(title: "存储空间")
        let section5 = Section(items: [item8, item9])

        let item10 = ButtonItem(title: "清空聊天记录")
        let section6 = Section(items: [item10])

        let sections = [section1,section2,section3,section4,section5,section6]
        tableViewManager.append(contentsOf: sections)
    }
}

