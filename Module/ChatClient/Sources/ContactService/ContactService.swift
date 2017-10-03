//
//  ContactService.swift
//  ChatClient
//
//  Created by chenwei on 2017/10/3.
//  Copyright © 2017年 chenwei. All rights reserved.
//

import Foundation
import XMPPFramework

class ContactService: XMPPModule {
    
    var completion: ContactCompletion?
    
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
    
    @objc func didActivate() {
        xmppRoster.addDelegate(self, delegateQueue: self.moduleQueue)
        xmppRoster.activate(self.xmppStream)
        
        vCardModule.activate(self.xmppStream)
        vCardModule.addDelegate(self, delegateQueue: self.moduleQueue)
    }
    
}

extension ContactService: ContactManager {
    
    /// 添加代理
    ///
    /// - Parameter delegate: 代理
    /// - Parameter delegateQueue: 代理执行线程
    func addContactDelegate(_ delegate: ContactManagerDelegate, delegateQueue: DispatchQueue) {
        addDelegate(delegate, delegateQueue: delegateQueue)
    }
    
    /// 删除代理
    ///
    /// - Parameter delegate: 代理
    func removeContactDelegate(_ delegate: ContactManagerDelegate) {
        removeDelegate(delegate)
    }
    
    // MARK: 获取好友
    func fetchContactsFromServer(completion: ContactCompletion?) {
        xmppRoster.fetch()
        self.completion = completion
    }
    
    
    func updateMyUserInfo(_ userInfo: [UserInfoUpdateTag: String]) {
        
        let vCardTemp = vCardModule.myvCardTemp
        if let nickName = userInfo[UserInfoUpdateTag.nickName] {
            vCardTemp?.nickname = nickName
        }
        
        if let sign = userInfo[UserInfoUpdateTag.sign] {
            vCardTemp?.note = sign
        }
        
        vCardModule.updateMyvCardTemp(vCardTemp)
    }
    
    func userInfo(with userId: String) -> User {
   //     let jid = chatJID(with: userId)
        
//        if let vCardTemp = vCardModule.vCardTemp(for: jid, shouldFetch: true) {
//            let user = User(userId: jid.user, vCardTemp: vCardTemp)
//            return user
//        } else {
//            let user = User(userId: userId)
//            return user
//        }
        return User(username: userId)
    }
    
}

// 根据 XMPPvCardTemp生成CWUser
extension User {
    
//    convenience init(userId: String, vCardTemp: XMPPvCardTemp) {
//        let userInfo = CWUserInfo()
//        userInfo.sign = vCardTemp.note
//        
//        self.init(userId: userId, userInfo: userInfo)
//        self.nickname = vCardTemp.nickname
//    }
//    
}
