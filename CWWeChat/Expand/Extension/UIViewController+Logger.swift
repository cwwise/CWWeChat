//
//  UIViewController+Logger.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/29.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

extension UIViewController {
    open override class func initialize() {
        struct Static {
            static var token: Int = 0
        }
        
        // make sure this isn't a subclass
        if self !== UIViewController.self {
            return
        }
        
        let justAOneTimeThing: () = {
            let originalSelector = #selector(UIViewController.viewWillAppear(_:))
            let swizzledSelector = #selector(UIViewController.cw_viewWillAppear(_:))
            swizzledMethod(originalSelector, swizzledSelector: swizzledSelector)
            
            
            let originalDisSelector = #selector(UIViewController.viewWillDisappear(_:))
            let swizzledDisSelector = #selector(UIViewController.cw_viewWillDisappear(_:))
            swizzledMethod(originalDisSelector, swizzledSelector: swizzledDisSelector)
        }()
        
        justAOneTimeThing
    }
    
    fileprivate class func swizzledMethod(_ originalSelector: Selector, swizzledSelector: Selector) {
        let originalMethod = class_getInstanceMethod(self, originalSelector)
        let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
        
        let didAddMethod = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
        
        if didAddMethod {
            class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    }
    
    // MARK: - Method Swizzling
    
    func cw_viewWillAppear(_ animated: Bool) {
        self.cw_viewWillAppear(animated)
        if let _ = self.classForKeyedArchiver {
//            print("viewWillAppear: \(name)")
            // TODO: Track the user action that is important for you.

        } else {
//            print("viewWillAppear: \(self)")
            // TODO: Track the user action that is important for you.

        }
    }
    
    func cw_viewWillDisappear(_ animated: Bool) {
        self.cw_viewWillDisappear(animated)
        if let _ = self.classForKeyedArchiver {
//            print("viewWillDisAppear: \(name)")
        } else {
//            print("viewWillDisAppear: \(self)")
        }
    }
}
