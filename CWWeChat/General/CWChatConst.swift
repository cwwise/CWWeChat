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

let Screen_Size = UIScreen.main.bounds.size
let Screen_Width = UIScreen.main.bounds.size.width
let Screen_Height = UIScreen.main.bounds.size.height

let Screen_NavigationHeight:CGFloat = 64

//class CWLogger {

    func CWLogInfo(_ object: AnyObject) {
        DDLogInfo(object.description)
    }
    
    func CWLogWarn(_ object: AnyObject) {
        DDLogWarn(object.description)
    }
    
    func CWLogError(_ object: AnyObject) {
        DDLogError(object.description)
    }
    
    func CWLogVerbose(_ object: AnyObject) {
        DDLogVerbose(object.description)
    }
    
    func CWLogDebug(_ object: AnyObject) {
        DDLogDebug(object.description)
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




