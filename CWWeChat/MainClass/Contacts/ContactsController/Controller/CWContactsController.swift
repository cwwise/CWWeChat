//
//  CWContactsController.swift
//  CWWeChat
//
//  Created by chenwei on 2017/3/26.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

/// 联系人
class CWContactsController: UIViewController {

    var contactHelper = CWContactHelper.share

    var groupList = [[CWUserModel]]()
    var sectionHeaders = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        groupList = contactHelper.sortedContactArray
        sectionHeaders = contactHelper.sectionHeaders
        footerLabel.text = "\(contactHelper.contactsData.count)位联系人"
        searchResultController.contactList = contactHelper.contactsData
        
        let block = { (groupListData:[[CWUserModel]], sectionHeadersData:[String], count: Int) -> Void in
            self.groupList = groupListData
            self.sectionHeaders = sectionHeadersData
            self.footerLabel.text = "\(count)位联系人"
            self.tableView.reloadData()
        }
        contactHelper.dataChange = block

    }
    
    func setupUI() {
        self.title = "通讯录"
        self.view.addSubview(tableView)
        self.view.backgroundColor = UIColor.tableViewBackgroundColor()
    }
    
    lazy var footerLabel: UILabel = {
        let frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 40)
        let footerLabel = UILabel(frame: frame)
        footerLabel.textAlignment = .center
        footerLabel.font = UIFont.systemFont(ofSize: 17)
        footerLabel.textColor = UIColor.gray
        return footerLabel
    }()
    
    lazy var searchController: CWSearchController = {
        let searchController = CWSearchController(searchResultsController: self.searchResultController)
        searchController.searchResultsUpdater = self.searchResultController
        searchController.searchBar.placeholder = "搜索"
        searchController.searchBar.delegate = self
        searchController.showVoiceButton = true
        return searchController
    }()
    
    //搜索结果
    var searchResultController: CWSearchResultController = {
        let searchResultController = CWSearchResultController()
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
        tableView.separatorColor = UIColor.tableViewCellLineColor()

        tableView.register(CWContactCell.self, forCellReuseIdentifier: CWContactCell.identifier)
        tableView.register(CWContactHeaderView.self, forHeaderFooterViewReuseIdentifier: CWContactHeaderView.identifier)
        tableView.tableHeaderView = self.searchController.searchBar
        tableView.tableFooterView = self.footerLabel
        
        return tableView
    }()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

private let kHeightOfContactsCell: CGFloat   =   54.0
private let kHeightOfHeader: CGFloat        =   22.0

extension CWContactsController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kHeightOfContactsCell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 { return 0 }
        return kHeightOfHeader
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: CWContactHeaderView.identifier) as! CWContactHeaderView
        headerView.titleLabel.text = sectionHeaders[section-1]
        return headerView
    }
    
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let group = groupList[section]
        return group.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return groupList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CWContactCell.identifier) as! CWContactCell
        let group = groupList[indexPath.section]
        cell.contactModel = group[indexPath.row]
        return cell
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return self.sectionHeaders
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let newFriendVC = CWNewFrinedsController()
                newFriendVC.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(newFriendVC, animated: true)
            } else if indexPath.row == 1 {
                let groupchatVC = CWGroupChatController()
                groupchatVC.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(groupchatVC, animated: true)
            }
        }
        else {
      
            let userId = groupList[indexPath.section][indexPath.row].userId
            let detail = CWContactDetailController(userId: userId)
            detail.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(detail, animated: true)
        }
        
    }
    
}

