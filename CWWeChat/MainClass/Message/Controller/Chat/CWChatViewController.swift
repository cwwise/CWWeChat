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
    var lastDateInterval:TimeInterval = 0
    var messageAccumulate:Int = 0
    var currentDate:Date = Date()
    
    /// 消息发送主要的类
    var messageDispatchQueue:CWMessageDispatchQueue = {
        return CWXMPPManager.shareXMPPManager.messageDispatchQueue
    }()
    
    /// 消息数据数组
    var messageList = Array<CWMessageModel>()
    var voicePlayer: CWVoicePlayer!

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
        let tableView = UITableView(frame: frame, style: .plain)
        tableView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        tableView.backgroundColor = UIColor(hexString: "#EBEBEB")
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.separatorStyle = .none
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
        chatToolBar.voiceIndicatorView = self.voiceIndicatorView
        return chatToolBar
    }()
    
    /**
     初始化 VoiceIndicator
     */
    lazy var voiceIndicatorView: CWVoiceIndicatorView = {
        let voiceIndicatorView = CWVoiceIndicatorView()
        voiceIndicatorView.isHidden = true
        self.view.addSubview(voiceIndicatorView)
        voiceIndicatorView.snp_makeConstraints(closure: { (make) in
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(self.view).offset(-20)
            make.size.equalTo(CGSize(width: 150, height: 150))
        })
        return voiceIndicatorView
    }()

    
    lazy var rightBarItem: UIBarButtonItem = {
        let rightBarItem = UIBarButtonItem(image: CWAsset.Nav_chat_single.image, style: .plain, target: self, action: #selector(rightBarItemDown(_:)))
        return rightBarItem
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
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
        self.edgesForExtendedLayout = UIRectEdge()
        self.view.backgroundColor = UIColor.white
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
        
        tableView.register(CWBaseMessageCell.self, forCellReuseIdentifier: CWMessageType.none.reuseIdentifier())
        tableView.register(CWTextMessageCell.self, forCellReuseIdentifier: CWMessageType.text.reuseIdentifier())
        tableView.register(CWImageMessageCell.self, forCellReuseIdentifier: CWMessageType.image.reuseIdentifier())
        tableView.register(CWVoiceMessageCell.self, forCellReuseIdentifier: CWMessageType.voice.reuseIdentifier())
        tableView.register(CWTimeMessageCell.self, forCellReuseIdentifier: CWMessageType.time.reuseIdentifier())

    }
    
    func rightBarItemDown(_ barItem: UIBarButtonItem) {
        let chatDetailVC = CWChatDetailViewController()
        chatDetailVC.contactModel = friendUser
        self.navigationController?.pushViewController(chatDetailVC, animated: true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


// MARK: - UITableViewDelegate
extension CWChatViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
}

// MARK: - UITableViewDataSource
extension CWChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let message = messageList[(indexPath as NSIndexPath).row]
        if message.messageType == .time {
            return 25
        }
        return message.messageFrame.heightOfCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messageList[(indexPath as NSIndexPath).row] 
        
        if message.messageType == .time {
            let timeMessageCell = tableView.dequeueReusableCell(withIdentifier: message.messageType.reuseIdentifier(), for: indexPath) as! CWTimeMessageCell
            timeMessageCell.updateMessage(message)
            return timeMessageCell
        }
        
        let chatMessageCell = tableView.dequeueReusableCell(withIdentifier: message.messageType.reuseIdentifier(), for: indexPath) as! CWBaseMessageCell
        chatMessageCell.delegate = self
        chatMessageCell.updateMessage(message)
        return chatMessageCell
    }
}

// MARK: - ChatMessageCellDelegate
extension CWChatViewController: ChatMessageCellDelegate {
    
    func messageCellUserAvatarDidClick(_ userId: String) {
       
        let chatVC = CWDetailContactViewController()
        chatVC.contactID = userId
        chatVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(chatVC, animated: true)
        
    }
    
    
    func messageCellDidSelect(_ cell: CWBaseMessageCell) {
        
        guard let message = cell.message else {
            return
        }
        
        if message.messageType == .image {
            let _ = message.messageContent as! CWImageMessageContent
            let browserVC = CWPhotoBrowserController()
            //                browserVC.imageArray = [NSFileManager.pathUserChatImage(imageMessage.imagePath!)]
            self.navigationController?.pushViewController(browserVC, animated: true)
        }
        
        else if message.messageType == .voice {
            //FIX: 必须用成员变量 否则会释放，导致无法播放
            //播放之后 状态修改为已经播放保存到数据库
//            let voiceMessage = message.messageContent as! CWVoiceMessageContent
//            voiceMessage.messagePlayState = .Played
//            self.dbMessageStore.updateMessageStateByMessage(voiceMessage)
            voicePlayer = CWVoicePlayer(message: message)
            voicePlayer.startPlay()
        }
        
    }
    
    
    func messageCellDoubleClick(_ cell: CWBaseMessageCell) {
        
        guard let message = cell.message else {
            return
        }
        
        if message.messageType == .text {
            let textMessage = message.messageContent as! CWTextMessageContent
            let displayView = CWChatTextDisplayView()
            displayView.showInView(self.navigationController!.view, attrText: textMessage.attributeText)
        }
        
        
    }
}



