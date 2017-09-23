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
    
    var vCardModule: XMPPvCardTempModule = {
        let vCardStorage = XMPPvCardCoreDataStorage.sharedInstance()
        let vCardModule = XMPPvCardTempModule(vCardStorage: vCardStorage)
        return vCardModule!
    }()
    
    override init!(dispatchQueue queue: DispatchQueue!) {
        super.init(dispatchQueue: queue)
    }
    
    @objc func didActivate() {
        xmppRoster.addDelegate(self, delegateQueue: self.moduleQueue)
        xmppRoster.activate(self.xmppStream)
        
        vCardModule.activate(self.xmppStream)
        vCardModule.addDelegate(self, delegateQueue: self.moduleQueue)
    }
    
    func xmppStreamDidAuthenticate(_ sender: XMPPStream!) {
        vCardModule.fetchvCardTemp(for: sender.myJID)
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
    
    func addContact(_ contact: CWUser, message: String, completion: CWAddContactCompletion?) {
        xmppRoster.addUser(chatJID(with: contact.userId), withNickname: contact.nickname)
    }
    
    
    func updateMyUserInfo(_ userInfo: [CWUserInfoUpdateTag: String]) {
        
        let vCardTemp = vCardModule.myvCardTemp
        if let nickName = userInfo[CWUserInfoUpdateTag.nickName] {
            vCardTemp?.nickname = nickName
        }
        
        if let sign = userInfo[CWUserInfoUpdateTag.sign] {
            vCardTemp?.note = sign
        }

        vCardModule.updateMyvCardTemp(vCardTemp)
    }
    
    func userInfo(with userId: String) -> CWUser {
        let jid = chatJID(with: userId)
        
        if let vCardTemp = vCardModule.vCardTemp(for: jid, shouldFetch: true) {
            let user = CWUser(userId: jid.user, vCardTemp: vCardTemp)
            return user
        } else {
            let user = CWUser(userId: userId)
            return user
        }
    }
    
}


// MARK: - XMPPRosterMemoryStorageDelegate
extension CWContactService: XMPPRosterMemoryStorageDelegate {

    /// 获取联系人
    func xmppRosterDidPopulate(_ sender: XMPPRosterMemoryStorage!) {

        var contacts = [CWUser]()
        let users = sender.sortedUsersByName()
        for user in users! {
            if let user = user as? XMPPUser {
                let model = CWUser(userId: user.jid().user)
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


extension CWContactService: XMPPvCardTempModuleDelegate {
    func xmppvCardTempModule(_ vCardTempModule: XMPPvCardTempModule!, didReceivevCardTemp vCardTemp: XMPPvCardTemp!, for jid: XMPPJID!) {
        
        let user = CWUser(userId: jid.user, vCardTemp: vCardTemp)
        executeDelegateSelector { (delegate, queue) in
            if let delegate = delegate as? CWContactManagerDelegate {
                delegate.onUserInfoChanged(user: user)
            }
        }
        
    }
    
    func xmppvCardTempModuleDidUpdateMyvCard(_ vCardTempModule: XMPPvCardTempModule!) {
        
    }
    
    func xmppvCardTempModule(_ vCardTempModule: XMPPvCardTempModule!, failedToUpdateMyvCard error: DDXMLElement!) {
        log.error("更新失败...")

    }
}

// 根据 XMPPvCardTemp生成CWUser
extension CWUser {
    
    convenience init(userId: String, vCardTemp: XMPPvCardTemp) {
        let userInfo = CWUserInfo()
        userInfo.sign = vCardTemp.note

        self.init(userId: userId, userInfo: userInfo)
        self.nickname = vCardTemp.nickname
    }
    
}


