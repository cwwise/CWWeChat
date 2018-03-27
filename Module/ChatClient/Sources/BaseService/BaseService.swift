//
//  BaseService.swift
//  ChatClient
//
//  Created by wei chen on 2017/12/22.
//

import Foundation
import XMPPFramework

protocol BaseService {
    associatedtype T
    var multicastDelegate: GCDMulticastDelegate { get set }
    
    func addDelegate(_ delegate: T)
    
    func removeDelegate(_ delegate: T)
    
    func deactivate()
    
    func asyncExecute(action: @escaping (T) -> Void)
}

extension BaseService {
    func addDelegate(_ delegate: T) {
        multicastDelegate.add(delegate, delegateQueue: .main)
    }
    
    func removeDelegate(_ delegate: T) {
        multicastDelegate.remove(self)
    }
    
    func deactivate() {
        multicastDelegate.removeAllDelegates()
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
    
    func asyncExecute(action: @escaping (Any) -> Void) {
        ///遍历出所有的delegate
        let delegateEnumerator = self.multicastDelegate.delegateEnumerator()
        var delegate: AnyObject?
        var queue: DispatchQueue?
        while delegateEnumerator.getNextDelegate(&delegate, delegateQueue: &queue) == true {
            //执行Delegate的方法
            if let currentDelegate = delegate, let currentQueue = queue {
                currentQueue.async {
                    action(currentDelegate)
                }
            }
        }
    }
}
