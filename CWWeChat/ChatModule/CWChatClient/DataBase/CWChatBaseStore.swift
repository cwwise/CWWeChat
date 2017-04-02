//
//  CWChatBaseStore.swift
//  CWWeChat
//
//  Created by wei chen on 2017/4/2.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class CWChatBaseStore: NSObject {
    /// 当前用户的唯一id，创建数据库名称
    var userId: String
    //MARK: 初始化
    init(userId: String) {
        self.userId = userId
        super.init()
    }
}
