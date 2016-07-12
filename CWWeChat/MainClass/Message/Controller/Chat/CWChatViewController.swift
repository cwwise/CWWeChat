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
    
    /// 消息发送主要的类
    var messageDispatchQueue:CWMessageDispatchQueue = {
        return CWXMPPManager.shareXMPPManager.messageDispatchQueue
    }()
    
    /// 消息数据数组
    var messageList = Array<CWMessageModel>()
    
    /// 键盘相关
    lazy var moreKeyBoardhelper: CWMoreKeyBoardHelper = {
       let moreKeyBoardhelper = CWMoreKeyBoardHelper()
        return moreKeyBoardhelper
    }()
    
    //MARK: UI属性
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
    
    lazy var rightBarItem: UIBarButtonItem = {
        let rightBarItem = UIBarButtonItem(image: CWAsset.Nav_chat_single.image, style: .Plain, target: self, action: #selector(CWChatViewController.rightBarItemDown(_:)))
        return rightBarItem
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
        
        self.navigationItem.rightBarButtonItem = rightBarItem
        
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
        tableView.registerClass(CWTimeMessageCell.self, forCellReuseIdentifier: CWMessageType.Time.reuseIdentifier())

    }
    
    func rightBarItemDown(barItem: UIBarButtonItem) {
        let chatDetailVC = CWChatDetailViewController()
        chatDetailVC.contactModel = friendUser
        self.navigationController?.pushViewController(chatDetailVC, animated: true)
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
        if message.messageType == .Time {
            return 25
        }
        return message.messageFrame.heightOfCell
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let message = messageList[indexPath.row] 
        
        if message.messageType == .Time {
            let timeMessageCell = tableView.dequeueReusableCellWithIdentifier(message.messageType.reuseIdentifier(), forIndexPath: indexPath) as! CWTimeMessageCell
            timeMessageCell.updateMessage(message)
            return timeMessageCell
        }
        
        let chatMessageCell = tableView.dequeueReusableCellWithIdentifier(message.messageType.reuseIdentifier(), forIndexPath: indexPath) as! CWBaseMessageCell
        chatMessageCell.delegate = self
        chatMessageCell.updateMessage(message)
        return chatMessageCell
    }
}

// MARK: - ChatMessageCellDelegate
extension CWChatViewController: ChatMessageCellDelegate {
    
    func messageCellUserAvatarDidClick(userId: String) {
       
        let chatVC = CWDetailContactViewController()
        chatVC.contactID = userId
        chatVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(chatVC, animated: true)
        
    }
    
    
    func messageCellDidSelect(cell: CWBaseMessageCell) {
        
        guard let message = cell.message else {
            return
        }
        
        if message.messageType == .Image {
            let _ = message.messageContent as! CWImageMessageContent
            let browserVC = CWPhotoBrowserController()
            //                browserVC.imageArray = [NSFileManager.pathUserChatImage(imageMessage.imagePath!)]
            self.navigationController?.pushViewController(browserVC, animated: true)
        }
        
    }
    
    
    func messageCellDoubleClick(cell: CWBaseMessageCell) {
        
        guard let message = cell.message else {
            return
        }
        
        if message.messageType == .Text {
            let textMessage = message.messageContent as! CWTextMessageContent
            let displayView = CWChatTextDisplayView()
            displayView.showInView(self.navigationController!.view, attrText: textMessage.attributeText)
        }
        
        
    }
}



