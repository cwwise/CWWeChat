//
//  CWChatConst.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/22.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import Foundation
import UIKit

let kScreenSize = UIScreen.main.bounds.size
let kScreenWidth = UIScreen.main.bounds.size.width
let kScreenHeight = UIScreen.main.bounds.size.height
let kScreenScale = UIScreen.main.scale

let kIsiphoneX = UIApplication.shared.statusBarFrame.height > 20

let kNavigationBarHeight: CGFloat = kIsiphoneX ? 88 : 64
let kScreenBottomHeight: CGFloat = kIsiphoneX ? 34: 0

let kDefaultHeadImage = UIImage(named: "default_head")

public let kImageBaseURLString = "http://qiniu.cwwise.com/"

//MARK:- UI相关
public struct ChatSessionCellUI {
    static let headerImageViewLeftPadding: CGFloat = 10.0
    static let headerImageViewTopPadding: CGFloat = 10.0
}

// Kingfisher: https://github.com/onevcat/Kingfisher/blob/master/Sources/ThreadHelper.swift
extension DispatchQueue {
    // This method will dispatch the `block` to self.
    // If `self` is the main queue, and current thread is main thread, the block
    // will be invoked immediately instead of being dispatched.
    func safeAsync(_ block: @escaping () -> Void) {
        if self === DispatchQueue.main && Thread.isMainThread {
            block()
        } else {
            async { block() }
        }
    }
}

typealias Task = (_ cancel: Bool) -> Void

@discardableResult func DispatchQueueDelay(_ time: TimeInterval, task: @escaping () -> Void) -> Task? {

    func dispatch_later(block: @escaping () -> Void) {
        let t = DispatchTime.now() + time
        DispatchQueue.main.asyncAfter(deadline: t, execute: block)
    }
    var closure: (() -> Void)? = task
    var result: Task?
    
    let delayedClosure: Task = {
        cancel in
        if let internalClosure = closure {
            if cancel == false {
                DispatchQueue.main.async(execute: internalClosure)
            }
        }
        closure = nil
        result = nil
    }
    
    result = delayedClosure
    
    dispatch_later {
        if let delayedClosure = result {
            delayedClosure(false)
        }
    }
    return result
}
