//
//  CWPrivacySettingController.swift
//  CWWeChat
//
//  Created by chenwei on 2017/4/12.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class CWPrivacySettingController: CWBaseTableViewController {
    
    lazy var tableViewManager: CWTableViewManager = {
        return CWTableViewManager(tableView: self.tableView)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "隐私"
        setupItemData()
        // Do any additional setup after loading the view.
    }
    
}


extension CWPrivacySettingController {
    func setupItemData() {
        
        let item1 = CWBoolItem(title: "加我为好友时需要验证", value: true)
        let section1 = CWTableViewSection(items: [item1])
        
        let item2 = CWTableViewItem(title: "添加我的方式")
        let item3 = CWBoolItem(title: "向我推荐通讯录好友", value: true)
        let section2FooterTitle = "开启后，为你推荐已经开通微信的手机联系人。"
        let section2 = CWTableViewSection(footerTitle:section2FooterTitle,items: [item2,item3])

        let item4 = CWTableViewItem(title: "通讯录黑名单")
        let section3 = CWTableViewSection(items: [item4])
        
        
        let item5 = CWTableViewItem(title: "不让他(她)看我的朋友圈")
        let item6 = CWTableViewItem(title: "不看他(她)的朋友圈")
        let item7 = CWTableViewItem(title: "允许朋友查看朋友圈的范围", subTitle: "全部")
        let item8 = CWBoolItem(title: "允许陌生人查看十条朋友圈", value: true)
        let section4 = CWTableViewSection(headerTitle:"朋友圈",items: [item5,item6, item7, item8])

        let item9 = CWBoolItem(title: "开启朋友圈入口", value: true)
        let section5FooterTitle = "关闭后，将隐藏“发现”中的朋友圈入口，你发过的朋友圈不会清空，朋友仍可以看到。"
        let section5 = CWTableViewSection(footerTitle:section5FooterTitle, items: [item9])

        let item10 = CWBoolItem(title: "朋友圈更新提醒", value: true)
        let section6FooterTitle = "关闭后，有朋友发表朋友圈时，界面下方的”发现“切换按钮上下不再出现红点提示。"
        let section6 = CWTableViewSection(footerTitle:section6FooterTitle, items: [item10])


        let sections = [section1,section2,section3,section4, section5,section6]
        tableViewManager.addSection(contentsOf: sections)
    }
}
