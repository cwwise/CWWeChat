//
//  CWAddressBookViewController.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/22.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

/**
  通讯录界面
 */
class CWAddressBookViewController: UIViewController {

    //用户列表
    var groupList = [CWContactGroup]()
    var sectionHeaders = [String]()
    
    var contactHelper = CWContactManager.shareContactManager
    
    lazy var searchController: CWSearchController = {
        let searchController = CWSearchController(searchResultsController: self.searchResultController)
        searchController.searchResultsUpdater = self.searchResultController
        searchController.searchBar.placeholder = "搜索"
        searchController.searchBar.delegate = self
        searchController.showVoiceButton = true
        return searchController
    }()
    
    //搜索结果
    var searchResultController:CWAddressBookSearchController = {
        let searchResultController = CWAddressBookSearchController()
        return searchResultController
    }()
    
    lazy var tableView:UITableView = {
        let tableView = UITableView(frame: self.view.bounds, style: .Grouped)
        tableView.backgroundColor = UIColor.tableViewBackgroundColorl()
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(CWChatFriendCell.self, forCellReuseIdentifier: "cell")
        tableView.registerClass(CWAddressBookHeaderView.self, forHeaderFooterViewReuseIdentifier: CWAddressBookHeaderView.identifier)
        tableView.tableHeaderView = self.searchController.searchBar
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
//        contactHelper.dataChangeBlock =
    
    }
    
    func setupUI() {
        self.title = "通讯录"
        self.view.addSubview(tableView)
        self.view.backgroundColor = UIColor.tableViewBackgroundColorl()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}

extension CWAddressBookViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let group = groupList[section];
        return group.contactCount
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return groupList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! CWChatFriendCell
        let group = groupList[indexPath.section];
        cell.userModel = group[indexPath.row]
        return cell
    }
    
}

private let HEIGHT_FRIEND_CELL:CGFloat   =   54.0
private let HEIGHT_HEADER:CGFloat        =   22.0

extension CWAddressBookViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return HEIGHT_FRIEND_CELL
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return HEIGHT_FRIEND_CELL
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}
