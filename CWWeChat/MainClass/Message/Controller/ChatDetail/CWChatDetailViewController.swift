//
//  CWChatDetailViewController.swift
//  CWWeChat
//
//  Created by chenwei on 16/7/6.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWChatDetailViewController: CWSettingViewController {

    var contactModel: CWContactUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "聊天详情"

        self.settingDataSource = CWChatDetailHelper.chatDetailDataByUserInfo(contactModel)
        // Do any additional setup after loading the view.
    }
    
    override func registerCell() {
        super.registerCell()
        
        self.tableView.registerClass(CWUserGroupCell.self, forCellReuseIdentifier: CWUserGroupCell.reuseIdentifier)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 && indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(CWUserGroupCell.reuseIdentifier) as! CWUserGroupCell
            
            return cell
        }
        
        return super.tableView(tableView, cellForRowAtIndexPath: indexPath)
    }

}
