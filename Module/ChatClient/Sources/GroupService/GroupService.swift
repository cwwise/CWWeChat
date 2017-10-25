//
//  GroupService.swift
//  ChatClient
//
//  Created by chenwei on 2017/10/3.
//  Copyright © 2017年 chenwei. All rights reserved.
//

import Foundation
import XMPPFramework

private let serviceName = "conference"

class GroupService: XMPPModule {
    
    var roomCache: [String: XMPPRoom] = [:]
    
    var roomStorage = XMPPRoomCoreDataStorage.sharedInstance()!
    
    lazy var groupChat: XMPPMUC = {
        let groupChat = XMPPMUC(dispatchQueue: self.moduleQueue)
        return groupChat
    }()
    
    @objc
    func didActivate() {
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
        //serviceName 默认是conference
        let options = ChatClient.share.options
        groupChat.discoverRooms(forServiceNamed: serviceName+"."+options.domain)
    }
    
    func createGroup(title: String,
                     invitees: [String],
                     message: String,
                     setting: GroupOptions,
                     completion: GroupCompletion?) {
        
        let options = ChatClient.share.options
        
        guard let user = self.xmppStream?.myJID?.user,
            let jid = XMPPJID(string: "\(user)@\(serviceName).\(options.domain)") else {
                return
        }
        
        let room = XMPPRoom(roomStorage: roomStorage, jid: jid)
        room.activate(self.xmppStream!)
        room.changeSubject(title)
        room.addDelegate(self, delegateQueue: self.moduleQueue)
        room.join(usingNickname: "陈威", history: nil)
    }
    
    /// 解散群组
    func dismissGroup(_ groupId: String) {
        let room = generateGroupRoom(groupId)
        room.destroy()
    }
    
    /// 退出群组
    func quitGroup(_ groupId: String) {
        let room = generateGroupRoom(groupId)
        if room.isJoined {
            room.leave()
        }
    }
    
    /// 更新群组名称
    func updateGroupName(_ name: String, groupId: String) {
        let room = generateGroupRoom(groupId)
        room.changeSubject(name)
    }
    
    // MARK: 群操作
    /// 申请入群
    func applyToGroup(_ groupId: String) {
        
    }
    
    /// 邀请用户
    func inviteUser(_ users: [String], to groupId: String, message: String) {

        let room = generateGroupRoom(groupId)
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
        let room = generateGroupRoom(groupId)
        room.join(usingNickname: "测试数据", history: nil)
    }
    
    func generateGroupRoom(_ groupId: String) -> XMPPRoom {
        if let room = roomCache[groupId] {
            return room
        }
        let jid = XMPPJID(string: groupId)
        let room = XMPPRoom(roomStorage: roomStorage, jid: jid!)
        room.addDelegate(self, delegateQueue: self.moduleQueue)
        room.activate(self.xmppStream!)
        return room
    }
    
}

// 发现多人聊天
extension GroupService: XMPPMUCDelegate {
    func xmppMUC(_ sender: XMPPMUC!, didDiscoverRooms rooms: [Any]!, forServiceNamed serviceName: String!) {
        roomCache.removeAll()
        guard let rooms = rooms else { return }
        
        for item in rooms {
            if let room = item as? DDXMLElement,
                let jid = room.attribute(forName: "jid")?.stringValue,
                let _ = room.attribute(forName: "name")?.stringValue {
                
                // 生成room
                let groupRoom = generateGroupRoom(jid)
                roomCache[jid] = groupRoom
            }
        }
 
        let groupList = roomCache.map { (key, room) -> Group in
            let group = Group(groupId: room.roomJID.bare)
            return group
        }
        executeDelegateSelector { (delegate, queue) in
            //执行Delegate的方法
            if let delegate = delegate as? GroupManagerDelegate {
                queue?.async(execute: {
                    delegate.groupListDidUpdate(groupList)
                })
            }
        }
        
    }
    
    func xmppMUC(_ sender: XMPPMUC!, failedToDiscoverRoomsForServiceNamed serviceName: String!, withError error: Error!) {
        log.debug(error)
    }
    
    /// 收到邀请
    public func xmppMUC(_ sender: XMPPMUC!, roomJID: XMPPJID!, didReceiveInvitation message: XMPPMessage!) {
        log.debug("收到邀请"+message.description)
        
    }
    
    /// 收到邀请拒绝
    func xmppMUC(_ sender: XMPPMUC!, roomJID: XMPPJID!, didReceiveInvitationDecline message: XMPPMessage!) {
        log.debug("收到邀请拒绝"+message.description)
    }
    
}


extension GroupService: XMPPRoomDelegate {
    
    func xmppRoom(_ sender: XMPPRoom, didFetchConfigurationForm configForm: DDXMLElement) {

    }
    
   func xmppRoomDidCreate(_ sender: XMPPRoom!) {
        //
        configureRoom(sender)
    }
    
    func configureRoom(_ xmppRoom: XMPPRoom) {
        
        let x = XMLElement(name: "x", xmlns: "jabber:x:data")
        var p = XMLElement(name: "field")
        p.addAttribute(withName: "var", stringValue: "muc#roomconfig_persistentroom")
        p.addChild(XMLElement(name: "value", stringValue: "1"))
        x.addChild(p)
        
        p = XMLElement(name: "field")
        p.addAttribute(withName: "var", stringValue: "muc#roomconfig_maxusers")
        p.addChild(XMLElement(name: "value", stringValue: "500"))
        x.addChild(p)
        
        p = XMLElement(name: "field")
        p.addAttribute(withName: "var", stringValue: "muc#roomconfig_changesubject")
        p.addChild(XMLElement(name: "value", stringValue: "1"))
        x.addChild(p)

        p = XMLElement(name: "field")
        p.addAttribute(withName: "var", stringValue: "muc#roomconfig_allowinvites")
        p.addChild(XMLElement(name: "value", stringValue: "1"))
        x.addChild(p)
        
        xmppRoom.configureRoom(usingOptions: x)
    }
    
    
    func xmppRoomDidJoin(_ sender: XMPPRoom!) {
        log.debug("xmppRoomDidJoin")
    }
    
    func xmppRoomDidLeave(_ sender: XMPPRoom!) {
        log.debug("xmppRoomDidLeave")
    }
    
}
