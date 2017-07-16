//
//  CWBaseMessageCell.swift
//  CWWeChat
//
//  Created by wei chen on 2017/7/14.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

protocol CWBaseMessageCellDelegate: NSObjectProtocol {
    
    /// 点击cell文字中的URL
    ///
    /// - Parameters:
    ///   - cell: cell
    ///   - link: link
    func messageCellDidTapLink(_ cell: CWBaseMessageCell, link: URL)
    
    /// 点击cell文字中的电话
    ///
    /// - Parameters:
    ///   - cell: cell
    ///   - phone: phone
    func messageCellDidTapPhone(_ cell: CWBaseMessageCell, phone: String)
    
    /// cell被点击
    ///
    /// - Parameter cell: cell
    func messageCellDidTap(_ cell: CWBaseMessageCell)
    
    func messageCellResendButtonClick(_ cell: CWBaseMessageCell)
    
    
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

class CWBaseMessageCell: UICollectionViewCell {
    
    weak var delegate: CWBaseMessageCellDelegate?
    
    fileprivate var layoutAttributes: CWMessageLayoutAttributes?
    
    var message: CWMessageModel? {
        return self.layoutAttributes?.message
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(avatarImageView)
        self.contentView.addSubview(usernameLabel)

        
    }
    
    // MARK: cell中的事件处理
    ///头像点击
    func avatarViewDidTapDown(_ tap: UITapGestureRecognizer) {
        
        guard let delegate = self.delegate, let message = message, tap.state == .ended  else {
            return
        }
        
        let targetId = message.isSend ? message.targetId : message.senderId
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
    lazy var messageContentView: CWMessageContentView = {
        let messageContentView = CWMessageContentView()
        
        messageContentView.addGestureRecognizer(self.longPressGestureRecognizer)
        messageContentView.addGestureRecognizer(self.doubletapGesture)
        
        messageContentView.addGestureRecognizer(self.tapGestureRecognizer)
        self.tapGestureRecognizer.require(toFail: self.doubletapGesture)
        self.tapGestureRecognizer.require(toFail: self.longPressGestureRecognizer)
        
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - UIGestureRecognizerDelegate
extension CWBaseMessageCell: UIGestureRecognizerDelegate {


}

// MARK: - 布局
extension CWBaseMessageCell {
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        
        guard let layoutAttributes = layoutAttributes as? CWMessageLayoutAttributes else {
            return
        }
        self.layoutAttributes = layoutAttributes
        
        
        avatarImageView.frame = layoutAttributes.avatarFrame
        usernameLabel.frame = layoutAttributes.usernameFrame
        
        
        // 赋值
        let userId = self.message!.targetId
        let avatarURL = "\(kImageBaseURLString)\(userId).jpg"
        avatarImageView.kf.setImage(with: URL(string: avatarURL), placeholder: defaultHeadeImage)
    }
    
    
}
