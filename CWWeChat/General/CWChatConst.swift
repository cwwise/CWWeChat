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
        DDLogDebug(object.description)
    }
//}


// stolen from Kingfisher: https://github.com/onevcat/Kingfisher/blob/master/Sources/ThreadHelper.swift
func dispatch_async_safely_to_main_queue(block: ()->()) {
    dispatch_async_safely_to_queue(dispatch_get_main_queue(), block)
}

// This methd will dispatch the `block` to a specified `queue`.
// If the `queue` is the main queue, and current thread is main thread, the block
// will be invoked immediately instead of being dispatched.
func dispatch_async_safely_to_queue(queue: dispatch_queue_t, _ block: ()->()) {
    if queue === dispatch_get_main_queue() && NSThread.isMainThread() {
        block()
    } else {
        dispatch_async(queue) {
            block()
        }
    }
}




