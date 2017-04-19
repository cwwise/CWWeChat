//
//  UIStoryboard+Extension.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/28.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    class func mainStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard
    }
    
    class func guideViewController() -> UIViewController {
        let guideViewController = self.mainStoryboard().instantiateViewController(withIdentifier: "CWGuideViewController")
        return guideViewController
    }
    
    class func welcomeViewController() -> UIViewController {
        let welcomeViewController = self.mainStoryboard().instantiateViewController(withIdentifier: "CWRootController")
        return welcomeViewController
    }
    
}
