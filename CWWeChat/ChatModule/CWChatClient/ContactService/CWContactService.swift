//
//  CWContactService.swift
//  CWWeChat
//
//  Created by wei chen on 2017/4/3.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import XMPPFramework

/// 联系人模块 实现
class CWContactService: XMPPModule {
    
    var completion: CWContactCompletion?
    
    var xmppRoster: XMPPRoster = {
        let xmppRosterStorage = XMPPRosterMemoryStorage()
        let xmppRoster = XMPPRoster(rosterStorage: xmppRosterStorage)
        return xmppRoster!
    }();
    
    override init!(dispatchQueue queue: DispatchQueue!) {
        super.init(dispatchQueue: queue)
    }
    
    func didActivate() {
        self.xmppRoster.addDelegate(self, delegateQueue: self.moduleQueue)
        self.xmppRoster.activate(self.xmppStream)
    }
}


extension CWContactService: CWContactManager {

    /// 添加代理
    ///
    /// - Parameter delegate: 代理
    /// - Parameter delegateQueue: 代理执行线程
    func addContactDelegate(_ delegate: CWContactManagerDelegate, delegateQueue: DispatchQueue) {
        addDelegate(delegate, delegateQueue: delegateQueue)
    }
    
    /// 删除代理
    ///
    /// - Parameter delegate: 代理
    func removeContactDelegate(_ delegate: CWContactManagerDelegate) {
        removeDelegate(delegate)
    }
    
    // MARK: 获取好友
    func fetchContactsFromServer(completion: CWContactCompletion?) {
        xmppRoster.fetch()
        self.completion = completion
    }
    
    func addContact(_ contact: CWChatUser, message: String, completion: CWAddContactCompletion?) {
        let domain = CWChatClient.share.options.domain
        let resource = CWChatClient.share.options.resource
        let jid = XMPPJID(user: contact.userId, domain: domain, resource: resource)
        xmppRoster.addUser(jid, withNickname: contact.userId)
    }
    
}

extension CWContactService: XMPPRosterMemoryStorageDelegate {

    func xmppRosterDidPopulate(_ sender: XMPPRosterMemoryStorage!) {

        var contacts = [CWChatUserModel]()
        let users = sender.sortedUsersByName()
        for user in users! {
            if let user = user as? XMPPUser {
                let model = CWChatUserModel(userId: user.jid().user)
                model.nickname = user.nickname() ?? user.jid().user
                contacts.append(model)
            }
        }

        self.completion?(contacts, nil)
    }
}


extension CWContactService: XMPPRosterDelegate {
    
    func xmppRoster(_ sender: XMPPRoster!, didReceivePresenceSubscriptionRequest presence: XMPPPresence!) {
        sender.acceptPresenceSubscriptionRequest(from: presence.from(), andAddToRoster: true)
    }
    
}



