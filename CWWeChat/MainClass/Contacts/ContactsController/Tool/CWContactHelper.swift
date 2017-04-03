//
//  CWContactHelper.swift
//  CWWeChat
//
//  Created by wei chen on 2017/4/3.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import SwiftyJSON

typealias CWContactListChanged = ([CWContactGroupModel],[String],Int)->Void

class CWContactHelper: NSObject {

    ///默认的分组
    fileprivate var defaultGroup: CWContactGroupModel!
    
    var contactsData = [CWContactModel]()

    var sortContactsData = [CWContactGroupModel]()
    var sortSectionHeaders = [String]()
    
    var dataChange: CWContactListChanged?

    var contactCount: Int {
        return contactsData.count
    }
    
    override init() {
        super.init()
        setupDefaultGroup()
        initTestData()

    }
    
    func initTestData() {
        
        ///读取数据
        let path = Bundle.main.path(forResource: "ContactList", ofType: "json")
        guard let filepath = path else {
            log.error("不存在 ContactList.json 文件。")
            return
        }
        let contantData = try? Data(contentsOf: URL(fileURLWithPath: filepath))
        let contactList = JSON(data: contantData!)
        
        for (_,subJson):(String, JSON) in contactList {
            let userId = subJson["userID"].string!
            let username = subJson["username"].string!
            let user = CWContactModel(userId: userId, username: username)
            user.remarkName = subJson["remarkName"].string
            user.nickname = subJson["nikeName"].string
            user.avatarURL = subJson["avatarURL"].string
            contactsData.append(user)
        }
        
        DispatchQueue.global().async {
            self.sortContactData()
        }
    }
    
    ///对数据进行排序分组
    func sortContactData() {
        
        //先根据拼音的首字母排序
        contactsData.sort { (leftUser, rightUser) -> Bool in
            let pingYingA = leftUser.pinying
            let pingYingB = rightUser.pinying
            return pingYingA < pingYingB
        }
        
        //头部分
        var analyzeGroupData = [CWContactGroupModel]()
        analyzeGroupData.append(self.defaultGroup)
        
        var sectionHeaders = [UITableViewIndexSearch]
        
        
        // 遍历数据 根据首字母 如果没有拼音字母 则添加到＃组别中
        let othergroup = CWContactGroupModel(groupName: "#")
        
        var currentGroup: CWContactGroupModel?
        var lastInitial = "-1"
        
        for contactModel in contactsData {

            //首字母
            let initial = contactModel.pinying
            if initial.characters.count == 0 {
                othergroup.append(contactModel)
                continue
            }
            
            // 添加判断 是不是字符
            //如果不相同，则说明之前没有这个首字母添加到数组，
            if initial != lastInitial {
                if (currentGroup != nil) && currentGroup!.contactCount > 0 {
                    analyzeGroupData.append(currentGroup!)
                    sectionHeaders.append(currentGroup!.groupName!)
                }
                lastInitial = initial
                currentGroup = CWContactGroupModel(groupName: initial)
                currentGroup?.append(contactModel)
                
            } else {
                currentGroup!.append(contactModel)
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
        sortContactsData.append(contentsOf: analyzeGroupData)
        
        sortSectionHeaders.removeAll()
        sortSectionHeaders.append(contentsOf: sectionHeaders)
        
        
        DispatchQueue.main.async(execute: {
            self.dataChange?(self.sortContactsData,
                             self.sortSectionHeaders,
                             self.contactsData.count)
        })
        
    }
    
    //初始化默认的组
    func setupDefaultGroup() {
        
        let titleArray = ["新的朋友","群聊", "标签", "公众号"]
        let iconArray = ["friends_new","friends_group", "friends_tag", "friends_public"]
        let idArray = ["-1","-2", "-3", "-4"]
        
        var contactArray = [CWContactModel]()
        for index in 0..<titleArray.count {
            let item = CWContactModel(userId: idArray[index], username: "")
            item.nickname = titleArray[index]
            item.avatarURL = iconArray[index]
            contactArray.append(item)
        }
        defaultGroup = CWContactGroupModel(contactList: contactArray)
    }
    
}
