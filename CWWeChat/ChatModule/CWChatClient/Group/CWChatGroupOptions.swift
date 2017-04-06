//
//  CWChatGroupOptions.swift
//  CWWeChat
//
//  Created by wei chen on 2017/4/2.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

public enum CWChatGroupStyle {
    case onlyOwnerInvite
    case memberCanInvite
    case joinNeedApproval
    case publicOpenJoin
}

public class CWChatGroupOptions: NSObject {
    ///  群组的类型
    var style: CWChatGroupStyle = .onlyOwnerInvite
    /// 群组的最大成员数
    var maxUsersCount: Int = 200
    /// 邀请群成员时，是否需要发送邀请通知.若NO，被邀请的人自动加入群组
    var IsInviteNeedConfirm: Bool = false
}
