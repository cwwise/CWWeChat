//
//  GroupService.swift
//  ChatClient
//
//  Created by chenwei on 2017/10/3.
//  Copyright © 2017年 chenwei. All rights reserved.
//

import Foundation
import XMPPFramework

class GroupService: XMPPModule {
    
    var room: XMPPRoom!
    
    var storage = XMPPRoomCoreDataStorage.sharedInstance()!
    
    lazy var groupChat: XMPPMUC = {
        let groupChat = XMPPMUC(dispatchQueue: self.moduleQueue)
        return groupChat
    }()
    
    @objc func didActivate() {
        self.groupChat.activate(self.xmppStream!)
        self.groupChat.addDelegate(self, delegateQueue: self.moduleQueue)
    }
}

extension GroupService: GroupManager {
    
    func addGroupDelegate(_ delegate: GroupManagerDelegate, delegateQueue: DispatchQueue) {
        addDelegate(delegate, delegateQueue: delegateQueue)
    }
    func removeGroupDelegate(_ delegate: GroupManagerDelegate) {
        removeDelegate(delegate)
    }
    
    func fetchJoinGroups() {
        
        // 来调用发现可用的服务
        // groupChat.discoverServices()
        
        //serviceName 默认是conference
        let serviceName = "conference"
        let options = ChatClient.share.options
        groupChat.discoverRooms(forServiceNamed: serviceName+"."+options.domain)
    }
    
    func createGroup(title: String,
                     invitees: [String],
                     message: String,
                     setting: GroupOptions,
                     completion: GroupCompletion?) {
        
        let options = ChatClient.share.options
        guard  let jid = XMPPJID(string: "chenwei@conference."+options.domain)
            else { return }
        
        room = XMPPRoom(roomStorage: storage, jid: jid)
        room.activate(self.xmppStream!)
        room.addDelegate(self, delegateQueue: self.moduleQueue)
        room.join(usingNickname: "陈威", history: nil)
    }
    
    /// 解散群组
    func dismissGroup(_ groupId: String) {
        let jid = XMPPJID(string: groupId)
        room = XMPPRoom(roomStorage: storage, jid: jid!)
        room.destroy()
    }
    
    /// 退出群组
    func quitGroup(_ groupId: String) {
        let jid = XMPPJID(string: groupId)
        room = XMPPRoom(roomStorage: storage, jid: jid!)
        if room.isJoined {
            room.leave()
        }
    }
    
    /// 更新群组名称
    func updateGroupName(_ name: String, groupId: String) {
        let jid = XMPPJID(string: groupId)
        room = XMPPRoom(roomStorage: storage, jid: jid!)
        room.changeSubject(name)
    }
    
    // MARK: 群操作
    /// 申请入群
    func applyToGroup(_ groupId: String) {
        
    }
    
    /// 邀请用户
    func inviteUser(_ users: [String], to groupId: String, message: String) {
        let jid = XMPPJID(string: groupId)
        room = XMPPRoom(roomStorage: storage, jid: jid!)
        
        let options = ChatClient.share.options
        
        var userjidList = [XMPPJID]()
        for user in users {
            let userjid = XMPPJID(user: user, domain: options.domain, resource: options.resource)!
            userjidList.append(userjid)
        }
        
        room.inviteUsers(userjidList, withMessage: message)
    }
    
    /// 通过群申请
    func passApplyToGroup(_ groupId: String, userId: String) {
        
    }
    
    /// 接受入群邀请
    func acceptGroupInvite(_ groupId: String, invitorId: String) {
        let group = generateGroup(groupId)
        group.join(usingNickname: "测试数据", history: nil)
    }
    
    func generateGroup(_ groupId: String) -> XMPPRoom {
        let jid = XMPPJID(string: groupId)
        room = XMPPRoom(roomStorage: storage, jid: jid!)
        return room
    }
    
}


extension GroupService: XMPPRoomDelegate {
    
    public func xmppRoomDidCreate(_ sender: XMPPRoom!) {
        //
        sender.configureRoom(usingOptions: nil)
    }
    
    func xmppRoomDidJoin(_ sender: XMPPRoom!) {
        log.debug("xmppRoomDidJoin")
    }
    
    func xmppRoomDidLeave(_ sender: XMPPRoom!) {
        log.debug("xmppRoomDidLeave")
    }
    
}
