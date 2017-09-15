//
//  CWContactHelper.swift
//  CWWeChat
//
//  Created by wei chen on 2017/4/3.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import SwiftyJSON

typealias CWContactListChanged = ([[CWUserModel]], [String], Int) -> Void

typealias CWFetchContactComplete = (CWUserModel,CWChatError?) -> Void

public class CWContactHelper: NSObject {

    static let share = CWContactHelper()
    ///默认的分组
    fileprivate var defaultGroup = [CWUserModel]()
    
    var contactsData = [CWUserModel]()
    var contactsDict = [String: CWUserModel]()

    var sectionHeaders = [String]()
    
    var sortedContactArray = [[CWUserModel]]()
    
    var dataChange: CWContactListChanged?
    
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
            let user = CWUserModel(userId: userId, username: username)
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
        
        sectionHeaders = [String]()
        let indexCollation = UILocalizedIndexedCollation.current()
        sectionHeaders.append(contentsOf: indexCollation.sectionTitles)
        
        // 设置数组
        var sortedArray = [[CWUserModel]]()
        for _ in 0..<sectionHeaders.count {
            sortedArray.append([CWUserModel]())
        }
        
        for contact in contactsData {
            let initial = contact.pinyingInitial.fistLetter
            // 如果不是字母
            let section: Int
            if matchLetter(string: initial) == false {
                section = sectionHeaders.count - 1
            } else {
                section = sectionHeaders.index(of: initial)!
            }
            sortedArray[section].append(contact)
        }
        
        // 去除空的section
        for i in (0..<sortedArray.count).reversed() {
            let sectionArray = sortedArray[i]
            if sectionArray.count == 0 {
                sortedArray.remove(at: i)
                sectionHeaders.remove(at: i)
            }
        }
        sortedArray.insert(defaultGroup, at: 0)
        
        self.sortedContactArray = sortedArray
        // 头部分
        DispatchQueue.main.async(execute: {
            self.dataChange?(self.sortedContactArray,
                             self.sectionHeaders,
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
        
        for index in 0..<titleArray.count {
            let item = CWUserModel(userId: idArray[index], username: "")
            item.nickname = titleArray[index]
            item.avatarImage = UIImage(named: iconArray[index])
            defaultGroup.append(item)
        }
    }
    
}
