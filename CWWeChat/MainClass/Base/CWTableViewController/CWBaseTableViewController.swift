//
//  CWBaseTableViewController.swift
//  CWWeChat
//
//  Created by chenwei on 16/8/1.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWBaseTableViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.bounds, style: .grouped)
        tableView.backgroundColor = UIColor.tableViewBackgroundColor()
        
        tableView.layoutMargins = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        tableView.separatorColor = UIColor.tableViewCellLineColor()
        
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 0.01))  
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.tableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}
