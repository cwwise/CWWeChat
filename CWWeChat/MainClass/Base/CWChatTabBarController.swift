//
//  CWChatTabBarController.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/22.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWChatTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewContollers()
        
//        self.tabBar.backgroundImage = CWAsset.Tabbarbackground.image
        // Do any additional setup after loading the view.
    }
    
    func setupViewContollers() {
        
        let titleArray = ["微信", "通讯录", "发现", "我"]
        
        let normalImagesArray = [
            CWAsset.Tabbar_mainframe.image,
            CWAsset.Tabbar_contacts.image,
            CWAsset.Tabbar_discover.image,
            CWAsset.Tabbar_me.image,
            ]
        
        let selectedImagesArray = [
            CWAsset.Tabbar_mainframeHL.image,
            CWAsset.Tabbar_contactsHL.image,
            CWAsset.Tabbar_discoverHL.image,
            CWAsset.Tabbar_meHL.image,
            ]
        
        let viewControllerArray = [
            CWConversationController(),
            CWContactsController(),
            CWDiscoverController(),
            CWMineController()
        ]
        
        let selectAttributes = [NSAttributedStringKey.foregroundColor : UIColor.chatSystemColor()]
        let normalAttributes = [NSAttributedStringKey.foregroundColor : UIColor.lightGray]
        
        var navigationVCArray = [CWChatNavigationController]()
        for (index, controller) in viewControllerArray.enumerated() {
            controller.title = titleArray[index]
            controller.tabBarItem.image = normalImagesArray[index].withRenderingMode(.alwaysOriginal)
            controller.tabBarItem.selectedImage = selectedImagesArray[index].withRenderingMode(.alwaysOriginal)
            controller.tabBarItem.setTitleTextAttributes(normalAttributes, for: UIControlState())
            controller.tabBarItem.setTitleTextAttributes(selectAttributes, for: .selected)
            let navigationController = CWChatNavigationController(rootViewController: controller)
            navigationVCArray.append(navigationController)
        }
        self.viewControllers = navigationVCArray
    }

    deinit {
        log.debug("CWChatTabBarController销毁")
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
