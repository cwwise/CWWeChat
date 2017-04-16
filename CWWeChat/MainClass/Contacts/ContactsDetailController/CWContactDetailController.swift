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
        tableViewManager.addSection(itemsOf: [item1])

        let item2 = CWTableViewItem(title: "设置备注和标签")
        tableViewManager.addSection(itemsOf: [item2])

        let item3 = CWTableViewItem(title: "地区")
        let item4 = CWTableViewItem(title: "个人相册")
        item4.cellHeight = 87
        
        let item5 = CWTableViewItem(title: "更多")
        tableViewManager.addSection(itemsOf: [item3, item4, item5])

        let item6 = CWButtonItem(title: "发消息", style: .commit)
        let item7 = CWButtonItem(title: "视频聊天", style: .commit)
        let _ = CWTableViewSection(items: [item6, item7])
//        tableViewManager.addSection(section)
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
                                                     for: indexPath) as! CWContactInfoCell
            let model = CWContactModel(userId: "haohao", username: "haohao")
            model.nickname = "陈威"
            model.avatarURL = "\(kHeaderImageBaseURLString)\(model.userId).jpg"

            cell.userModel = model
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

