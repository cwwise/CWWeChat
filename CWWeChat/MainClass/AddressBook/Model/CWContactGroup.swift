//
//  CWContactGroup.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/23.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWContactGroup: NSObject {

    //组的名称
    var groupName: String?
    //用户列表
    var userList: [CWContactUser]
    
    var contactCount: Int {
        return userList.count
    }
    
    init(groupName: String? = nil, userList: [CWContactUser] = [CWContactUser]() ) {
        self.groupName = groupName
        self.userList = userList
        super.init()
    }
    
    /**
     添加联系人
     
     - parameter model: 联系人实例
     */
    func append(_ model: CWContactUser) {
        userList.append(model)
    }
    
    subscript(index : Int) -> CWContactUser? {
        get
        {
            if index > userList.count {
                return nil
            }
            return userList[index]
        }
    }
}
