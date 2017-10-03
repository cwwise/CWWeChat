//
//  CWContactSettingController.swift
//  CWWeChat
//
//  Created by wei chen on 2017/9/5.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import UIKit
import TableViewManager

class CWContactSettingController: CWBaseTableViewController {

    lazy var tableViewManager: TableViewManager = {
        let tableViewManager = TableViewManager(tableView: self.tableView)
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
        let item1 = Item(title: "设置备注及标签")
        tableViewManager.append(itemsOf: item1)
        
        let item2 = Item(title: "把她推荐给朋友")
        tableViewManager.append(itemsOf: item2)
        
        let item3 = BoolItem(title: "设置为星标用户", value: true) { (item) in
            
        }
        tableViewManager.append(itemsOf: item3)

        let item4 = BoolItem(title: "不让她看我的朋友圈", value: true) { (item) in
            
        }
        let item5 = BoolItem(title: "不看她的朋友圈  ", value: true) { (item) in
            
        }
        tableViewManager.append(itemsOf: item4, item5)

        let item6 = BoolItem(title: "加入黑名单", value: true) { (item) in
            
        }
        let item7 = Item(title: "投诉")
        
        tableViewManager.append(itemsOf: item6, item7)
        
        let frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 80)
        let footerView = UIView(frame: frame)
     
        self.tableView.tableFooterView = footerView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension CWContactSettingController: TableViewManagerDelegate, TableViewManagerDataSource {
    

    
}
