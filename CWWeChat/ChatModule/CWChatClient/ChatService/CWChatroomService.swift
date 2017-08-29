//
//  CWChatroomService.swift
//  CWWeChat
//
//  Created by wei chen on 2017/4/5.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import Foundation
import XMPPFramework

class CWChatroomService: XMPPModule {
    
    lazy var multiChat: XMPPMUCLight = {
        let muc = XMPPMUCLight(dispatchQueue: self.moduleQueue)
        muc?.activate(self.xmppStream)
        return muc!
    }()
    
    override init!(dispatchQueue queue: DispatchQueue!) {
        super.init(dispatchQueue: queue)
        self.multiChat.addDelegate(self, delegateQueue: self.moduleQueue)
    }
    
}

extension CWChatroomService: CWChatroomManager {
    
    func addChatroomDelegate(_ delegate: CWGroupManagerDelegate, delegateQueue: DispatchQueue) {
        addDelegate(delegate, delegateQueue: delegateQueue)
    }
    
    func removeChatroomDelegate(_ delegate: CWGroupManagerDelegate) {
        removeDelegate(delegate)
    }
    
    func fetchChatrooms() {
        
        let options = CWChatClient.share.options
        self.multiChat.discoverRooms(forServiceNamed: "conference."+options.domain)
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
        let room = XMPPRoomLight(jid: roomjid, roomname: title)
        room.activate(self.xmppStream)
        room.addDelegate(self, delegateQueue: self.moduleQueue)

        var userjidList = [XMPPJID]()
        for user in invitees {
            let userjid = XMPPJID(user: user, domain: options.domain, resource: options.resource)!
            userjidList.append(userjid)
        }
        // affiliations 友好关系
        room.createRoomLight(withMembersJID: userjidList)
        
    }
    
}




extension CWChatroomService: XMPPMUCLightDelegate {
    
    func xmppMUCLight(_ sender: XMPPMUCLight, didDiscoverRooms rooms: [DDXMLElement], forServiceNamed serviceName: String) {
        log.debug(rooms)
    }
    
}

extension CWChatroomService: XMPPRoomLightDelegate {
    func xmppRoomLight(_ sender: XMPPRoomLight, didCreateRoomLight iq: XMPPIQ) {
        log.debug(iq)
    }
    
    func xmppRoomLight(_ sender: XMPPRoomLight, didFailToCreateRoomLight iq: XMPPIQ) {
        log.debug(iq)
    }
}
