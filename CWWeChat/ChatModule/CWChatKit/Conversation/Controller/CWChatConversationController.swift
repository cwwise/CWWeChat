//
//  CWChatConversationController.swift
//  CWWeChat
//
//  Created by chenwei on 2017/3/26.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

/// 会话
class CWChatConversationController: UIViewController {

    var conversationList = [CWChatConversationModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        let chatManager = CWChatClient.share.chatManager
        let result = chatManager.fetchAllConversations()
        for conversation in result {
            conversationList.append(CWChatConversationModel(conversation: conversation))
        }
        
        chatManager.addChatDelegate(self, delegateQueue: DispatchQueue.main)
        
        CWChatKit.share.userInfoDataSource = self
        
        setupUI()
        registerCellClass()
        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
        self.view.addSubview(self.tableView)
    }
    
    func registerCellClass() {
        self.tableView.register(CWChatConversationCell.self, forCellReuseIdentifier: CWChatConversationCell.identifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: 属性Getter
    /// TableView
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.rowHeight = 64.0
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
}

// MARK: - CWChatUserInfoDataSource
extension CWChatConversationController: CWChatUserInfoDataSource {
    func loadUserInfo(userId: String, completion: @escaping ((CWChatUser?) -> Void)) {
        
        DispatchQueueDelay(1.5) { 
            let model = CWChatUserModel(userId: "chenwei")
            model.nickname = "陈威"
            model.avatarURL = "http://o7ve5wypa.bkt.clouddn.com/chenwei.jpg"
            completion(model)
        }
    }
}


//MARK: UITableViewDelegate
extension CWChatConversationController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteTitle = "删除"
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: deleteTitle) { (action:UITableViewRowAction, indexPath) in
            
            //获取当前model
            let _ = self.conversationList[indexPath.row]
            //数组中删除
            self.conversationList.remove(at: indexPath.row)
            //从数据库中删除
            
            //删除
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        let actionTitle = "标记已读"
        let moreAction = UITableViewRowAction(style: UITableViewRowActionStyle.normal, title: actionTitle) { (action:UITableViewRowAction, indexPath) in
            
            tableView.setEditing(false, animated: true)
        }
        return [deleteAction,moreAction]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let chatVC = CWChatMessageController()
        let targetId = conversationList[indexPath.row].conversation.targetId
        chatVC.targetId = targetId
        chatVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(chatVC, animated: true)
    }
    
}

//MARK: UITableViewDataSource
extension CWChatConversationController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.conversationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CWChatConversationCell.identifier, for: indexPath) as! CWChatConversationCell
        cell.conversationModel = conversationList[indexPath.row]
        return cell
    }
}

// MARK: - CWChatManagerDelegate
extension CWChatConversationController: CWChatManagerDelegate {
    // 收到会话变化
    func conversationDidUpdate(_ conversation: CWChatConversation) {
        var isLocal = false
        for i in 0..<conversationList.count {
            let model = conversationList[i].conversation
            if model == conversation {
                isLocal = true
                model.appendMessage(conversation.lastMessage)
                
                self.tableView.beginUpdates()
                let indexPath = IndexPath(row: i, section: 0)
                tableView.reloadRows(at: [indexPath], with: .none)
                self.tableView.endUpdates()
                
                break
            }
        }
        
        if isLocal == false {
            let model = CWChatConversationModel(conversation: conversation)
            conversationList.insert(model, at: 0)
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.insertRows(at: [indexPath], with: .none)
        }
        
        
    }
}


