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
        footerLabel.textAlignment = .center
        footerLabel.font = UIFont.systemFont(ofSize: 17)
        footerLabel.textColor = UIColor.gray
        return footerLabel
    }()
    
    //搜索结果
    var searchResultController:CWAddressBookSearchController = {
        let searchResultController = CWAddressBookSearchController()
        return searchResultController
    }()
    
    lazy var tableView:UITableView = {
        let tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.backgroundColor = UIColor.tableViewBackgroundColor()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.sectionIndexBackgroundColor = UIColor.clear
        tableView.sectionIndexColor = UIColor.gray
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        
        tableView.register(CWChatFriendCell.self, forCellReuseIdentifier: "cell")
        tableView.register(CWAddressBookHeaderView.self, forHeaderFooterViewReuseIdentifier: CWAddressBookHeaderView.reuseIdentifier)
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
        NotificationCenter.default.removeObserver(self)
    }
}

extension CWAddressBookViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let group = groupList[section];
        return group.contactCount
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return groupList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CWChatFriendCell
        let group = groupList[(indexPath as NSIndexPath).section];
        cell.userModel = group[(indexPath as NSIndexPath).row]
        return cell
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return self.sectionHeaders
    }
    
}

private let heightOfFriendcell:CGFloat   =   54.0
private let height_header:CGFloat        =   22.0

extension CWAddressBookViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightOfFriendcell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return height_header
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: CWAddressBookHeaderView.reuseIdentifier) as! CWAddressBookHeaderView
        let group = groupList[section];
        headerView.text = group.groupName
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if (indexPath as NSIndexPath).section == 0 {
            let tagVC = CWLabelViewController()
            tagVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(tagVC, animated: true)
            return
        }
        
        let chatVC = CWDetailContactViewController()
        let userModel = groupList[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row]
        chatVC.contactModel = userModel
        chatVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(chatVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        
        if index == 0 {
            tableView.scrollRectToVisible(CGRect(x: 0, y: 0, width: tableView.width, height: tableView.height), animated: false)
            return -1
        }
        return index
    }
    
}
