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


// stolen from Kingfisher: https://github.com/onevcat/Kingfisher/blob/master/Sources/ThreadHelper.swift
extension DispatchQueue {
    // This method will dispatch the `block` to self.
    // If `self` is the main queue, and current thread is main thread, the block
    // will be invoked immediately instead of being dispatched.
    func safeAsync(_ block: @escaping ()->()) {
        if self === DispatchQueue.main && Thread.isMainThread {
            block()
        } else {
            async { block() }
        }
    }
}


