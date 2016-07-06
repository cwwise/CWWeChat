//
//  CWInformationViewController.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/28.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWInformationViewController: UITableViewController {

    var dataSource = [[CWInformationModel]]()
    
    override func loadView() {
        
        self.view = UIView(frame: CGRect(x: 0, y: 0, width: Screen_Width, height: Screen_Height))
        
        self.tableView = UITableView(frame: self.view.bounds, style: .Grouped)
        self.tableView.backgroundColor = UIColor.tableViewBackgroundColor()
        
        self.tableView.layoutMargins = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        self.tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        self.tableView.separatorColor = UIColor.tableViewCellLineColor()
        self.tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: Screen_Width, height: 20))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        registerCell()
        // Do any additional setup after loading the view.
    }
    
    func registerCell() {
        self.tableView.registerClass(CWInformationCell.self, forCellReuseIdentifier: CWInformationCell.reuseIdentifier)
        self.tableView.registerClass(CWInformationButtonCell.self, forCellReuseIdentifier: CWInformationButtonCell.reuseIdentifier)
        self.tableView.registerClass(CWInformationHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: CWInformationHeaderFooterView.reuseIdentifier)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        CWLogDebug("\(self.classForCoder)销毁")
    }


}

// MARK: - UITableViewDataSource
extension CWInformationViewController {
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let menuItem = dataSource[indexPath.section][indexPath.row]
        if menuItem.type == .Button {
            let cell = tableView.dequeueReusableCellWithIdentifier(CWInformationButtonCell.reuseIdentifier) as! CWInformationButtonCell
            cell.informationModel = menuItem
            cell.delegate = self
            return cell
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(CWInformationCell.reuseIdentifier, forIndexPath: indexPath) as! CWInformationCell
        cell.informationModel = menuItem
        
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].count
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let menuItem = dataSource[indexPath.section][indexPath.row]
        if menuItem.type == .Button {
            return 55
        }
        return 44.0
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableView.dequeueReusableHeaderFooterViewWithIdentifier(CWInformationHeaderFooterView.reuseIdentifier)
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return tableView.dequeueReusableHeaderFooterViewWithIdentifier(CWInformationHeaderFooterView.reuseIdentifier)
    }
}

// MARK: - UITableViewDelegate
extension CWInformationViewController {
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        
    }
}

extension CWInformationViewController: CWInformationButtonCellDelegate {
    
    func informationButtonCellClicked(info: CWInformationModel) {
        
    }
}
