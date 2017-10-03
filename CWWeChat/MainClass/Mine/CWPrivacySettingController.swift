//
//  CWPrivacySettingController.swift
//  CWWeChat
//
//  Created by chenwei on 2017/4/12.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import TableViewManager

class CWPrivacySettingController: CWBaseTableViewController {
    
    lazy var tableViewManager: TableViewManager = {
        return TableViewManager(tableView: self.tableView)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "隐私"
        setupItemData()
        // Do any additional setup after loading the view.
    }

    func setupItemData() {
        
        let item1 = BoolItem(title: "加我为好友时需要验证", value: true) { (item) in
            
        }
        tableViewManager.append(itemsOf: item1)
        
        let item2 = Item(title: "添加我的方式")
        let item3 = BoolItem(title: "向我推荐通讯录好友", value: true) { (item) in
            
        }
        
        let section2FooterTitle = "开启后，为你推荐已经开通微信的手机联系人。"
        let section2 = Section(footerTitle: section2FooterTitle, items: [item2, item3])
        tableViewManager.append(section2)
        
        let item4 = Item(title: "通讯录黑名单")
        tableViewManager.append(itemsOf: item4)

        
        let item5 = Item(title: "不让他(她)看我的朋友圈")
        let item6 = Item(title: "不看他(她)的朋友圈")
        let item7 = Item(title: "允许朋友查看朋友圈的范围")
        let item8 = BoolItem(title: "允许陌生人查看十条朋友圈", value: true) { (item) in
            
        }
        let section4 = Section(headerTitle:"朋友圈", items: [item5,item6, item7, item8])
        tableViewManager.append(section4)

        let item9 = BoolItem(title: "开启朋友圈入口", value: true) { (item) in
            
        }
        let section5FooterTitle = "关闭后，将隐藏“发现”中的朋友圈入口，你发过的朋友圈不会清空，朋友仍可以看到。"
        let section5 = Section(footerTitle:section5FooterTitle, items: [item9])
        tableViewManager.append(section5)

        
        let item10 = BoolItem(title: "朋友圈更新提醒", value: true) { (item) in
            
        }
        let section6FooterTitle = "关闭后，有朋友发表朋友圈时，界面下方的”发现“切换按钮上下不再出现红点提示。"
        let section6 = Section(footerTitle:section6FooterTitle, items: [item10])
        tableViewManager.append(section6)

    }
}
