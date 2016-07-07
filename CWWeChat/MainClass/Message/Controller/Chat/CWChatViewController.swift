//
//  CWChatViewController.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/22.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWChatViewController: CWBaseMessageViewController {

    /// block定义
    typealias CWCompleteAction = ()-> Void

    var contactId: String!
    var friendUser: CWContactUser? {
        didSet {
            self.title = friendUser?.nikeName
        }
    }
    
    /// 显示消息时间相关的
    var lastDateInterval:NSTimeInterval = 0
    var messageAccumulate:Int = 0
    var currentDate:NSDate = NSDate()
    
    //存储数据库
    lazy var dbMessageStore:CWChatDBMessageStore = {
       return CWChatDBDataManager.sharedInstance.dbMessageStore
    }()
    
    //存储数据库
    lazy var dbRecordStore:CWChatDBRecordStore = {
        return CWChatDBDataManager.sharedInstance.dbRecordStore
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
        tableView.estimatedRowHeight = 50
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
        registerKeyboardNotifacation()
        
        self.refreshLocalMessage {
            //先刷新数据，再滚动到底部
            self.tableView.reloadData()
            //将消息插入数组 并刷新列表 并滚动到最下面
            self.updateMessageAndScrollBottom(false)
        }
    }
    
    /**
     设置UI布局
     */
    func setupUI() {
        self.edgesForExtendedLayout = .None
        self.view.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.chatToolBar)
        
        self.messageDispatchQueue.delegate = self
        
        let user = CWContactManager.findContact(contactId)
        self.friendUser = user
    }
    
    /**
     注册cell class
     */
    func registerCell() {
        
        tableView.registerClass(CWBaseMessageCell.self, forCellReuseIdentifier: CWMessageType.None.reuseIdentifier())
        tableView.registerClass(CWTextMessageCell.self, forCellReuseIdentifier: CWMessageType.Text.reuseIdentifier())
        tableView.registerClass(CWImageMessageCell.self, forCellReuseIdentifier: CWMessageType.Image.reuseIdentifier())

    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
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
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let message = messageList[indexPath.row]
        return message.messageFrame.heightOfCell
    }
    
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




