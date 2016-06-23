//
//  CWAccountSafetyViewController.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/23.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWAccountSafetyViewController: CWSettingViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "账号与安全"
        
        let userModel = CWContactUser()
        let helper = CWAccountSafetyHelper(userModel: userModel)
        self.settingDataSource = helper.safetySettingData
        
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
