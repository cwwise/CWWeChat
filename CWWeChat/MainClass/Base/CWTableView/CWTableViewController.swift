//
//  CWTableViewController.swift
//  CWWeChat
//
//  Created by chenwei on 16/8/1.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.tableViewBackgroundColor()
        self.tableView.tableFooterView = UIView()


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}
