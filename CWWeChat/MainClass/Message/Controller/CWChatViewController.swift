//
//  CWChatViewController.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/22.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit
import CocoaLumberjack

class CWChatViewController: CWBaseMessageViewController {

    var contactId: String!
    
    //存储数据库
    var dbMessageStore:CWChatDBMessageStore = {
       return CWChatDBDataManager.sharedInstance.dbMessageStore
    }()
    
    /// 消息发送主要的类
    var messageDispatchQueue:CWMessageDispatchQueue = {
        return CWXMPPManager.shareXMPPManager.messageDispatchQueue
    }()
    
    /// 消息数据数组
    var messageList = Array<CWMessageModel>()
    
    /// TableView
    lazy var tableView: UITableView = {
        let frame = CGRect(x: 0, y: 0,
                           width: Screen_Width, height: Screen_Height-45)
        let tableView = UITableView(frame: frame, style: .Plain)
        tableView.autoresizingMask = [.FlexibleHeight,.FlexibleWidth]
        tableView.backgroundColor = UIColor(hexString: "#EBEBEB")
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.separatorStyle = .None
        tableView.dataSource = self
        return tableView
    }()
    
    /// 下面的toolBar
    lazy var chatToolBar:CWInputToolBar = {
        let frame = CGRect(x: 0, y: Screen_Height-45,
                           width: Screen_Width, height: 45)
        let chatToolBar = CWInputToolBar(frame:frame)
        chatToolBar.delegate = self
        return chatToolBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()

        setupUI()
        registerCell()
    }
    
    /**
     设置UI布局
     */
    func setupUI() {
        self.edgesForExtendedLayout = .None
        self.view.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.chatToolBar)
    }
    
    /**
     注册cell class
     */
    func registerCell() {
        
        tableView.registerClass(CWBaseMessageCell.self, forCellReuseIdentifier: CWMessageType.None.reuseIdentifier())
        tableView.registerClass(CWTextMessageCell.self, forCellReuseIdentifier: CWMessageType.Text.reuseIdentifier())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


// MARK: - UITableViewDelegate
extension CWChatViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
}

// MARK: - UITableViewDataSource
extension CWChatViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageList.count
    }
    
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        let message = messageList[indexPath.row]
//        return message.messageFrame.heightOfCell
//    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let message = messageList[indexPath.row]
        
        let chatMessageCell = tableView.dequeueReusableCellWithIdentifier(message.messageType.reuseIdentifier(), forIndexPath: indexPath) as! CWBaseMessageCell
        chatMessageCell.updateMessage(message)
        return chatMessageCell
    }
}


extension CWChatViewController {
    
    /**
     是否需要显示消息的时间
     
     - parameter date: 当前消息的发送时间
     
     - returns: 是否需要显示
     */
    func messageNeedShowTime(date:NSDate) -> Bool {
        
//        msgAccumulate += 1
//        let messageInterval = date.timeIntervalSince1970 - lastDateInterval
//        //消息间隔
//        if msgAccumulate > MAX_SHOWTIME_MESSAGE_COUNT ||
//            lastDateInterval == 0 ||
//            messageInterval > MAX_SHOWTIME_MESSAGE_SECOND{
//            lastDateInterval = date.timeIntervalSince1970
//            msgAccumulate = 0
//            return true
//        }
        return false
    }
    
}


extension CWChatViewController: CWInputToolBarDelegate {
    
    func chatInputView(inputView: CWInputToolBar, sendText text: String) {
        DDLogDebug("发送文字:\(text)")
        
        let message = CWMessageModel()
        message.content = text
        message.messageOwnerType = .Myself
        sendMessage(message)
    }
    
    func chatInputView(inputView: CWInputToolBar, sendImage imageName: String ,extentInfo:Dictionary<String,AnyObject>) {
        
    }
    
    
    /**
     发送消息体
     
     发送消息 先保存数据库 保存成功后天就到数据库，并且发送到服务器
     - parameter message: 消息体
     */
    func sendMessage(message: CWMessageProtocol)  {
        
        message.messageSendId = CWUserAccount.sharedUserAccount.userID
        message.messageReceiveId = contactId
        
//        message.showTime = messageNeedShowTime(message.messageSendDate)
        if dbMessageStore.addMessage(message) {
            dispatchMessage(message)
//            messageList.append(message)
            let indexPath = NSIndexPath(forRow: messageList.count-1, inSection: 0)
            self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .None)
            updateMessageAndScrollBottom(false)
        }
    }

    
    ///滚动到底部
    func updateMessageAndScrollBottom(animated:Bool = true) {
        if messageList.count == 0 {
            return
        }
        let indexPath = NSIndexPath(forRow: messageList.count-1, inSection: 0)
        self.tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Bottom, animated: animated)
    }
}

// MARK: - 发送消息部分
extension CWChatViewController {
    
    
    //重复发送消息
    
    /**
     发送消息到服务器
     
     - parameter message: 消息体
     */
    private func dispatchMessage(message: CWMessageProtocol) {
        messageDispatchQueue.sendMessage(message)
    }
    
    
}
