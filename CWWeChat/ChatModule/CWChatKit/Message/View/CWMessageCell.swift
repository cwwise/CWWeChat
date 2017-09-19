//
//  CWMessageCell.swift
//  CWWeChat
//
//  Created by wei chen on 2017/7/14.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

protocol CWMessageCellDelegate: NSObjectProtocol {
    
    /// 点击cell文字中的URL
    ///
    /// - Parameters:
    ///   - cell: cell
    ///   - link: link
    func messageCellDidTap(_ cell: CWMessageCell, link: URL)
    
    /// 点击cell文字中的电话
    ///
    /// - Parameters:
    ///   - cell: cell
    ///   - phone: phone
    func messageCellDidTap(_ cell: CWMessageCell, phone: String)
    
    /// cell被点击
    ///
    /// - Parameter cell: cell
    func messageCellDidTap(_ cell: CWMessageCell)
    
    /// cell 重发按钮点击
    ///
    /// - Parameter cell: cell
    func messageCellResendButtonClick(_ cell: CWMessageCell)
    
    /// 头像点击的回调方法
    ///
    /// - Parameter userId: 用户id
    func messageCellUserAvatarDidClick(_ userId: String)
}

/*
 
 cell 每一种cell 对应左右布局 两种不同的reuseIdentifier
 
 TextContentView
 ImageContentView
 
 
 **/

class CWMessageCell: UICollectionViewCell {
    
    weak var delegate: CWMessageCellDelegate?
        
    var message: CWMessageModel?
    
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
        let messageType = CWMessageType(identifier: self.reuseIdentifier!)
        
        switch messageType {
        case .text:
            messageContentView = TextMessageContentView()
        case .image:
            messageContentView = ImageMessageContentView()
        case .voice:
            messageContentView = VoiceMessageContentView()
//        case .video:
//            <#code#>
//        case .file:
//            <#code#>
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
    lazy var errorButton:UIButton = {
        let errorButton = UIButton(type: .custom)
        errorButton.setImage(CWAsset.MessageSendFail.image, for: UIControlState())
        errorButton.sizeToFit()
        errorButton.addTarget(self, action: #selector(errorButtonClick(_:)), for: .touchUpInside)
        errorButton.isHidden = true
        return errorButton
    }()
    
    ///手势操作
    fileprivate(set) lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(bubbleTapped(_:)))
        return tapGestureRecognizer
    }()
    
    fileprivate(set) lazy var doubletapGesture: UITapGestureRecognizer = {
        let doubletapGesture = UITapGestureRecognizer(target: self, action: #selector(bubbleDoubleTapped(_:)))
        doubletapGesture.numberOfTapsRequired = 2
        return doubletapGesture
    }()
    
    fileprivate(set) lazy var longPressGestureRecognizer: UILongPressGestureRecognizer = {
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
    func refresh(message: CWMessageModel) {
        self.message = message
        
        updateState()
        // 赋值
        let userId = message.targetId
        let avatarURL = "\(kImageBaseURLString)\(userId).jpg"
        avatarImageView.kf.setImage(with: URL(string: avatarURL), placeholder: defaultHeadeImage)
    
        self.messageContentView.refresh(message: message)
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
        self.messageContentView.updateProgress()
    }
    
    // MARK: cell中的事件处理
    ///头像点击
    @objc func avatarViewDidTapDown(_ tap: UITapGestureRecognizer) {
        
        guard let delegate = self.delegate, let message = message, tap.state == .ended  else {
            return
        }
        
        let targetId = message.isSend ? message.targetId : message.senderId
        delegate.messageCellUserAvatarDidClick(targetId)
    }
    
    // MARK: 手势事件
    @objc func bubbleTapped(_ tapGestureRecognizer: UITapGestureRecognizer) {
        
        guard tapGestureRecognizer.state == .ended else {
            return
        }
        
        self.delegate?.messageCellDidTap(self)
    }
    
    @objc func bubbleDoubleTapped(_ tapGestureRecognizer: UITapGestureRecognizer) {
        
        
    }
    
    @objc func bubbleLongPressed(_ longPressGestureRecognizer: UILongPressGestureRecognizer) {
        if longPressGestureRecognizer.state == .began {
            
  
        }
    }
    
    @objc func errorButtonClick(_ button: UIButton) {
        self.delegate?.messageCellResendButtonClick(self)
    }
    
    override var isSelected: Bool {
        didSet {
            
        }
    }
    
    // MARK: UIMenuController
    @objc func copyContentMessage() {
        
    }
    
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - UIGestureRecognizerDelegate
extension CWMessageCell: UIGestureRecognizerDelegate {


}

// MARK: - 布局
extension CWMessageCell {
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        
        guard let layoutAttributes = layoutAttributes as? CWMessageLayoutAttributes else {
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
