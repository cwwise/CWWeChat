//
//  CWContactManager.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/23.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit
import SwiftyJSON

//好友列表刷新
let CWFriendsNeedReloadNotification:String = "com.CWFriendsNeedReloadNotification.chat"

/// 管理联系人
class CWContactManager: NSObject {
    
    typealias ContactDataChangedBlock = ([CWContactGroup],[String],Int)->Void
    
    static let shareContactManager = CWContactManager()

    ///默认的分组
    private var defaultGroup: CWContactGroup!
    ///联系人 最原始的数据
    var contactsData = [CWContactUser]()
    
    var sortContactsData = [CWContactGroup]()
    var sortSectionHeaders = [String]()
    var dataChangeBlock:ContactDataChangedBlock?
    
    //联系人数量
    var contactCount: Int {
        return contactsData.count
    }
    
    override init() {
        super.init()
        self.setupDefaultGroup()
        initTestData()
    }
    
    class func findContact(userId:String) -> CWContactUser? {
        let name = userId.componentsSeparatedByString("@").first
        for user in CWContactManager.shareContactManager.contactsData {
            if (user.userId.containsString(name!)) {
                return user
            }
        }
        return nil
    }
    
    ///初始化测试数据
    func initTestData() {
        ///读取数据
        let path = NSBundle.mainBundle().pathForResource("ContactList", ofType: "json")
        guard let filepath = path else {
            CWLogError("不存在 ContactList.json 文件。")
            return
        }
        let contantData = NSData(contentsOfFile: filepath)
        let contactList = JSON(data: contantData!)
        
        for (_,subJson):(String, JSON) in contactList {
    
            let user = CWContactUser()
            user.userId = subJson["userID"].string
            user.userName = subJson["username"].string
            user.remarkName = subJson["remarkName"].string
            user.nikeName = subJson["nikeName"].string
            user.avatarURL = subJson["avatarURL"].string
            contactsData.append(user)
        }
        dispatch_async(dispatch_get_global_queue(0, 0)) { 
            self.sortContactData()
        }
    }
    
    ///对数据进行排序分组
    func sortContactData() {
        
        //先根据拼音的首字母排序
        contactsData.sortInPlace { (leftUser, rightUser) -> Bool in
            let pingYingA = leftUser.pinying
            let pingYingB = rightUser.pinying
            return pingYingA < pingYingB
        }
        //头部分
        
        var analyzeGroupData = [CWContactGroup]()
        analyzeGroupData.append(self.defaultGroup)
        
        var sectionHeaders = [UITableViewIndexSearch]
        /**
         遍历数据 根据首字母 如果没有拼音字母 则添加到＃组别中         */
        let othergroup = CWContactGroup(groupName: "#")
        
        var currentGroup: CWContactGroup?
        var lastInitial = "#"
        
        for userModel in contactsData {
            //首字母
            let initial = userModel.pinyingInitial
    
            if initial.characters.count == 0 {
                othergroup.append(userModel)
                continue
            }
            
            //如果不相同，则说明之前没有这个首字母添加到数组，
            if initial != lastInitial {
                
                if (currentGroup != nil) && currentGroup!.contactCount > 0 {
                    analyzeGroupData.append(currentGroup!)
                    sectionHeaders.append(initial)
                }
                lastInitial = initial
                currentGroup = CWContactGroup(groupName: initial)
                currentGroup?.append(userModel)
                
            } else {
                
                currentGroup!.append(userModel)
            
            }
        }
        
        if (currentGroup != nil) && currentGroup!.contactCount > 0 {
            analyzeGroupData.append(currentGroup!)
            sectionHeaders.append(lastInitial)
        }
        if (othergroup.contactCount > 0) {
            analyzeGroupData.append(othergroup)
            sectionHeaders.append(othergroup.groupName!)
        }

        sortContactsData.removeAll()
        sortContactsData.appendContentsOf(analyzeGroupData)
        
        sortSectionHeaders.removeAll()
        sortSectionHeaders.appendContentsOf(sectionHeaders)
        
        if self.dataChangeBlock != nil {
            dispatch_async(dispatch_get_main_queue(), { 
                CWLogDebug(self.sortSectionHeaders.description)
                self.dataChangeBlock!(self.sortContactsData,self.sortSectionHeaders,self.contactsData.count)
            })
        }
        
    }
    
    //初始化默认的组
    func setupDefaultGroup() {
        
        let titleArray = ["新的朋友","群聊", "标签", "公众号"]
        let iconArray = ["friends_new","friends_group", "friends_tag", "friends_public"]
        let idArray = ["-1","-2", "-3", "-4"]

        var contactArray = [CWContactUser]()
        for index in 0..<titleArray.count {
            let item = CWContactUser()
            item.userId = idArray[index]
            item.nikeName = titleArray[index]
            item.avatarPath = iconArray[index]
            contactArray.append(item)
        }
        defaultGroup = CWContactGroup(userList: contactArray)
    }
    
}
