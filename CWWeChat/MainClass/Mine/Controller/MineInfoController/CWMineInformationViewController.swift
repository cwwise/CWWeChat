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
        self.tableView.register(CWMineInformationAvatarCell.self, forCellReuseIdentifier: CWMineInformationAvatarCell.reuseIdentifier)
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = self.settingDataSource[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row]
        if item?.title == "头像" {
            let cell = tableView.dequeueReusableCell(withIdentifier: CWMineInformationAvatarCell.reuseIdentifier) as! CWMineInformationAvatarCell
            cell.settingItem = item
            return cell
        }
        
        return super.tableView(tableView, cellForRowAt: indexPath)
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath as NSIndexPath).section == 0 && (indexPath as NSIndexPath).row == 0 {
            return 85.0
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
}

