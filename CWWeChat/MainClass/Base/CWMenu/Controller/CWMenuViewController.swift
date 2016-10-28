//
//  CWMenuViewController.swift
//  CWWeChat
//
//  Created by chenwei on 16/5/28.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWMenuViewController: UITableViewController {

    var dataSource = [[CWMenuItem]]()
    
    override func loadView() {
        self.view = UIView(frame: CGRect(x: 0, y: 0, width: Screen_Width, height: Screen_Height))
        
        self.tableView = UITableView(frame: self.view.bounds, style: .grouped)
        self.tableView.backgroundColor = UIColor.tableViewBackgroundColor()
        
        self.tableView.layoutMargins = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        self.tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        self.tableView.separatorColor = UIColor.tableViewCellLineColor()
        self.tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: Screen_Width, height: 20))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(CWMenuCell.self, forCellReuseIdentifier: "CWMenuCell")
        // Do any additional setup after loading the view.
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension CWMenuViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CWMenuCell", for: indexPath) as! CWMenuCell
        let menuItem = dataSource[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row]
        cell.menuItem = menuItem
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
}

extension CWMenuViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

