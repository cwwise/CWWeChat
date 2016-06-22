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
        
        self.view = UIView(frame: CGRect(x: 0, y: 0, width: Screen_Width, height: Screen_Height))
        
        self.tableView = UITableView(frame: self.view.bounds, style: .Grouped)
        self.tableView.backgroundColor = UIColor.tableViewBackgroundColorl()
        
        self.tableView.layoutMargins = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        self.tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        self.tableView.separatorColor = UIColor.tableViewCellLineColor()
        
        self.tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: Screen_Width, height: height_Setting_Top_Space))
        self.tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: Screen_Width, height: height_Setting_Bottom_Space))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerCell()
    }
    
    func registerCell() {
        
        self.tableView.registerClass(CWSettingFooterTitleView.self,
                                     forHeaderFooterViewReuseIdentifier: CWSettingFooterTitleView.identifier)
        self.tableView.registerClass(CWSettingHeaderTitleView.self,
                                     forHeaderFooterViewReuseIdentifier: CWSettingHeaderTitleView.identifier)

        self.tableView.registerClass(CWSettingCell.self, forCellReuseIdentifier: CWSettingCell.identifier)
        self.tableView.registerClass(CWSettingButtonCell.self, forCellReuseIdentifier: CWSettingButtonCell.identifier)
        self.tableView.registerClass(CWSettingSwitchCell.self, forCellReuseIdentifier: CWSettingSwitchCell.identifier)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return settingDataSource.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingDataSource[section].count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let item = settingDataSource[indexPath.section].itemObjectAtIndex(indexPath.row)
        let cell = tableView.dequeueReusableCellWithIdentifier(item.type.reuseIdentifier(), forIndexPath: indexPath)
        // Configure the cell...
        if let cell = cell as? CWSettingDataProtocol {
            cell.settingItem = item
        }
        
        if let cell = cell as? CWSettingSwitchCell {
            cell.delegate = self
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let group = settingDataSource[section]
        if group.headerTitle == nil {
            return nil
        }
        
        let settingHeaderTitleView = tableView.dequeueReusableHeaderFooterViewWithIdentifier(CWSettingHeaderTitleView.identifier) as! CWSettingHeaderTitleView
        settingHeaderTitleView.text = group.headerTitle
        return settingHeaderTitleView
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let group = settingDataSource[section]
        if group.footerTitle == nil {
            return nil
        }
        let settingfooterTitleView = tableView.dequeueReusableHeaderFooterViewWithIdentifier(CWSettingFooterTitleView.identifier) as! CWSettingFooterTitleView
        settingfooterTitleView.text = group.footerTitle
        return settingfooterTitleView
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return height_Setting_Cell
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let group = settingDataSource[section]
        return group.footerHeight
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let group = settingDataSource[section]
        return group.headerHeight

    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
 
}

extension CWSettingViewController: CWSettingSwitchCellDelegate {
    func settingSwitchCellForItem(item: CWSettingItem, didChangeStatus status: Bool) {
        
    }
}
