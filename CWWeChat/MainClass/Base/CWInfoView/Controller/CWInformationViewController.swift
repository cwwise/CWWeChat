//
//  CWInformationViewController.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/28.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

/**
 好友详情界面基类
 */
class CWInformationViewController: UITableViewController {

    var dataSource = [[CWInformationModel]]()
    
    override func loadView() {
        
        self.view = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        self.tableView = UITableView(frame: self.view.bounds, style: .grouped)
        self.tableView.backgroundColor = UIColor.tableViewBackgroundColor()
        
        self.tableView.layoutMargins = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        self.tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        self.tableView.separatorColor = UIColor.tableViewCellLineColor()
        self.tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 20))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        registerCell()
        // Do any additional setup after loading the view.
    }
    
    func registerCell() {
        self.tableView.register(CWInformationCell.self, forCellReuseIdentifier: CWInformationCell.reuseIdentifier)
        self.tableView.register(CWInformationButtonCell.self, forCellReuseIdentifier: CWInformationButtonCell.reuseIdentifier)
        self.tableView.register(CWInformationHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: CWInformationHeaderFooterView.reuseIdentifier)
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let menuItem = dataSource[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row]
        if menuItem.type == .button {
            let cell = tableView.dequeueReusableCell(withIdentifier: CWInformationButtonCell.reuseIdentifier) as! CWInformationButtonCell
            cell.informationModel = menuItem
            cell.delegate = self
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CWInformationCell.reuseIdentifier, for: indexPath) as! CWInformationCell
        cell.informationModel = menuItem
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let menuItem = dataSource[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row]
        if menuItem.type == .button {
            return 55
        }
        return 44.0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: CWInformationHeaderFooterView.reuseIdentifier)
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: CWInformationHeaderFooterView.reuseIdentifier)
    }
}

// MARK: - UITableViewDelegate
extension CWInformationViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension CWInformationViewController: CWInformationButtonCellDelegate {
    
    func informationButtonCellClicked(_ info: CWInformationModel) {
        
    }
}
