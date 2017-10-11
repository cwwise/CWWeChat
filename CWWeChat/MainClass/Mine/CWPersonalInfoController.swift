//
//  CWPersonalInfoController.swift
//  CWWeChat
//
//  Created by chenwei on 2017/4/12.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import ChatClient
import TableViewManager

/// 个人信息
class CWPersonalInfoController: CWBaseTableViewController {
    
    let contactManager = ChatClient.share.contactManager
    
    lazy var tableViewManager: TableViewManager = {
        let tableViewManager = TableViewManager(tableView: self.tableView)
        tableViewManager.delegate = self
        return tableViewManager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "个人信息"
        setupItemData()
        
        let rightItem = UIBarButtonItem(title: "提交", style: .done, target: self, action: #selector(updateUserInfo))
        self.navigationItem.rightBarButtonItem = rightItem
        
        contactManager.addContactDelegate(self, delegateQueue: DispatchQueue.main)
    }
    
    @objc func updateUserInfo() {
        
        
        
    }
    
    deinit {
        contactManager.removeContactDelegate(self)
    }
}

extension CWPersonalInfoController {
    func setupItemData() {

        let avatarItem = Item(title: "头像")
        avatarItem.cellHeight = 87
       // avatarItem.rightImageURL = URL(string: "\(kImageBaseURLString)chenwei.jpg")

        let nikename = "武藤游戏boy"
        let nikenameItem = Item(title: "名字", subTitle: nikename)
        let usernameItem = Item(title: "微信号", subTitle: "chenwei")
        usernameItem.disableHighlight = true
        usernameItem.showDisclosureIndicator = false
        
        let qrCodeItem = Item(title: "我的二维码")
        let locationItem = Item(title: "我的地址")

        tableViewManager.append(itemsOf: [avatarItem, nikenameItem, usernameItem, qrCodeItem, locationItem])

        let sexItem = Item(title: "性别", subTitle: "男")
        let cityItem = Item(title: "地区", subTitle: "中国")
        let mottoItem = Item(title: "个性签名", subTitle: "hello world")
        
        tableViewManager.append(itemsOf: [sexItem, cityItem, mottoItem])
    }
}

extension CWPersonalInfoController: TableViewManagerDelegate {
    
    
    
}

extension CWPersonalInfoController: ContactManagerDelegate {
    func onUserInfoChanged(user: User) {

    }
}

