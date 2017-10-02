//
//  GroupManagerProtocol.swift
//  CWChatClient
//
//  Created by chenwei on 2017/10/2.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import Foundation

public protocol GroupManagerDelegate {
    
}

public protocol GroupManager {
    
    func addGroupDelegate(_ delegate: GroupManagerDelegate, delegateQueue: DispatchQueue)
    
    func removeGroupDelegate(_ delegate: GroupManagerDelegate)

    func fetchJoinGroups()
}

