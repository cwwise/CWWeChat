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
    
    lazy var contactHelper: CWContactManager = {
        return CWContactManager.shareContactManager
    }()
    
    lazy var searchController: CWSearchController = {
        let searchController = CWSearchController(searchResultsController: self.searchResultController)
        searchController.searchResultsUpdater = self.searchResultController
        searchController.searchBar.placeholder = "搜索"
        searchController.searchBar.delegate = self
        searchController.showVoiceButton = true
        return searchController
    }()
    
    lazy var footerLabel: UILabel = {
        let frame = CGRect(x: 0, y: 0, width: Screen_Width, height: 50)
       let footerLabel = UILabel(frame: frame)
        footerLabel.textAlignment = .Center
        footerLabel.font = UIFont.systemFontOfSize(17)
        footerLabel.textColor = UIColor.grayColor()
        return footerLabel
    }()
    
    //搜索结果
    var searchResultController:CWAddressBookSearchController = {
        let searchResultController = CWAddressBookSearchController()
        return searchResultController
    }()
    
    lazy var tableView:UITableView = {
        let tableView = UITableView(frame: self.view.bounds, style: .Plain)
        tableView.backgroundColor = UIColor.tableViewBackgroundColor()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.sectionIndexBackgroundColor = UIColor.clearColor()
        tableView.sectionIndexColor = UIColor.grayColor()
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        
        tableView.registerClass(CWChatFriendCell.self, forCellReuseIdentifier: "cell")
        tableView.registerClass(CWAddressBookHeaderView.self, forHeaderFooterViewReuseIdentifier: CWAddressBookHeaderView.reuseIdentifier)
        tableView.tableHeaderView = self.searchController.searchBar
        tableView.tableFooterView = self.footerLabel

        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        self.groupList = contactHelper.sortContactsData
        self.sectionHeaders = contactHelper.sortSectionHeaders
        self.footerLabel.text = "\(contactHelper.contactCount)位联系人"
        self.searchResultController.friendsData = contactHelper.contactsData
        
        let block = { (groupListData:[CWContactGroup], sectionHeadersData:[String], count: Int) -> Void in
            self.groupList = groupListData
            self.sectionHeaders = sectionHeadersData
            self.footerLabel.text = "\(count)位联系人"
            self.tableView.reloadData()
        }
        
        contactHelper.dataChangeBlock = block
    
    }
    
    func setupUI() {
        self.title = "通讯录"
        self.view.addSubview(tableView)
        self.view.backgroundColor = UIColor.tableViewBackgroundColor()
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
    
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return self.sectionHeaders
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
        return HEIGHT_HEADER
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterViewWithIdentifier(CWAddressBookHeaderView.reuseIdentifier) as! CWAddressBookHeaderView
        let group = groupList[section];
        headerView.text = group.groupName
        return headerView
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        
        if index == 0 {
            tableView.scrollRectToVisible(CGRect(x: 0, y: 0, width: tableView.width, height: tableView.height), animated: false)
            return -1
        }
        return index
    }
    
}
