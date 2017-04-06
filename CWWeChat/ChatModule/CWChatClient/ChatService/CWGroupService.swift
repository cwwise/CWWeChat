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
        
//        let queryElement = DDXMLElement(name: "query", xmlns: "http://jabber.org/protocol/disco#items")
//        
//        let iqElement = DDXMLElement(name: "iq")
//        iqElement.addAttribute(withName: "type", stringValue: "get")
//        let chatClient = CWChatClient.share
//        
//        iqElement.addAttribute(withName: "from", stringValue: "chenwei@hellochatim.p1.im")
//        iqElement.addAttribute(withName: "to", stringValue: "conference.hellochatim.p1.im")
//        iqElement.addAttribute(withName: "id", stringValue: "getexistroomid")
//
//        iqElement.addChild(queryElement!)
//        log.debug(iqElement)
//        CWChatXMPPManager.share.xmppStream.send(iqElement)
        
        groupChat.discoverRooms(forServiceNamed: "conference.localhost")
    }
    
    func createGroup(title: String,
                     invitees: [String],
                     message: String,
                     setting: CWChatGroupOptions,
                     completion: CWGroupCompletion) {
        let options = CWChatClient.share.options

        let jid = XMPPJID(string: "chenwei@conference."+options.chatDomain)
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
        log.debug(rooms)
    }
    
    public func xmppMUC(_ sender: XMPPMUC!, roomJID: XMPPJID!, didReceiveInvitation message: XMPPMessage!) {
        log.debug(message)
        
    }

}


extension CWGroupServic: XMPPRoomDelegate {

    public func xmppRoomDidCreate(_ sender: XMPPRoom!) {
        log.debug(sender.roomJID)
    }


}
