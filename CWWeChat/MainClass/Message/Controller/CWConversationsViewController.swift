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
    
    //存储数据库
    lazy var dbRecordStore:CWChatDBRecordStore = {
        return CWChatDBDataManager.sharedInstance.dbRecordStore
    }()
    
    let manager = CWXMPPManager.shareXMPPManager
    var userID: String = CWUserAccount.sharedUserAccount().userID


    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.bounds, style: .Plain)
        tableView.backgroundColor = UIColor.whiteColor()
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
        
        self.dbRecordStore.delegate = self
        manager.connectProcess()
        
        conversationList = dbRecordStore.allMessageRecordByUid(userID)
        self.tableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
        
        self.title = "微信"
        self.view.addSubview(self.tableView)
    }
    
    func registerCellClass() {
        self.tableView.registerClass(CWConversationCell.self, forCellReuseIdentifier: CWConversationCell.reuseIdentifier)
        //测试发送消息
        let rightBarItem = UIBarButtonItem(title: "发送", style: .Plain, target: self, action: #selector(sendMessage))
        self.navigationItem.rightBarButtonItem = rightBarItem
    }
    
    func setupFriends() {
        _ = CWContactManager.shareContactManager
    }
    
    func sendMessage() {
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

//MARK: UITableViewDelegate
extension CWConversationsViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let deleteTitle = "删除"
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: deleteTitle) { (action:UITableViewRowAction, indexPath) in
            
            //获取当前model
            let conversation = self.conversationList[indexPath.row]
            //数组中删除
            self.conversationList.removeAtIndex(indexPath.row)
            //从数据库中删除
            self.dbRecordStore.deleteMessageRecordByUid(self.userID, fid: conversation.partnerID)
            //删除
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
        
        let actionTitle = "标记已读"
        let moreAction = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: actionTitle) { (action:UITableViewRowAction, indexPath) in
            
            tableView.setEditing(false, animated: true)
        }
        return [deleteAction,moreAction]
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let chatVC = CWChatViewController()
        chatVC.contactId = self.conversationList[indexPath.row].partnerID
        chatVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(chatVC, animated: true)
    }
    
}

//MARK: UITableViewDataSource
extension CWConversationsViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.conversationList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CWConversationCell.reuseIdentifier, forIndexPath: indexPath) as! CWConversationCell
        cell.conversationModel = self.conversationList[indexPath.row]
        return cell
    }
}


extension CWConversationsViewController: CWChatDBRecordStoreDelegate {
    
    func needUpdateRecordList(record: CWConversationModel, isAdd: Bool) {
        
        if isAdd {
            self.conversationList.insert(record, atIndex: 0)
            let indexPath = NSIndexPath(forRow: 0, inSection: 0)
            self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .None)
        } else {
            self.conversationList = self.conversationList.filter({$0.partnerID != record.partnerID})
            self.conversationList.insert(record, atIndex: 0)
            self.tableView.reloadData()
//            let indexPath = NSIndexPath(forRow: 0, inSection: 0)
//            self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .None)
        }
        
      
    }
}

