//
//  BaseService.swift
//  ChatClient
//
//  Created by wei chen on 2017/12/22.
//

import Foundation

class BaseService<T> {
    
    public private(set) var multicastDelegate = MulticastDelegate<T>()
    
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
    
}
