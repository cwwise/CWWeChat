//
//  CWMulticastDelegate.swift
//  CWWeChat
//
//  Created by chenwei on 2017/3/30.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import Foundation

class CWMulticastDelegate: NSObject {
    
    private var delegateNodes = [CWMulticastDelegateNode]()
    
    func addDelegate(_ delegate: NSObject, delegateQueue: DispatchQueue)  {
        let node = CWMulticastDelegateNode(delegate: delegate, delegateQueue: delegateQueue)
        delegateNodes.append(node)
    }
    
    func removeDelegate(_ delegate: NSObject, delegateQueue: DispatchQueue?)  {
        var index: Int?
        for i in 0..<delegateNodes.count {
            let node = delegateNodes[i]
            if node == delegate {
                node.delegate = nil
                index = i
                break
            }
        }
        
        guard let delegateIndex = index else {
            return
        }
        delegateNodes.remove(at: delegateIndex)
    }
    
    func removeAll() {
        
        for node in delegateNodes {
            node.delegate = nil
        }
        delegateNodes.removeAll()
    }
    
}

