//
//  BaseService.swift
//  ChatClient
//
//  Created by wei chen on 2017/12/22.
//

import Foundation

// TODO: - 如果T可能是两个协议 怎么处理好。
///
class BaseService<T> {
    
    private var multicastDelegate = MulticastDelegate<T>()
    
    func addDelegate(_ delegate: T) {
        multicastDelegate.add(delegate)
    }
    
    func addDelegate(_ delegate: T, delegateQueue: DispatchQueue) {
        multicastDelegate.add(delegate, delegateQueue: delegateQueue)
    }
    
    func removeDelegate(_ delegate: T) {
        multicastDelegate.remove(delegate)
    }
    
    /// 删除所有delegate
    func deactivate() {
        multicastDelegate.removeAll()
    }
    
    func asyncExecute(action: @escaping (T) -> Void) {
        ///遍历出所有的delegate
        let delegateEnumerator = self.multicastDelegate.multicastDelegate.delegateEnumerator()
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
    
    func syncExecute(action: (T) -> Void) {
        ///遍历出所有的delegate
        let delegateEnumerator = self.multicastDelegate.multicastDelegate.delegateEnumerator()
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
    
}
