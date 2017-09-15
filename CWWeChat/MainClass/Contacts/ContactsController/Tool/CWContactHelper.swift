//
//  CWContactHelper.swift
//  CWWeChat
//
//  Created by wei chen on 2017/4/3.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import SwiftyJSON

typealias CWContactListChanged = ([CWContactGroupModel], [String], Int) -> Void

typealias CWFetchContactComplete = (CWContactModel,CWChatError?) -> Void

public class CWContactHelper: NSObject {

    static let share = CWContactHelper()
    ///默认的分组
    fileprivate var defaultGroup = CWContactGroupModel()
    
    var contactsData = [CWContactModel]()
    var contactsDict = [String: CWContactModel]()

    var sortContactsData = [CWContactGroupModel]()
    var sortSectionHeaders = [String]()
    
    var dataChange: CWContactListChanged?

    var contactCount: Int {
        return contactsData.count
    }
    
    private override init() {
        super.init()
        setupDefaultGroup()
        initTestData()
    }
    
    func fetchContactById(_ userId: String, complete: CWFetchContactComplete) {
        
        if let contact = contactsDict[userId] {
            complete(contact, nil)
        }
        
        // 如果没有找到，进行网络查询
        
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
            let userId = subJson["userID"].stringValue
            let username = subJson["username"].stringValue
            let user = CWContactModel(userId: userId, username: username)
            user.remarkName = subJson["remarkName"].string
            user.nickname = subJson["nikeName"].string
            user.avatarURL = subJson["avatarURL"].url
            contactsData.append(user)
            contactsDict[userId] = user
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
        
        // 第一组
        var tempInitial = contactsData[0].pinyingInitial.fistLetter
        var currentGroup = CWContactGroupModel(groupName: tempInitial)
        analyzeGroupData.append(currentGroup)
        sectionHeaders.append(tempInitial)
        
        for contactModel in contactsData {

            //首字母
            let initial = contactModel.pinyingInitial.fistLetter         
            if matchLetter(string: initial) == false {
                othergroup.append(contactModel)
                continue
            }
            
            //如果不相同，则说明之前没有这个首字母添加到数组，
            if initial != tempInitial {
            
                tempInitial = initial
                currentGroup = CWContactGroupModel(groupName: initial)
                currentGroup.append(contactModel)
            
                analyzeGroupData.append(currentGroup)
                sectionHeaders.append(tempInitial)
                
            } else {
                currentGroup.append(contactModel)
            }
            
        }
        
        
        if (othergroup.contactCount > 0) {
            analyzeGroupData.append(othergroup)
            sectionHeaders.append(othergroup.groupName!)
        }
        
        sortContactsData = analyzeGroupData
        sortSectionHeaders = sectionHeaders
    
        DispatchQueue.main.async(execute: {
            self.dataChange?(self.sortContactsData,
                             self.sortSectionHeaders,
                             self.contactsData.count)
        })
        
    }
    
    // 判断是否为字母
    func matchLetter(string: String) -> Bool {
        if string.characters.count == 0 {return false}
        let index = string.index(string.startIndex, offsetBy: 1)
        let regextest = NSPredicate(format: "SELF MATCHES %@", "^[A-Za-z]+$")
        return regextest.evaluate(with: string[..<index])
    }
    
    //初始化默认的组
    func setupDefaultGroup() {
        
        let titleArray = ["新的朋友","群聊", "标签", "公众号"]
        let iconArray = ["contact_new_friend","contact_group_chat",
                         "contact_signature","contact_official_account"]
        let idArray = ["-1","-2", "-3", "-4"]
        
        var contactArray = [CWContactModel]()
        for index in 0..<titleArray.count {
            let item = CWContactModel(userId: idArray[index], username: "")
            item.nickname = titleArray[index]
            item.avatarPath = iconArray[index]
            contactArray.append(item)
        }
        defaultGroup.append(contentsOf: contactArray)
    }
    
}
