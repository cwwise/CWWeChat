//
//  CWContactDetailController.swift
//  CWWeChat
//
//  Created by wei chen on 2017/4/3.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import TableViewManager
import ChatKit
import ChatClient
import RxCocoa
import RxSwift

class CWContactDetailController: CWBaseTableViewController {

    let bag = DisposeBag()
    
    private var contact: Contact!
    
    lazy var tableViewManager: TableViewManager = {
        let tableViewManager = TableViewManager(tableView: self.tableView)
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

        let barItemImage = UIImage(named: "nav_more")
        let rightBarItem = UIBarButtonItem(image: barItemImage, style: .done, target: self, action: #selector(rightBarItemClick))
        self.navigationItem.rightBarButtonItem = rightBarItem
    }
    
    func setupData() {
        let item1 = Item(title: "")
        item1.cellHeight = 87
        tableViewManager.append(itemsOf: item1)

        let item2 = Item(title: "设置备注和标签")
        tableViewManager.append(itemsOf: item2)

        let item3 = Item(title: "地区")
        let item4 = Item(title: "个人相册")
        item4.cellHeight = 87
        
        let item5 = Item(title: "更多")
        tableViewManager.append(itemsOf: [item3, item4, item5])

        let frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 100)
        let footerView = CWContactDetailFooterView(frame: frame)
        footerView.button.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.goChatController()
            }).disposed(by: bag)
        
        self.tableView.tableFooterView = footerView
    }

    func goChatController() {
        let conversation = Conversation(conversationId: contact.username, type: .single)
        let chatVC = MessageListController(conversation: conversation)
        self.navigationController?.pushViewController(chatVC, animated: true)
    }
    
    @objc func rightBarItemClick() {
        let settingVC = CWContactSettingController()
        self.navigationController?.pushViewController(settingVC, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension CWContactDetailController: TableViewManagerDataSource {
    
    func tableViewManager(_ tableViewManager: TableViewManager, cellForRowAt indexPath: IndexPath) -> UITableViewCell? {

        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CWContactInfoCell.identifier,
                                                     for: indexPath) as! CWContactInfoCell
            cell.userModel = contact
            return cell
        } else if indexPath.section == 2 && indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CWContactDetailAlbumCell.identifier, for: indexPath)
            return cell
        } else {
            return nil
        }
    }
}

extension CWContactDetailController: TableViewManagerDelegate {
    
}
