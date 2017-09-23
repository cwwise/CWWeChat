//
//  CWGroupService.swift
//  CWWeChat
//
//  Created by chenwei on 2017/4/5.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import Foundation
import XMPPFramework

class CWGroupService: XMPPModule {
    
    var room: XMPPRoom!
    
    lazy var groupChat: XMPPMUC = {
        let groupChat = XMPPMUC(dispatchQueue: self.moduleQueue)
        return groupChat!
    }()
    
    override init!(dispatchQueue queue: DispatchQueue!) {
        super.init(dispatchQueue: queue)
    }
    
    @objc func didActivate() {
        self.groupChat.activate(self.xmppStream)
        self.groupChat.addDelegate(self, delegateQueue: self.moduleQueue)
    }
}


extension CWGroupService: CWGroupManager {
    
    func addGroupDelegate(_ delegate: CWGroupManagerDelegate, delegateQueue: DispatchQueue) {
        addDelegate(delegate, delegateQueue: delegateQueue)
    }
    func removeGroupDelegate(_ delegate: CWGroupManagerDelegate) {
        removeDelegate(delegate)
    }
    
    func fetchJoinGroups() {
        
        // 来调用发现可用的服务
        // groupChat.discoverServices()
        
        //serviceName 默认是conference
        let serviceName = "conference"
        let options = CWChatClient.share.options
        groupChat.discoverRooms(forServiceNamed: serviceName+"."+options.domain)
    }
    
    func createGroup(title: String,
                     invitees: [String],
                     message: String,
                     setting: CWChatGroupOptions,
                     completion: CWGroupCompletion?) {

        let options = CWChatClient.share.options
        let jid = XMPPJID(string: "chenwei@conference."+options.domain)
       
        let storage = XMPPRoomCoreDataStorage.sharedInstance()
        room = XMPPRoom(roomStorage: storage, jid: jid)!
        room.activate(self.xmppStream)
        room.addDelegate(self, delegateQueue: self.moduleQueue)
        room.join(usingNickname: "陈威", history: nil)
    }
    
    /// 解散群组
    func dismissGroup(_ groupId: String) {
        let jid = XMPPJID(string: groupId)
        let storage = XMPPRoomCoreDataStorage.sharedInstance()
        room = XMPPRoom(roomStorage: storage, jid: jid)!
        room.destroy()
    }
    
    /// 退出群组
    func quitGroup(_ groupId: String) {
        let jid = XMPPJID(string: groupId)
        let storage = XMPPRoomCoreDataStorage.sharedInstance()
        room = XMPPRoom(roomStorage: storage, jid: jid)!
        if room.isJoined {
            room.leave()
        }
    }

    /// 更新群组名称
    func updateGroupName(_ name: String, groupId: String) {
        let jid = XMPPJID(string: groupId)
        let storage = XMPPRoomCoreDataStorage.sharedInstance()
        room = XMPPRoom(roomStorage: storage, jid: jid)!
        room.changeSubject(name)
    }
    
    // MARK: 群操作
    /// 申请入群
    func applyToGroup(_ groupId: String) {
        
    }
    
    /// 邀请用户
    func inviteUser(_ users: [String], to groupId: String, message: String) {
        let jid = XMPPJID(string: groupId)
        let storage = XMPPRoomCoreDataStorage.sharedInstance()
        room = XMPPRoom(roomStorage: storage, jid: jid)!
        
        let options = CWChatClient.share.options
        
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
        let storage = XMPPRoomCoreDataStorage.sharedInstance()
        room = XMPPRoom(roomStorage: storage, jid: jid)!
        return room
    }
    
}

// 发现多人聊天
extension CWGroupService: XMPPMUCDelegate {
    func xmppMUC(_ sender: XMPPMUC!, didDiscoverRooms rooms: [Any]!, forServiceNamed serviceName: String!) {        
        guard let rooms = rooms else { return }
        for item in rooms {
            if let room = item as? DDXMLElement,
                let jid = room.attribute(forName: "jid")?.stringValue,
                let _ = room.attribute(forName: "name")?.stringValue {
                
                
                let roomjid = XMPPJID(string: jid)
                /*
                self.room = XMPPRoom(roomStorage: XMPPRoomCoreDataStorage.sharedInstance(), jid: roomjid)
                self.room.addDelegate(self, delegateQueue: self.moduleQueue)
                self.room.activate(self.xmppStream)
                self.room.join(usingNickname: "helloworld", history: nil)
                */
            }
        }
    }
    
    func xmppMUC(_ sender: XMPPMUC!, failedToDiscoverRoomsForServiceNamed serviceName: String!, withError error: Error!) {
        log.debug(error)
    }

    /// 收到邀请
    public func xmppMUC(_ sender: XMPPMUC!, roomJID: XMPPJID!, didReceiveInvitation message: XMPPMessage!) {
        log.debug("收到邀请"+message.description)
        let storage = XMPPRoomCoreDataStorage.sharedInstance()
        room = XMPPRoom(roomStorage: storage, jid: roomJID)!
        room.join(usingNickname: "测试用户", history: nil)
    }
        
    /// 收到邀请拒绝
    func xmppMUC(_ sender: XMPPMUC!, roomJID: XMPPJID!, didReceiveInvitationDecline message: XMPPMessage!) {
        log.debug("收到邀请拒绝"+message.description)
    }

}


extension CWGroupService: XMPPRoomDelegate {

    public func xmppRoomDidCreate(_ sender: XMPPRoom!) {
        log.debug(sender.roomJID)
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

