//
//  CWSettingViewController.swift
//  CWWeChat
//
//  Created by chenwei on 16/5/31.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

let height_Setting_Cell: CGFloat = 44
let height_Setting_Top_Space: CGFloat = 15
let height_Setting_Bottom_Space: CGFloat = 12

class CWSettingViewController: UITableViewController {

    var settingDataSource = [CWSettingGroup]()
    
    override func loadView() {
        
        self.view = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        
        self.tableView = UITableView(frame: self.view.bounds, style: .grouped)
        self.tableView.backgroundColor = UIColor.tableViewBackgroundColor()
        
        self.tableView.layoutMargins = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        self.tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        self.tableView.separatorColor = UIColor.tableViewCellLineColor()
        
        self.tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: height_Setting_Top_Space))
        self.tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: height_Setting_Bottom_Space))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerCell()
    }
    
    func registerCell() {
        
        self.tableView.register(CWSettingFooterTitleView.self,
                                     forHeaderFooterViewReuseIdentifier: CWSettingFooterTitleView.reuseIdentifier)
        self.tableView.register(CWSettingHeaderTitleView.self,
                                     forHeaderFooterViewReuseIdentifier: CWSettingHeaderTitleView.reuseIdentifier)

        self.tableView.register(CWSettingCell.self, forCellReuseIdentifier: CWSettingCell.reuseIdentifier)
        self.tableView.register(CWSettingButtonCell.self, forCellReuseIdentifier: CWSettingButtonCell.reuseIdentifier)
        self.tableView.register(CWSettingSwitchCell.self, forCellReuseIdentifier: CWSettingSwitchCell.reuseIdentifier)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return settingDataSource.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingDataSource[section].count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let item = settingDataSource[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row]
        let cell = tableView.dequeueReusableCell(withIdentifier: item!.type.reuseIdentifier(), for: indexPath)
        // Configure the cell...
        if let cell = cell as? CWSettingDataProtocol {
            cell.settingItem = item
        }
        
        if let cell = cell as? CWSettingSwitchCell {
            cell.delegate = self
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let group = settingDataSource[section]
        if group.headerTitle == nil {
            return nil
        }
        
        let settingHeaderTitleView = tableView.dequeueReusableHeaderFooterView(withIdentifier: CWSettingHeaderTitleView.reuseIdentifier) as! CWSettingHeaderTitleView
        settingHeaderTitleView.text = group.headerTitle
        return settingHeaderTitleView
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let group = settingDataSource[section]
        if group.footerTitle == nil {
            return nil
        }
        let settingfooterTitleView = tableView.dequeueReusableHeaderFooterView(withIdentifier: CWSettingFooterTitleView.reuseIdentifier) as! CWSettingFooterTitleView
        settingfooterTitleView.text = group.footerTitle
        return settingfooterTitleView
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return height_Setting_Cell
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let group = settingDataSource[section]
        return group.footerHeight
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let group = settingDataSource[section]
        return group.headerHeight

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
 
}

extension CWSettingViewController: CWSettingSwitchCellDelegate {
    func settingSwitchCellForItem(_ item: CWSettingItem, didChangeStatus status: Bool) {
        
    }
}
