//
//  CWMineSettingViewController.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/23.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWMineSettingViewController: CWSettingViewController {

    var viewControllerArray = [[UIViewController]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "设置"
        
        let accountSettingVC = CWAccountSafetyViewController()
        viewControllerArray.append([accountSettingVC])
        
        let messageSettingVC = CWMessageInformSettingController()
        let privacySettingVC = CWPrivacySettingViewController()
        let commonSettingVC = CWCommonSettingViewController()
        viewControllerArray.append([messageSettingVC,privacySettingVC,commonSettingVC])
        
        let helpSettingVC = CWHelpAndFeedbackViewController()
        let aboutVC = CWAboutViewController()
        viewControllerArray.append([helpSettingVC, aboutVC])
        
        
        let helper = CWMineSettingHelper()
        self.settingDataSource = helper.mineSettingData
        
        // Do any additional setup after loading the view.
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

extension CWMineSettingViewController {
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        super.tableView(tableView, didSelectRowAtIndexPath: indexPath)
        
        if indexPath.section == 3 {
            
            return
        }
        
        let viewController = viewControllerArray[indexPath.section][indexPath.row]
        self.navigationController?.pushViewController(viewController, animated: true)
        
        
    }
}
