//
//  CWEmojiGroup.swift
//  CWWeChat
//
//  Created by chenwei on 2017/3/26.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class CWEmoticonGroup: NSObject {
    
    var groupID: String
    var groupName: String
    var groupIcon: String
    var emoticons: [CWEmoticon] = [CWEmoticon]()
    
    init(groupID: String, 
         groupName: String,
         groupIcon: String,
         emoticons: [CWEmoticon]) {
        self.groupID = groupID
        self.groupName = groupName
        self.groupIcon = groupIcon
        self.emoticons = emoticons
    }
    
    
    
}

