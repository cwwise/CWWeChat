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

let kScreenSize = UIScreen.main.bounds.size
let kScreenWidth = UIScreen.main.bounds.size.width
let kScreenHeight = UIScreen.main.bounds.size.height

let kNavigationBarHeight:CGFloat = 64

//class CWLogger {

    func CWLogInfo(_ object: String) {
        DDLogInfo(object)
    }
    
    func CWLogWarn(_ object: String) {
        DDLogWarn(object)
    }
    
    func CWLogError(_ object: String) {
        DDLogError(object)
    }
    
    func CWLogVerbose(_ object: String) {
        DDLogVerbose(object)
    }
    
    func CWLogDebug(_ object: String) {
        DDLogDebug(object)
    }
//}


// stolen from Kingfisher: https://github.com/onevcat/Kingfisher/blob/master/Sources/ThreadHelper.swift
func dispatch_async_safely_to_main_queue(_ block: @escaping ()->()) {
    dispatch_async_safely_to_queue(DispatchQueue.main, block)
}

// This methd will dispatch the `block` to a specified `queue`.
// If the `queue` is the main queue, and current thread is main thread, the block
// will be invoked immediately instead of being dispatched.
func dispatch_async_safely_to_queue(_ queue: DispatchQueue, _ block: @escaping ()->()) {
    if queue === DispatchQueue.main && Thread.isMainThread {
        block()
    } else {
        queue.async {
            block()
        }
    }
}




