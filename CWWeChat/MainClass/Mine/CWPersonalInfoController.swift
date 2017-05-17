//
//  CWPersonalInfoController.swift
//  CWWeChat
//
//  Created by chenwei on 2017/4/12.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

/// 个人信息
class CWPersonalInfoController: CWBaseTableViewController {
    
    lazy var tableViewManager: CWTableViewManager = {
        let tableViewManager = CWTableViewManager(tableView: self.tableView)
        tableViewManager.delegate = self
        return tableViewManager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "个人信息"
        setupItemData()
        // Do any additional setup after loading the view.
    }
}

extension CWPersonalInfoController {
    func setupItemData() {

        let avatarItem = CWTableViewItem(title: "头像")
        avatarItem.cellHeight = 87
        avatarItem.rightImageURL = URL(string: "\(kImageBaseURLString)chenwei.jpg")

        let nikename = "武藤游戏boy"
        let nikenameItem = CWTableViewItem(title: "名字", subTitle: nikename)
        let usernameItem = CWTableViewItem(title: "微信号", subTitle: "chenwei")
        usernameItem.showDisclosureIndicator = false
        
        let qrCodeItem = CWTableViewItem(title: "我的二维码")
        let locationItem = CWTableViewItem(title: "我的地址")

        let section1 = CWTableViewSection(items: [avatarItem, nikenameItem, usernameItem, qrCodeItem, locationItem])

        let sexItem = CWTableViewItem(title: "性别", subTitle: "男")
        let cityItem = CWTableViewItem(title: "地区", subTitle: "中国")
        let mottoItem = CWTableViewItem(title: "个性签名", subTitle: "hello world")
        
        let section2 = CWTableViewSection(items: [sexItem, cityItem, mottoItem])

        tableViewManager.addSection(contentsOf: [section1, section2])

    }
}

extension CWPersonalInfoController: CWTableViewManagerDelegate {
    
    
    
}
