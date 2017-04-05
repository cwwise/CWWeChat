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
    
    override init!(dispatchQueue queue: DispatchQueue!) {
        super.init(dispatchQueue: queue)
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
        
        let queryElement = DDXMLElement(name: "query", xmlns: "http://jabber.org/protocol/disco#items")
        
        let iqElement = DDXMLElement(name: "iq")
        iqElement.addAttribute(withName: "type", stringValue: "get")
        let chatClient = CWChatClient.share
        
        iqElement.addAttribute(withName: "from", stringValue: "chenwei@hellochatim.p1.im")
        iqElement.addAttribute(withName: "to", stringValue: "conference.hellochatim.p1.im")
        iqElement.addAttribute(withName: "id", stringValue: "getexistroomid")

        iqElement.addChild(queryElement!)
        log.debug(iqElement)
        CWChatXMPPManager.share.xmppStream.send(iqElement)
    }
    
    
    
    
    
}
