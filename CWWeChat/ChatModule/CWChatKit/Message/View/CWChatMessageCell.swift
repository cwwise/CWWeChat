//
//  CWChatMessageCell.swift
//  CWWeChat
//
//  Created by chenwei on 2017/3/26.
//  Copyright © 2017年 chenwei. All rights reserved.
//

import UIKit

protocol CWChatMessageCellDelegate: NSObjectProtocol {
    
    /// 点击cell文字中的URL
    ///
    /// - Parameters:
    ///   - cell: cell
    ///   - link: link
    func messageCellDidTapLink(_ cell: CWChatMessageCell, link: URL)
    
    /// 点击cell文字中的电话
    ///
    /// - Parameters:
    ///   - cell: cell
    ///   - phone: phone
    func messageCellDidTapPhone(_ cell: CWChatMessageCell, phone: String)
    
    /// cell被点击
    ///
    /// - Parameter cell: cell
    func messageCellDidTap(_ cell: CWChatMessageCell)
    
    func messageCellResendButtonClick(_ cell: CWChatMessageCell)

    
    /// 头像点击的回调方法
    ///
    /// - Parameter userId: 用户id
    func messageCellUserAvatarDidClick(_ userId: String)
}

extension CWChatMessageCellDelegate {
    func messageCellDidTapLink(_ cell: CWChatMessageCell, link: URL) {}
    func messageCellDidTapPhone(_ cell: CWChatMessageCell, phone: String){}
    func messageCellUserAvatarDidClick(_ userId: String) {}
}

class CWChatMessageCell: UITableViewCell {

    weak var delegate: CWChatMessageCellDelegate?

    var messageModel: CWChatMessageModel!
    
    // MARK: 初始化
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    func setup() {
        self.backgroundColor = UIColor.clear
        self.selectionStyle = .none
    }

    func addGeneralView() {
        self.contentView.addSubview(self.avatarImageView)
        self.contentView.addSubview(self.usernameLabel)
        self.contentView.addSubview(self.messageContentView)
        self.contentView.addSubview(self.activityView)
        self.contentView.addSubview(self.errorButton)
    }
    
    /// 
    func updateMessage(_ messageModel: CWChatMessageModel) {
        self.messageModel = messageModel
        // 消息实体
        let message = messageModel.message
        
        var userId: String
        // 是自己的
        if message.direction == .send {
            
            // 头像
            avatarImageView.snp.remakeConstraints({ (make) in
                make.width.height.equalTo(kAvaterImageViewWidth)
                make.right.equalTo(self.contentView).offset(-kAvaterImageViewMargin)
                make.top.equalTo(kMessageCellTopMargin)
            })
            
            usernameLabel.snp.remakeConstraints({ (make) in
                make.top.equalTo(avatarImageView.snp.top);
                make.right.equalTo(avatarImageView.snp.left).offset(-kMessageCellEdgeOffset)
                make.width.lessThanOrEqualTo(120)
                make.height.equalTo(0)
            })
            
            // 内容
            messageContentView.snp.remakeConstraints({ (make) in
                make.right.equalTo(avatarImageView.snp.left).offset(-kAvatarToMessageContent)
                make.top.equalTo(usernameLabel.snp.bottom).offset(-ChatCellUI.bubbleTopMargin)
                make.size.equalTo(messageModel.messageFrame.contentSize)
            })
            
            activityView.snp.remakeConstraints({ (make) in
                make.right.equalTo(messageContentView.snp.left).offset(-3)
                make.centerY.equalTo(messageContentView).offset(-4)
            })
            
            errorButton.snp.remakeConstraints({ (make) in
                make.right.equalTo(messageContentView.snp.left).offset(-2)
                make.centerY.equalTo(messageContentView).offset(-4)
            })
            
            let image = #imageLiteral(resourceName: "sender_background_normal")
            let highlightedImage = #imageLiteral(resourceName: "sender_background_highlight")
            let cap = ChatCellUI.right_cap_insets
            backgroundImageView.image = image.resizableImage(withCapInsets: cap)
            backgroundImageView.highlightedImage = highlightedImage.resizableImage(withCapInsets: cap)

            userId = message.senderId ?? ""
    
        } else {
            
            avatarImageView.snp.remakeConstraints({ (make) in
                make.width.height.equalTo(kAvaterImageViewWidth)
                make.left.equalTo(kAvaterImageViewMargin)
                make.top.equalTo(kMessageCellTopMargin)
            })
            
            usernameLabel.snp.remakeConstraints({ (make) in
                make.top.equalTo(avatarImageView.snp.top);
                make.left.equalTo(avatarImageView.snp.right).offset(kMessageCellEdgeOffset)
                make.width.lessThanOrEqualTo(120)
                make.height.equalTo(0)
            })
            
            // 内容
            messageContentView.snp.remakeConstraints({ (make) in
                make.left.equalTo(avatarImageView.snp.right).offset(kAvatarToMessageContent)
                make.top.equalTo(usernameLabel.snp.bottom).offset(-ChatCellUI.bubbleTopMargin)
                make.size.equalTo(messageModel.messageFrame.contentSize)
            })

            activityView.snp.remakeConstraints({ (make) in
                make.left.equalTo(messageContentView.snp.right).offset(3)
                make.centerY.equalTo(messageContentView).offset(-4)
            })
            
            errorButton.snp.remakeConstraints({ (make) in
                make.left.equalTo(messageContentView.snp.right).offset(2)
                make.centerY.equalTo(messageContentView).offset(-4)
            })
            
            let image = #imageLiteral(resourceName: "receiver_background_normal")
            let highlightedImage = #imageLiteral(resourceName: "receiver_background_highlight")

            let cap = ChatCellUI.left_cap_insets
            backgroundImageView.image = image.resizableImage(withCapInsets: cap)
            backgroundImageView.highlightedImage = highlightedImage.resizableImage(withCapInsets: cap)

            userId = message.targetId
        }
        
        let avatarURL = "\(kHeaderImageBaseURLString)\(userId).jpg"
        avatarImageView.yy_setImage(with: URL(string: avatarURL), placeholder: defaultHeadeImage)
    }
    
    
    //MARK: 更新状态
    /// 上传消息进度（图片和视频）
    //更新消息状态
    func updateState() {
        
        if messageModel.isSend == false {
            activityView.stopAnimating()
            errorButton.isHidden = true
            return
        }
        
        // 发送中展示
        if messageModel.message.sendStatus == .successed {
            activityView.stopAnimating()
            errorButton.isHidden = true
        }
        // 如果失败就显示重发按钮
        else if messageModel.message.sendStatus == .failed {
            activityView.stopAnimating()
            errorButton.isHidden = false
        } else {
            activityView.startAnimating()
            errorButton.isHidden = true
        }
    }
    
    // 更新进度
    func updateProgress(_ progress: Int) {
        
    }
    
    
    // MARK: cell中的事件处理
    ///头像点击
    func avatarViewDidTapDown(_ tap: UITapGestureRecognizer) {
    
        guard let delegate = self.delegate, let messageModel = self.messageModel, tap.state == .ended  else {
            return
        }
        let message = messageModel.message
        let targetId = (message.direction == .receive) ? message.targetId : (message.senderId ?? "")
        delegate.messageCellUserAvatarDidClick(targetId)
    }
    
    // MARK: 手势事件
    func bubbleTapped(_ tapGestureRecognizer: UITapGestureRecognizer) {
 
        guard tapGestureRecognizer.state == .ended else {
            return
        }
        
        self.delegate?.messageCellDidTap(self)
    }
    
    func bubbleDoubleTapped(_ tapGestureRecognizer: UITapGestureRecognizer) {
 
        
    }
    
    func bubbleLongPressed(_ longPressGestureRecognizer: UILongPressGestureRecognizer) {
        if longPressGestureRecognizer.state == .began {
            
        }
    }
    
    func errorButtonClick(_ button: UIButton) {
        self.delegate?.messageCellResendButtonClick(self)
    }
    
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
    lazy var messageContentView: UIView = {
        let messageContentView = UIView()
        messageContentView.clipsToBounds = true
        
        messageContentView.addGestureRecognizer(self.longPressGestureRecognizer)
        messageContentView.addGestureRecognizer(self.doubletapGesture)
        
        messageContentView.addGestureRecognizer(self.tapGestureRecognizer)
        self.tapGestureRecognizer.require(toFail: self.doubletapGesture)
        
        return messageContentView
    }()
    
    lazy var backgroundImageView: UIImageView = {
        let backgroundImageView = UIImageView()
        backgroundImageView.isUserInteractionEnabled = true
        backgroundImageView.clipsToBounds = true
        return backgroundImageView
    }()
    
    
    /// 指示
    var activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    /// 发送失败
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
