//
//  CWMineViewController.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/22.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWMineViewController: CWMenuViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "我"
        
        let mineHelper = CWMineHelper()
        self.dataSource = mineHelper.mineMenuData
        
        self.tableView.registerClass(CWMineUserCell.self, forCellReuseIdentifier: "usercell")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension CWMineViewController {
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 87
        }
        
        return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("usercell", forIndexPath: indexPath) as! CWMineUserCell
            let model = CWContactUser()
            model.userId = "chenwei@chenweiim.com"
            model.nikeName = "陈威"
            model.userName = "chenwei19921222"
            model.avatarURL = "http://o7ve5wypa.bkt.clouddn.com/tom@chenweiim.com"

            cell.userModel = model
            return cell
        }
        return super.tableView(tableView, cellForRowAtIndexPath: indexPath)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        super.tableView(tableView, didSelectRowAtIndexPath: indexPath)
        
        if indexPath.section == 2 {
            let expressionVC = CWExpressionViewController()
            expressionVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(expressionVC, animated: true)

            return
        }
        
        if indexPath.section == 0 {
            let mineInformationVC = CWMineInformationViewController()
            mineInformationVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(mineInformationVC, animated: true)
            return
        }
        
        let settingVC = CWMineSettingViewController()
        settingVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(settingVC, animated: true)
    
    }
}
