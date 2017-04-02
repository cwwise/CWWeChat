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

    var sessionList = [CWChatConversationModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textObject = CWTextMessageBody(text: "1234")
        let message = CWChatMessage(targetId: "123", messageBody: textObject)
        let conversation = CWChatConversation(targetId: "", type: .single)
        conversation.lastMessage = message
        
        sessionList.append(CWChatConversationModel(conversation))
        
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

//MARK: UITableViewDelegate
extension CWChatConversationController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteTitle = "删除"
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: deleteTitle) { (action:UITableViewRowAction, indexPath) in
            
            //获取当前model
            let _ = self.sessionList[indexPath.row]
            //数组中删除
            self.sessionList.remove(at: indexPath.row)
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
        chatVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(chatVC, animated: true)
    }
    
}

//MARK: UITableViewDataSource
extension CWChatConversationController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sessionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CWChatConversationCell.identifier, for: indexPath) as! CWChatConversationCell
        cell.conversationModel = self.sessionList[(indexPath as NSIndexPath).row]
        return cell
    }
}


