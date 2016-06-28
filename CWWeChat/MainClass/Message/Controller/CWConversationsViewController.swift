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
        addDefaultData()
        setupFriends()
        
        manager.connectProcess()
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
        let manager = CWContactManager.shareContactManager
        print(manager.contactCount)
    }
    
    func sendMessage() {
        
        let to = "chenwei"+"@"+xmppDomain;
        let message = CWMessageModel()
        message.messageReceiveId = to
        message.content = "Hello world"
        message.messageType = .Text
        
        manager.messageDispatchQueue.sendMessage(message)
        
    }
    
    func addDefaultData() {
        
        let model1 = CWConversationModel()
        model1.partnerID = "tom@chenweiim.com"
        model1.content = "Tom"
        model1.conversationDate = NSDate()
        
        let model2 = CWConversationModel()
        model2.partnerID = "jerry@chenweiim.com"
        model2.content = "Jerry"
        model2.conversationDate = NSDate()
        
        let model3 = CWConversationModel()
        model3.partnerID = "chenwei@chenweiim.com"
        model3.content = "Chenwei"
        model3.conversationDate = NSDate()
        
        conversationList.append(model1)
        conversationList.append(model2)
        conversationList.append(model3)
        
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK: UITableViewDelegate
extension CWConversationsViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let deleteTitle = "删除"
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: deleteTitle) { (action:UITableViewRowAction, indexPath) in
            
            //获取当前model
            _ = self.conversationList[indexPath.row]
            //数组中删除
            self.conversationList.removeAtIndex(indexPath.row)
            //从数据库中删除
            
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
