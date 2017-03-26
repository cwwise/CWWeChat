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
        
        let feedbackURL = URL(string: "https://kf.qq.com/touch/product/wechat_app.html")!
        let helpSettingVC = CWHelpAndFeedbackViewController(url: feedbackURL)
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
    
}

extension CWMineSettingViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        
        if (indexPath as NSIndexPath).section == 3 {
            
            return
        }
        
        let viewController = viewControllerArray[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row]
        self.navigationController?.pushViewController(viewController, animated: true)
        
        
    }
}
