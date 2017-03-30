//
//  CWMulticastDelegateNode.swift
//  CWWeChat
//
//  Created by chenwei on 2017/3/30.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import Foundation

class CWMulticastDelegateNode<T: NSObject>: NSObject {
    
    weak var delegate: T?
    
    var delegateQueue: DispatchQueue
    
    init(delegate: T, delegateQueue: DispatchQueue) {
        self.delegate = delegate
        self.delegateQueue = delegateQueue
    }
}
