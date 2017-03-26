//
//  CWContactUser.swift
//  CWWeChat
//
//  Created by chenwei on 16/4/2.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import Foundation

class CWContactUser: NSObject {

    //用户id
    var userId: String
    
    //用户名
    var userName: String?
    //昵称
    var nikeName: String? {
        willSet {
            //不相同的时候 设置获取拼音和拼音的首字母
            if (newValue != nikeName) && newValue != nil {
                self.pinying = newValue!.pinYingString(true)
                self.pinyingInitial = newValue!.pinYingString()
            }
        }
    }
    //备注名
    var remarkName: String?
    
    //头像URL
    var avatarURL: String?
    //头像路径
    var avatarPath: String?
    
    var isOnline: Bool = false

    /**
     *  拼音
     *
     *  来源：备注 > 昵称 > 用户名
     */
    ///拼音缩写
    var pinying: String = ""
    ///拼音首字母
    var pinyingInitial: String = ""
    
    override init() {
        userId = ""
        super.init()
    }
    
    convenience init(userId: String) {
        self.init()
        self.userId = userId
    }
    
    override var hashValue: Int {
        return self.userId.hash
    }
    
    override var description: String {
        return self.nikeName!.pinYingString(true)+self.nikeName!
    }
    
}


func ==(lhs: CWContactUser, rhs: CWContactUser) -> Bool {
    return lhs.userId == rhs.userId
}



