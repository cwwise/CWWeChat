//
//  CWChatConst.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/22.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import Foundation
import UIKit
import CocoaLumberjack

let Screen_Size = UIScreen.mainScreen().bounds.size
let Screen_Width = UIScreen.mainScreen().bounds.size.width
let Screen_Height = UIScreen.mainScreen().bounds.size.height

let Screen_NavigationHeight:CGFloat = 64

//class CWLogger {

    func CWLogInfo(object: AnyObject) {
        DDLogInfo(object.description)
    }
    
    func CWLogWarn(object: AnyObject) {
        DDLogWarn(object.description)
    }
    
    func CWLogError(object: AnyObject) {
        DDLogError(object.description)
    }
    
    func CWLogVerbose(object: AnyObject) {
        DDLogVerbose(object.description)
    }
    
    func CWLogDebug(object: AnyObject) {
        CWLogDebug(object.description)
    }
//}