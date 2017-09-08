//
//  CWSearchResultController.swift
//  CWWeChat
//
//  Created by wei chen on 2017/4/3.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

/// 搜索结果
class CWSearchResultController: UIViewController {
    // 原始数据
    public var contactList:[CWUserModel]?
    // 搜索结果
    fileprivate var searchContactResult = [CWUserModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(tableView)
        self.view.backgroundColor = UIColor.tableViewBackgroundColor()
    }

    
    lazy var tableView:UITableView = {
        let frame = CGRect(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight-kNavigationBarHeight)
        let tableView = UITableView(frame: frame, style: .grouped)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CWContactCell.self, forCellReuseIdentifier: CWContactCell.identifier)
        return tableView
    }()

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - UITableViewDataSource
extension CWSearchResultController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchContactResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CWContactCell.identifier) as! CWContactCell
        cell.contactModel = searchContactResult[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kHeight_ContactCell
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

// MARK: - UISearchResultsUpdating
extension CWSearchResultController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let text = searchController.searchBar.text
        searchContactResult.removeAll()
    
        guard let contactList = contactList, let searchText = text else {
            tableView.reloadData()
            return
        }
        
        for user in contactList {
            if user.username.contains(searchText) {
                searchContactResult.append(user)
            }
        }
        tableView.reloadData()
    }
}

