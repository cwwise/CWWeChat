//
//  CWContactSettingController.swift
//  CWWeChat
//
//  Created by wei chen on 2017/9/5.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import UIKit

class CWContactSettingController: CWBaseTableViewController {

    lazy var tableViewManager: CWTableViewManager = {
        let tableViewManager = CWTableViewManager(tableView: self.tableView)
        tableViewManager.delegate = self
        tableViewManager.dataSource = self
        return tableViewManager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "资料设置"
        setupData()
    }
    
    func setupData() {
        let item1 = CWTableViewItem(title: "设置备注及标签")
        tableViewManager.addSection(itemsOf: [item1])
        
        let item2 = CWTableViewItem(title: "把她推荐给朋友")
        tableViewManager.addSection(itemsOf: [item2])
        
        let item3 = CWBoolItem(title: "设置为星标用户", value: true)
        tableViewManager.addSection(itemsOf: [item3])

        let item4 = CWBoolItem(title: "不让她看我的朋友圈", value: true)
        let item5 = CWBoolItem(title: "不看她的朋友圈  ", value: true)
        tableViewManager.addSection(itemsOf: [item4, item5])

        let item6 = CWBoolItem(title: "加入黑名单", value: true)
        let item7 = CWTableViewItem(title: "投诉")
        
        tableViewManager.addSection(itemsOf: [item6, item7])
        
        let frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 80)
        let footerView = UIView(frame: frame)
     
        self.tableView.tableFooterView = footerView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension CWContactSettingController: CWTableViewManagerDelegate, CWTableViewManagerDataSource {
    
    
    
    
}
