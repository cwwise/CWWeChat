//
//  CWContactGroupModel.swift
//  CWWeChat
//
//  Created by wei chen on 2017/4/3.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class CWContactGroupModel: NSObject {
    //组的名称
    var groupName: String?
    //用户列表
    private(set) var contactList: [CWContactModel]
    
    var contactCount: Int {
        return contactList.count
    }
    
    init(groupName: String? = nil,
         contactList: [CWContactModel] = [CWContactModel]() ) {
        self.groupName = groupName
        self.contactList = contactList
        super.init()
    }
    
    
    /**
     添加联系人
     
     - parameter model: 联系人实例
     */
    func append(_ model: CWContactModel) {
        contactList.append(model)
    }
    
    subscript(index: Int) -> CWContactModel? {
        get {
            if index > contactList.count {return nil}
            return contactList[index]
        }
    }
    
}
