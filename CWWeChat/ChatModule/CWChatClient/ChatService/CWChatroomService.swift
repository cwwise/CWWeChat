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
    
    var roomLight: XMPPRoomLight!
    
    lazy var multiChat: XMPPMUCLight = {
        let muc = XMPPMUCLight(dispatchQueue: self.moduleQueue)
        return muc!
    }()
    
    override init!(dispatchQueue queue: DispatchQueue!) {
        super.init(dispatchQueue: queue)
    }
    
    @objc func didActivate() {
        self.multiChat.activate(self.xmppStream)
        self.multiChat.addDelegate(self, delegateQueue: self.moduleQueue)
    }
    
}

extension CWChatroomService: CWChatroomManager {
    
    func addChatroomDelegate(_ delegate: CWChatroomManagerDelegate, delegateQueue: DispatchQueue) {
        addDelegate(delegate, delegateQueue: delegateQueue)
    }
    
    func removeChatroomDelegate(_ delegate: CWChatroomManagerDelegate) {
        removeDelegate(delegate)
    }
    
    func fetchChatrooms() {
        let options = CWChatClient.share.options
        self.multiChat.discoverRooms(forServiceNamed: "conference."+options.domain)
    }
    
    func createChatroom(title: String,
                     invitees: [String],
                     message: String) {
        let options = CWChatClient.share.options
        
        let roomjid = XMPPJID(string: "demo@conference."+options.domain)
        roomLight = XMPPRoomLight(jid: roomjid!, roomname: title)
        roomLight.activate(self.xmppStream)
        roomLight.addDelegate(self, delegateQueue: self.moduleQueue)

        var userjidList = [XMPPJID]()
        for user in invitees {
            let userjid = chatJID(with: user)
            userjidList.append(userjid)
        }
        // affiliations 友好关系
        roomLight.createRoomLight(withMembersJID: userjidList)
        
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
