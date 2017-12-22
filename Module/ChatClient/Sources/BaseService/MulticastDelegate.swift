//
//  MulticastDelegate.swift
//  ChatClient
//
//  Created by wei chen on 2017/12/22.
//

import Foundation
import XMPPFramework

class MulticastDelegate<T> {
    
    private var multicastDelegate = GCDMulticastDelegate()
    
    func add(_ delegate: T, delegateQueue: DispatchQueue = DispatchQueue.main) {
        multicastDelegate.add(delegate, delegateQueue: delegateQueue)
    }
    
    func remove(_ delegate: T) {
        multicastDelegate.remove(delegate)
    }
    
    func removeAll() {
        multicastDelegate.removeAllDelegates()
    }
    
    func syncExecute(action: (T) -> Void) {
        ///遍历出所有的delegate
        let delegateEnumerator = self.multicastDelegate.delegateEnumerator()
        var delegate: AnyObject?
        var queue: DispatchQueue?
        while delegateEnumerator.getNextDelegate(&delegate, delegateQueue: &queue) == true {
            //执行Delegate的方法
            if let currentDelegate = delegate as? T, let currentQueue = queue {
                currentQueue.sync {
                    action(currentDelegate)
                }
            }
        }
    }
    
    func asyncExecute(action: @escaping (T) -> Void) {
        ///遍历出所有的delegate
        let delegateEnumerator = self.multicastDelegate.delegateEnumerator()
        var delegate: AnyObject?
        var queue: DispatchQueue?
        while delegateEnumerator.getNextDelegate(&delegate, delegateQueue: &queue) == true {
            //执行Delegate的方法
            if let currentDelegate = delegate as? T, let currentQueue = queue {
                currentQueue.async {
                    action(currentDelegate)
                }
            }
        }
    }
}
