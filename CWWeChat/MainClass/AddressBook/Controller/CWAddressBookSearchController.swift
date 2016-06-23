//
//  CWAddressBookSearchController.swift
//  CWWeChat
//
//  Created by chenwei on 16/5/29.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

let Height_FriendsCell: CGFloat = 54

/// 搜索结果
class CWAddressBookSearchController: UIViewController {

    internal var friendsData:[CWContactUser]?
    private  var searchFriendData = [CWContactUser]()
    
    lazy var tableView:UITableView = {
        let frame = CGRect(x: 0, y: 64, width: Screen_Width, height: Screen_Height-Screen_NavigationHeight)
        let tableView = UITableView(frame: frame, style: .Grouped)
        tableView.backgroundColor = UIColor.whiteColor()
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(CWChatFriendCell.self, forCellReuseIdentifier: "ChatFriendCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(tableView)
//        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor.tableViewBackgroundColorl()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - UITableViewDataSource
extension CWAddressBookSearchController: UITableViewDataSource {
    
    // MARK: - Table view data source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchFriendData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ChatFriendCell") as! CWChatFriendCell
        cell.userModel = self.searchFriendData[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return Height_FriendsCell
    }
    
}

// MARK: - UITableViewDelegate
extension CWAddressBookSearchController: UITableViewDelegate {

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
}

// MARK: - UISearchResultsUpdating
extension CWAddressBookSearchController: UISearchResultsUpdating {
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
    }
}

