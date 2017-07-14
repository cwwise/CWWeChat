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

class CWBaseMessageCell: UICollectionViewCell {
    
    weak var delegate: CWBaseMessageCellDelegate?
    
    var messageModel: CWChatMessageModel!

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
        
        _ = layoutAttributes.headerFrame
        
    }
    
    func updateViews() {
        
        
        
    }
    
    // 设置view frame
    func updateViewLayouts() {
        
    }
    
    
    
    
}
