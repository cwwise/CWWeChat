//
//  CWShareReplyModel.swift
//  CWWeChat
//
//  Created by wei chen on 2017/3/30.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

enum CWShareReplyType {
    case unkown
    case comment
    case praise
}


class CWShareReplyModel: NSObject {
   
    var shareId: String!

    var username: String!
    var userId: String!

    var receiveUserId: String?
    var receiveUserName: String?
    
    var replyDate: Date!
    
    var replyType: CWShareReplyType = .unkown
}
