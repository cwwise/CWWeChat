//
//  CWBaseTableViewController.swift
//  CWWeChat
//
//  Created by chenwei on 16/8/1.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWBaseTableViewController: UITableViewController {

    override func loadView() {
        
        self.view = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        self.tableView = UITableView(frame: self.view.bounds, style: .grouped)
        self.tableView.backgroundColor = UIColor.tableViewBackgroundColor()
        
        self.tableView.layoutMargins = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        self.tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        self.tableView.separatorColor = UIColor.tableViewCellLineColor()
        
        self.tableView.tableFooterView = UIView()
        self.tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 10))

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}
