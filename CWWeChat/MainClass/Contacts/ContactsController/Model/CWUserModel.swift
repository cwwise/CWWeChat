//
//  CWUserModel.swift
//  CWWeChat
//
//  Created by chenwei on 2017/3/26.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

public class CWUserModel: NSObject {

    /// 用户id
    var userId: String
    /// 用户名
    var username: String
    /// 昵称
    var nickname: String? {
        willSet {
            //不相同的时候 设置获取拼音和拼音的首字母
            if (newValue != nickname) && newValue != nil {
                self.pinying = newValue!.pinYingString
                self.pinyingInitial = self.pinying.pinyingInitial
            }
        }
        
    }
    /// 头像URL
    var avatarURL: URL?
    var avatarImage: UIImage?

    /// 备注
    var remarkName: String?
    /**
     *  拼音
     *
     *  来源：备注 > 昵称 > 用户名
     */
    /// 拼音缩写
    var pinying: String = ""
    /// 拼音首字母
    var pinyingInitial: String = ""
    
    // 详情
    var detailInfo = CWUserInfo()
    
    init(userId: String, username: String) {
        self.username = username
        self.userId = userId
    }
    
    override public var hashValue: Int {
        return self.userId.hash
    }
    
}

func ==(lhs: CWUserModel, rhs: CWUserModel) -> Bool {
    return lhs.userId == rhs.userId
}
