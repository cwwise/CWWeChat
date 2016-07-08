//
//  CWMineInfoViewController.swift
//  CWWeChat
//
//  Created by chenwei on 16/7/8.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit
      
class CWMineInformationViewController: CWSettingViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "个人信息"
        let user = CWUserAccount.sharedUserAccount().chatuser
        let helper = CWMineInformationHelper(userInfo: user)
        self.settingDataSource = helper.mineInfoData
        // Do any additional setup after loading the view.
    }
    
    override func registerCell() {
        super.registerCell()
        self.tableView.registerClass(CWMineInformationAvatarCell.self, forCellReuseIdentifier: CWMineInformationAvatarCell.reuseIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CWMineInformationViewController {
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let item = self.settingDataSource[indexPath.section][indexPath.row]
        if item?.title == "头像" {
            let cell = tableView.dequeueReusableCellWithIdentifier(CWMineInformationAvatarCell.reuseIdentifier) as! CWMineInformationAvatarCell
            cell.settingItem = item
            return cell
        }
        
        return super.tableView(tableView, cellForRowAtIndexPath: indexPath)
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return 85.0
        }
        return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
    }
    
}

