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
    
    lazy var mucLight: XMPPMUCLight = {
        let mucLight = XMPPMUCLight(dispatchQueue: self.moduleQueue)
        mucLight?.activate(CWChatXMPPManager.share.xmppStream)
        return mucLight!
    }()
    
    override init!(dispatchQueue queue: DispatchQueue!) {
        super.init(dispatchQueue: queue)
        self.mucLight.addDelegate(self, delegateQueue: self.moduleQueue)
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
        
        mucLight.discoverRooms(forServiceNamed: "conference.hellochatim.p1.im")
    }
    
    
    
    
    
}

extension CWGroupServic: XMPPMUCLightDelegate {
    func xmppMUCLight(_ sender: XMPPMUCLight, didDiscoverRooms rooms: [DDXMLElement], forServiceNamed serviceName: String) {
        log.debug(serviceName)
        log.debug(rooms)
    }
}
