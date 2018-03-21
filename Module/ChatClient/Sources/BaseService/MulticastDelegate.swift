//
//  MulticastDelegate.swift
//  ChatClient
//
//  Created by wei chen on 2017/12/22.
//

import Foundation
import XMPPFramework

class MulticastDelegate<T> {

    // swiftlint_disable weak_delegate
    var multicastDelegate = GCDMulticastDelegate()
    
    func add(_ delegate: T, delegateQueue: DispatchQueue = DispatchQueue.main) {
        multicastDelegate.add(delegate, delegateQueue: delegateQueue)
    }
    
    func remove(_ delegate: T) {
        multicastDelegate.remove(delegate)
    }
    
    func removeAll() {
        multicastDelegate.removeAllDelegates()
    }
    
}
