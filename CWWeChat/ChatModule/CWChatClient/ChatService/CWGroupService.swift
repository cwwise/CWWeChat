//
//  CWGroupService.swift
//  CWWeChat
//
//  Created by chenwei on 2017/4/5.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import Foundation
import XMPPFramework

class CWGroupServic: XMPPModule {
    
    var room: XMPPRoom!
    
    lazy var groupChat: XMPPMUC = {
        let groupChat = XMPPMUC(dispatchQueue: self.moduleQueue)
        groupChat?.activate(CWChatXMPPManager.share.xmppStream)
        return groupChat!
    }()
    
    override init!(dispatchQueue queue: DispatchQueue!) {
        super.init(dispatchQueue: queue)
        self.groupChat.addDelegate(self, delegateQueue: self.moduleQueue)
    }
    
}


extension CWGroupServic: CWGroupManager {
    
    func addGroupDelegate(_ delegate: CWGroupManagerDelegate, delegateQueue: DispatchQueue) {
        addDelegate(delegate, delegateQueue: delegateQueue)
    }
    func removeGroupDelegate(_ delegate: CWGroupManagerDelegate) {
        removeDelegate(delegate)
    }
    
    func fetchJoinGroups() {
        //serviceName 默认是conference
        let serviceName = "conference"
        let options = CWChatClient.share.options
        groupChat.discoverRooms(forServiceNamed: serviceName+"."+options.domain)
    }
    
    func createGroup(title: String,
                     invitees: [String],
                     message: String,
                     setting: CWChatGroupOptions,
                     completion: CWGroupCompletion) {
        let options = CWChatClient.share.options

        let jid = XMPPJID(string: "chenwei@conference."+options.domain)
        guard let roomjid = jid else {
            completion(nil, CWChatError(errorCode: .customer, error: "系统错误"))
            return
        }
        let storage = XMPPRoomCoreDataStorage.sharedInstance()
        let room = XMPPRoom(roomStorage: storage, jid: jid)!
        room.activate(CWChatXMPPManager.share.xmppStream)
        room.addDelegate(self, delegateQueue: self.moduleQueue)
        room.join(usingNickname: "陈威", history: nil)
    }

}

// 发现多人聊天
extension CWGroupServic: XMPPMUCDelegate {
    func xmppMUC(_ sender: XMPPMUC!, didDiscoverRooms rooms: [Any]!, forServiceNamed serviceName: String!) {        
        guard let rooms = rooms else { return }
        for item in rooms {
            if let room = item as? DDXMLElement,
                let jid = room.attribute(forName: "jid")?.stringValue,
                let _ = room.attribute(forName: "name")?.stringValue {
                
                
                let roomjid = XMPPJID(string: jid)
                self.room = XMPPRoom(roomStorage: XMPPRoomCoreDataStorage.sharedInstance(), jid: roomjid)
                self.room.addDelegate(self, delegateQueue: self.moduleQueue)
                self.room.activate(CWChatXMPPManager.share.xmppStream)
                self.room.join(usingNickname: "helloworld", history: nil)
            }
        }
    }
    
    func xmppMUC(_ sender: XMPPMUC!, failedToDiscoverRoomsForServiceNamed serviceName: String!, withError error: Error!) {
        log.debug(error)
    }

    
    public func xmppMUC(_ sender: XMPPMUC!, roomJID: XMPPJID!, didReceiveInvitation message: XMPPMessage!) {
        log.debug(message)
    }

}


extension CWGroupServic: XMPPRoomDelegate {

    public func xmppRoomDidCreate(_ sender: XMPPRoom!) {
        log.debug(sender.roomJID)
    }

    func xmppRoomDidJoin(_ sender: XMPPRoom!) {
        log.debug("xmppRoomDidJoin"+sender.description)
    }
    
    func xmppRoomDidLeave(_ sender: XMPPRoom!) {
        log.debug("xmppRoomDidLeave"+sender.description)

    }

}

