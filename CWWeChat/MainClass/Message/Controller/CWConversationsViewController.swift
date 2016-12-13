//
//  CWConversationsViewController.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/22.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWConversationsViewController: CWBaseMessageViewController {

    var conversationList = [CWConversationModel]()
    
    let manager = CWXMPPManager.shareXMPPManager
    var userID: String = CWUserAccount.sharedUserAccount().userID

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.rowHeight = 64.0
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "微信"

        setupUI()
        registerCellClass()
        setupFriends()
        
        setupXMPP()
        
        self.dbRecordStore.delegate = self
        conversationList = dbRecordStore.allMessageRecordByUid(userID)
        
        self.tableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    func setupXMPP() {
        /// 设置xmpp状态
        let listener = { (status: CWXMPPStatus) in
            var title = "微信"
            switch status {
            case .Connected:
                break
            default:
                title += "(\(status.rawValue))"
            }
            dispatch_async_safely_to_main_queue({ 
                self.navigationItem.title = title
            })
        }
        manager.statusListener = listener
        manager.connectProcess()
    }
    
    func setupUI() {
        self.title = "微信"
        self.view.addSubview(self.tableView)
        self.tabBarItem.badgeValue = self.dbRecordStore.allUnreadMessage()
    }
    
    func registerCellClass() {
        self.tableView.register(CWConversationCell.self, forCellReuseIdentifier: CWConversationCell.reuseIdentifier)
    }
    
    func setupFriends() {
        _ = CWContactManager.shareContactManager
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

//MARK: UITableViewDelegate
extension CWConversationsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteTitle = "删除"
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: deleteTitle) { (action:UITableViewRowAction, indexPath) in
            
            //获取当前model
            let conversation = self.conversationList[(indexPath as NSIndexPath).row]
            //数组中删除
            self.conversationList.remove(at: (indexPath as NSIndexPath).row)
            //从数据库中删除
            _ = self.dbRecordStore.deleteMessageRecordByUid(self.userID, fid: conversation.partnerID, deletemessage: true)
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
        let chatVC = CWChatViewController()
        chatVC.contactId = self.conversationList[(indexPath as NSIndexPath).row].partnerID
        chatVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(chatVC, animated: true)
    }
    
}

//MARK: UITableViewDataSource
extension CWConversationsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.conversationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CWConversationCell.reuseIdentifier, for: indexPath) as! CWConversationCell
        cell.conversationModel = self.conversationList[(indexPath as NSIndexPath).row]
        return cell
    }
}


extension CWConversationsViewController: CWChatDBRecordStoreDelegate {
    
    func needUpdateRecordList(_ record: CWConversationModel, isAdd: Bool) {
        
        self.tabBarItem.badgeValue = self.dbRecordStore.allUnreadMessage()
        if isAdd {
            self.conversationList.insert(record, at: 0)
            let indexPath = IndexPath(row: 0, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .none)
        } else {
            self.conversationList = self.conversationList.filter({$0.partnerID != record.partnerID})
            self.conversationList.insert(record, at: 0)
            self.tableView.reloadData()
//            let indexPath = NSIndexPath(forRow: 0, inSection: 0)
//            self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .None)
        }
    }
    
    func updateUnReadCount(_ record: CWConversationModel) {
        
        //只是更新unReadCount
        for conversation in conversationList {
            if record.partnerID == conversation.partnerID {
                conversation.unreadCount = 0
            }
        }
        self.tableView.reloadData()
        self.tabBarItem.badgeValue = self.dbRecordStore.allUnreadMessage()
    }
}

