//
//  CWChatNavigationController.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/22.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit
import ChameleonFramework

class CWChatNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //#Bug 需要解决，如果设置为false，则在好友搜索部分时，遇到问题
        //self.navigationBar.translucent = false
        
        let color = UIColor(hexString: "#141414")
        self.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationBar.barTintColor = color
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        
        // Do any additional setup after loading the view.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
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
