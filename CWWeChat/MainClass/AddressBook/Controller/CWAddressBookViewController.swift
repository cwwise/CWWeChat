//
//  CWAddressBookViewController.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/22.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWAddressBookViewController: UIViewController {

    //用户列表
    var userList = [CWChatUserModel]()
    
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
        tableView.registerClass(ChatFriendCell.self, forCellReuseIdentifier: "cell")
        tableView.tableHeaderView = self.searchController.searchBar
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateFriendList()
    }
    
    func setupUI() {
        self.title = "通讯录"
        self.view.addSubview(tableView)
        self.view.backgroundColor = UIColor.tableViewBackgroundColorl()
    }
    
    func updateFriendList() {
        
        let helper = CWFriendsHelper.shareFriendsHelper
        userList = helper.userList
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}

extension CWAddressBookViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! ChatFriendCell
        cell.userModel = userList[indexPath.row]
        return cell
    }
    
}


extension CWAddressBookViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 54.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}
