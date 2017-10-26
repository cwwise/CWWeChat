//
//  MessageCell.swift
//  ChatKit
//
//  Created by chenwei on 2017/10/4.
//

import UIKit
import Kingfisher
import ChatClient

public class MessageCell: UICollectionViewCell {
    
    weak var delegate: MessageCellDelegate?
    
    var message: MessageModel?
    
    // MARK: 属性
    /// 用户名称
    var usernameLabel:UILabel = {
        let usernameLabel = UILabel()
        usernameLabel.backgroundColor = UIColor.clear
        usernameLabel.font = UIFont.systemFont(ofSize: 12)
        usernameLabel.text = "nickname"
        return usernameLabel
    }()
    
    /// 头像
    lazy var avatarImageView:UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.contentMode = .scaleAspectFit
        avatarImageView.backgroundColor = UIColor.gray
        avatarImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(avatarViewDidTapDown(_:)))
        avatarImageView.addGestureRecognizer(tap)
        return avatarImageView
    }()
    
    /// 消息的内容部分
    lazy var messageContentView: MessageContentView = {
        
        let messageContentView: MessageContentView
        let messageType = MessageType(identifier: self.reuseIdentifier!)
        
        switch messageType {
        case .text:
            messageContentView = TextMessageContentView()
        case .image:
            messageContentView = ImageMessageContentView()
        case .voice:
            messageContentView = VoiceMessageContentView()
        case .location:
            messageContentView = LocationMessageContentView()
        case .emoticon:
            messageContentView = EmoticonMessageContentView()
        case .notification:
            messageContentView = NotificationMessageContentView()
        default:
            messageContentView = MessageContentView()
        }
        
        messageContentView.addGestureRecognizer(self.longPressGestureRecognizer)
        messageContentView.addGestureRecognizer(self.doubletapGesture)
        
        messageContentView.addGestureRecognizer(self.tapGestureRecognizer)
        self.tapGestureRecognizer.require(toFail: self.doubletapGesture)
        self.tapGestureRecognizer.require(toFail: self.longPressGestureRecognizer)
        
        self.contentView.addSubview(messageContentView)
        
        return messageContentView
    }()
    
    /// 指示
    var activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    /// 发送失败按钮
    lazy var errorButton: UIButton = {
        let errorButton = UIButton(type: .custom)
        errorButton.addTarget(self, action: #selector(errorButtonClick(_:)), for: .touchUpInside)
        errorButton.isHidden = true
        return errorButton
    }()
    
    ///手势操作
    private(set) lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(bubbleTapped(_:)))
        return tapGestureRecognizer
    }()
    
    private(set) lazy var doubletapGesture: UITapGestureRecognizer = {
        let doubletapGesture = UITapGestureRecognizer(target: self, action: #selector(bubbleDoubleTapped(_:)))
        doubletapGesture.numberOfTapsRequired = 2
        return doubletapGesture
    }()
    
    private(set) lazy var longPressGestureRecognizer: UILongPressGestureRecognizer = {
        let longpressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(bubbleLongPressed(_:)))
        longpressGestureRecognizer.delegate = self
        return longpressGestureRecognizer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(avatarImageView)
        self.contentView.addSubview(usernameLabel)
        self.contentView.addSubview(activityView)
        self.contentView.addSubview(errorButton)
    }
        
    // 设置
    func refresh() {
        
        guard let message = message else {
            return
        }
        
        //
        setupFrame()
        // 更新消息状态
        updateState()
        
        // 设置头像信息
        // 如果是自己发送的 
        let avatarURL: URL
        if message.isSend {
            
        } else {
            
        }
        
        let userId = message.from
        let avatar = "\(userId).jpg"
        avatarImageView.kf.setImage(with: URL(string: avatar),
                                    placeholder: ChatAsset.defaultHeadImage.image)
        
        messageContentView.refresh(message: message)
    }
    
    func updateState() {
        guard let message = message else {
            return
        }
        // 如果是收到消息 则隐藏
        if message.isSend == false {
            activityView.stopAnimating()
            errorButton.isHidden = true
            return
        }
        
        // 发送中展示
        if message.sendStatus == .successed {
            activityView.stopAnimating()
            errorButton.isHidden = true
        }
        // 如果失败就显示重发按钮
        else if message.sendStatus == .failed {
            activityView.stopAnimating()
            errorButton.isHidden = false
        } else {
            activityView.startAnimating()
            errorButton.isHidden = true
        }
    }
    
    func updateProgress() {
        messageContentView.updateProgress()
    }
    
    // MARK: cell中的事件处理
    ///头像点击
    @objc
    func avatarViewDidTapDown(_ tap: UITapGestureRecognizer) {
        guard let message = message, tap.state == .ended else {
            return
        }
        
        let targetId = message.isSend ? message.from : ChatKit.share.currentAccount
        delegate?.messageCellUserAvatarDidClick(targetId)
    }
    
    // MARK: 手势事件
    @objc
    func bubbleTapped(_ tapGestureRecognizer: UITapGestureRecognizer) {
        
        guard tapGestureRecognizer.state == .ended else {
            return
        }
        
        delegate?.messageCellDidTap(self)
    }
    
    @objc
    func bubbleDoubleTapped(_ tapGestureRecognizer: UITapGestureRecognizer) {
        
        
    }
    
    @objc
    func bubbleLongPressed(_ longPressGestureRecognizer: UILongPressGestureRecognizer) {
        if longPressGestureRecognizer.state == .began {
            
            
        }
    }
    
    @objc
    func errorButtonClick(_ button: UIButton) {
        delegate?.messageCellResendButtonClick(self)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MessageCell: UIGestureRecognizerDelegate {
    
    
}


// 
extension MessageCell {
    
    func setupFrame() {
        guard let layoutAttributes = message?.messageFrame else {
            return
        }
        
        avatarImageView.frame = layoutAttributes.avaterFrame
        usernameLabel.frame = layoutAttributes.usernameFrame
        messageContentView.frame = layoutAttributes.messageContainerFrame
        
        //
        activityView.frame = layoutAttributes.activityFrame
        errorButton.frame = layoutAttributes.errorFrame
    }
    
}





