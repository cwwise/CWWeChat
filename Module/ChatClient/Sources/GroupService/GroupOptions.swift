//
//  GroupOptions.swift
//  ChatKit
//
//  Created by chenwei on 2017/10/3.
//

import Foundation

public enum ChatGroupStyle {
    case onlyOwnerInvite
    case memberCanInvite
    case joinNeedApproval
    case publicOpenJoin
}

public class GroupOptions: NSObject {
    ///  群组的类型
    public var style: ChatGroupStyle = .onlyOwnerInvite
    /// 群组的最大成员数
    public var maxUsersCount: Int = 200
    /// 邀请群成员时，是否需要发送邀请通知.若NO，被邀请的人自动加入群组
    public var isInviteNeedConfirm: Bool = false
    
}
