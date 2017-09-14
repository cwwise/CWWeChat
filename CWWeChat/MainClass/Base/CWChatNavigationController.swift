//
//  CWChatNavigationController.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/22.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWChatNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //#Bug 需要解决，如果设置为false，则在好友搜索部分时，遇到问题
        //self.navigationBar.translucent = false
        
        self.navigationBar.tintColor = UIColor.white
        self.navigationBar.barTintColor = UIColor.navigationBarCocor()
        self.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        
        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
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
