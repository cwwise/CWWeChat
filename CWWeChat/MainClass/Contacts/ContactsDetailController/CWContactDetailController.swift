//
//  CWContactDetailController.swift
//  CWWeChat
//
//  Created by wei chen on 2017/4/3.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class CWContactDetailController: CWBaseTableViewController {

    lazy var tableViewManager: CWTableViewManager = {
        let tableViewManager = CWTableViewManager(tableView: self.tableView)
        tableViewManager.delegate = self
        tableViewManager.dataSource = self
        return tableViewManager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "详细资料"

        self.tableView.register(CWContactInfoCell.self, forCellReuseIdentifier: CWContactInfoCell.identifier)
        self.tableView.register(CWContactDetailAlbumCell.self, forCellReuseIdentifier: CWContactDetailAlbumCell.identifier)
        setupData()
    }
    
    func setupData() {
        let item1 = CWTableViewItem(title: "信息")
        item1.cellHeight = 87
        self.tableViewManager.addSection(itemsOf: [item1])

        let item2 = CWTableViewItem(title: "设置备注和标签")
        self.tableViewManager.addSection(itemsOf: [item2])

        let item3 = CWTableViewItem(title: "地区")
        let item4 = CWTableViewItem(title: "个人相册")
        item4.cellHeight = 87
        
        let item5 = CWTableViewItem(title: "更多")
        self.tableViewManager.addSection(itemsOf: [item3, item4, item5])

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension CWContactDetailController: CWTableViewManagerDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell? {

        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CWContactInfoCell.identifier,
                                                     for: indexPath)
            return cell
        } else if indexPath.section == 2 && indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CWContactDetailAlbumCell.identifier,
                                                     for: indexPath)
            return cell
        } else {
            return nil
        }
    }
    
}


extension CWContactDetailController: CWTableViewManagerDelegate {
    
}

