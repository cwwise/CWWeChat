//
//  MessageController.swift
//  ChatKit
//
//  Created by chenwei on 2017/10/3.
//

import UIKit
import ChatClient

open class MessageController: UIViewController {

    var messageList: [MessageModel] = [MessageModel]()

    public var conversation: Conversation
    
    public lazy var backgroundImageView: UIImageView = {
        let backgroundImageView = UIImageView()
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.frame = self.view.bounds
        backgroundImageView.clipsToBounds = true
        return backgroundImageView
    }()
    
    lazy var collectionView: UICollectionView = {
        let frame = CGRect(x: 0, y: 0,
                           width: kScreenWidth, height: kScreenHeight)
        let layout = MessageViewLayout()
        layout.delegate = self
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
        
        loadMessageData()
    }
    
    func loadMessageData() {
        self.conversation.fetchMessagesStart { (list, error) in
            if error == nil {
                let messageList = list.map({ (message) -> MessageModel in
                    return MessageModel(message: message)
                })
                self.messageList.append(contentsOf: messageList)
                self.collectionView.reloadData()
                self.updateMessageAndScrollBottom(false)
            }
        }
    }
    
    /// 滚动到底部
    public func updateMessageAndScrollBottom(_ animated:Bool = true) {
        if messageList.count == 0 {
            return
        }
        let indexPath = IndexPath(row: messageList.count-1, section: 0)
        self.collectionView.scrollToItem(at: indexPath, at: .bottom, animated: animated)
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
        self.collectionView.reloadData()
        updateMessageAndScrollBottom(false)
        
    }
    
}

extension MessageController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messageList.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let message = messageList[indexPath.row]
        let identifier = message.messageType.identifier
        let messageCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! MessageCell
        messageCell.message = message
        messageCell.delegate = self
        messageCell.refresh()
        return messageCell
    }
    
}

extension MessageController: MessageViewLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, itemAt indexPath: IndexPath) -> MessageModel {
        return messageList[indexPath.row]
    }
}

extension MessageController: MessageCellDelegate {

}







