//
//  MessageController.swift
//  ChatKit
//
//  Created by chenwei on 2017/10/3.
//

import UIKit
import ChatClient

open class MessageController: UIViewController {

    private var messageList: [MessageModel] = [MessageModel]()

    public var conversation: Conversation
    /// 显示时间处理
    private var messageTool: MessageTimeUtil = {
        let messageTool = MessageTimeUtil()
        return messageTool
    }()

    public lazy var backgroundImageView: UIImageView = {
        let backgroundImageView = UIImageView()
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.frame = self.view.bounds
        backgroundImageView.clipsToBounds = true
        return backgroundImageView
    }()
    
    public lazy var collectionView: UICollectionView = {
        let frame = CGRect(x: 0, y: 0,
                           width: kScreenWidth, height: kScreenHeight)
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
        collectionView.alwaysBounceVertical = true
        collectionView.register(MessageCell.self, forCellWithReuseIdentifier: MessageType.none.identifier)
        collectionView.register(MessageCell.self, forCellWithReuseIdentifier: MessageType.text.identifier)
        collectionView.register(MessageCell.self, forCellWithReuseIdentifier: MessageType.image.identifier)
        
        collectionView.register(MessageCell.self, forCellWithReuseIdentifier: MessageType.emoticon.identifier)
        collectionView.register(MessageCell.self, forCellWithReuseIdentifier: MessageType.location.identifier)
        collectionView.register(MessageCell.self, forCellWithReuseIdentifier: MessageType.voice.identifier)
        
        collectionView.register(TimeMessageHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        
        return collectionView
    }()
    
    convenience public init(conversationId: String) {
        let chatManager = ChatClient.share.chatManager
        let conversation = chatManager.fecthConversation(chatType: .single,
                                                         conversationId: conversationId)
        self.init(conversation: conversation)
    }
    
    public init(conversation: Conversation) {
        self.conversation = conversation
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(backgroundImageView)
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(collectionView)
        
        let chatManager = ChatClient.share.chatManager
        chatManager.addChatDelegate(self)
        
        loadMessageData()
    }
    
    func loadMessageData() {
        self.conversation.fetchMessagesStart { (list, error) in
            if error == nil {
                let messageList = list.map({ (message) -> MessageModel in
                    let messageModel = MessageModel(message: message)
                    self.messageTool.handleMessage(messageModel)
                    return messageModel
                })
                self.messageList.append(contentsOf: messageList)
                self.collectionView.reloadData()
                self.scrollToBottom(false)
            }
        }
    }
    
    /// 滚动到底部
    public func scrollToBottom(_ animated:Bool = true) {
        if messageList.count == 0 {
            return
        }
        let indexPath = IndexPath(row: 0, section: messageList.count-1)
        self.collectionView.scrollToItem(at: indexPath, at: .bottom, animated: animated)
    }
    
    func sendMessage(_ message: Message) {
        
        let messageModel = MessageModel(message: message)
        messageTool.handleMessage(messageModel)
        self.messageList.append(messageModel)
        
        self.collectionView.reloadData()
        self.scrollToBottom(true)
    }
    
    deinit {
        let chatManager = ChatClient.share.chatManager
        chatManager.removeChatDelegate(self)
        NotificationCenter.default.removeObserver(self)
    }

    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

// MARK: - CWChatManagerDelegate
extension MessageController: ChatManagerDelegate {
    
    // 消息状态发送变化
    public func didReceive(message: Message) {

        // 判断消息是否为当前targetId
        if message.conversationId != conversation.conversationId {
            return
        }
        
        let messageModel = MessageModel(message: message)
        messageList.append(messageModel)
        messageTool.handleMessage(messageModel)
        collectionView.reloadData()
        scrollToBottom(false)
    }
    
}

extension MessageController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return messageList.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let message = messageList[indexPath.section]
        let identifier = message.messageType.identifier
        let messageCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! MessageCell
        messageCell.message = message
        messageCell.delegate = self
        messageCell.refresh()
        return messageCell
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! TimeMessageHeaderView
        let message = messageList[indexPath.section]
        let date = Date(timeIntervalSince1970: message.timestamp)
        header.timeLabel.text = ChatTimeTool.chatTimeString(from: date)
        return header
    }
    
}

extension MessageController: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let message = messageList[indexPath.section]
        return message.messageFrame.sizeOfItem
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let message = messageList[section]
        if message.showTime {
            return CGSize(width: kScreenWidth, height: 40)
        }
        return CGSize(width: kScreenWidth, height: 0)
    }
    
}


extension MessageController: MessageCellDelegate {

    public func messageCellDidTap(_ cell: MessageCell, link: URL) {
        
    }
    
    public func messageCellDidTap(_ cell: MessageCell, phone: String) {
        
    }
    
    public func messageCellDidTap(_ cell: MessageCell) {
        
    }
    
    public func messageCellResendButtonClick(_ cell: MessageCell) {
        
    }
    
    public func messageCellUserAvatarDidClick(_ userId: String) {
        
    }
    
}







