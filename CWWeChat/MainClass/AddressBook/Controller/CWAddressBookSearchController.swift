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
    fileprivate  var searchFriendData = [CWContactUser]()
    
    lazy var tableView:UITableView = {
        let frame = CGRect(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight-Screen_NavigationHeight)
        let tableView = UITableView(frame: frame, style: .grouped)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CWChatFriendCell.self, forCellReuseIdentifier: "ChatFriendCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(tableView)
//        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor.tableViewBackgroundColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - UITableViewDataSource
extension CWAddressBookSearchController: UITableViewDataSource {
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchFriendData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatFriendCell") as! CWChatFriendCell
        cell.userModel = self.searchFriendData[(indexPath as NSIndexPath).row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Height_FriendsCell
    }
    
}

// MARK: - UITableViewDelegate
extension CWAddressBookSearchController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

// MARK: - UISearchResultsUpdating
extension CWAddressBookSearchController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let text = searchController.searchBar.text
        searchFriendData.removeAll()
        guard let friendsData = friendsData, let searchText = text else {
            tableView.reloadData()
            return
        }
        
        for user in friendsData {
            if user.pinying.contains(searchText) ||
               user.userName!.contains(searchText) ||
               user.nikeName!.contains(searchText){
                
                searchFriendData.append(user)
            }
        }
        tableView.reloadData()
    }
}

