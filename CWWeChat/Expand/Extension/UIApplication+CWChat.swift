//
//  UIApplication+CWChat.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/23.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

extension UIApplication {
    
    var appBundleName: String {
        return NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleName") as! String
    }
    
    var appBundleID: String {
        return NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleIdentifier") as! String
    }
    
    var appVersion: String {
        return NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString") as! String
    }
    
    var appBuildVersion: String {
        return NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleVersion") as! String
    }
    
}
