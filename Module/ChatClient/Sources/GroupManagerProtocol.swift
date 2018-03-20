//
//  GroupManagerProtocol.swift
//  ChatClient
//
//  Created by chenwei on 2017/10/2.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import Foundation

/// 群组相关的回调
public protocol GroupManagerDelegate {
    
    func groupListDidUpdate(_ groupList: [Group])

}
public extension GroupManagerDelegate {
    func groupListDidUpdate(_ groupList: [Group]) {}
}


public typealias GroupCompletion = (Group?, ChatClientError?) -> Void

public protocol GroupManager {
    
    func addDelegate(_ delegate: GroupManagerDelegate)
    
    func removeDelegate(_ delegate: GroupManagerDelegate)

    func fetchJoinGroups()
    
    func createGroup(title: String,
                     invitees: [String],
                     message: String,
                     setting: GroupOptions,
                     completion: GroupCompletion?)
}

