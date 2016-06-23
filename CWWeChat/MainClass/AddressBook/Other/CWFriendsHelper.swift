//
//  FriendsHelper.swift
//  CWWeChat
//
//  Created by chenwei on 16/4/13.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import Foundation

//好友列表刷新
let CWFriendsNeedReloadNotification:String = "com.CWFriendsNeedReloadNotification.chat"

class CWFriendsHelper: NSObject {
    
    static let shareFriendsHelper = CWFriendsHelper()
    var userList = [CWContactUser]()
    
    override init() {
        super.init()
        
        
        let nickNameArray = ["李灵黛","冷文卿","阴露萍","柳兰歌","秦水支",
                             "李念儿","文彩依","柳婵诗","丁玲珑","凌霜华","景茵梦"]
        let userNameArray = ["agnes","ballard","candice","chenwei","diana",
                             "hinds","hinson","hodges","jerry","tom","trista"]

        for (index, _) in nickNameArray.enumerate() {
            let chatUser = CWContactUser()
            chatUser.nikeName = nickNameArray[index]
            chatUser.userName = userNameArray[index]
            chatUser.userId = userNameArray[index] + "@chenweiim.com"
            userList.append(chatUser)
        }
    }
    
    ///添加好友
    func addChatUser(user: CWContactUser) {
        objc_sync_enter(userList)
        if !userList.contains(user) {
            userList.append(user)
        }
        objc_sync_exit(userList)
    }
    
    
    class func findFriend(userId:String?) -> CWContactUser? {
        for user in CWFriendsHelper.shareFriendsHelper.userList {
            if userId == user.userId {
                return user
            }
        }
        return nil
    }
}