//
//  CWChatMessageCell.swift
//  CWWeChat
//
//  Created by chenwei on 2017/3/26.
//  Copyright © 2017年 chenwei. All rights reserved.
//

import UIKit

protocol CWMessageCellDelegate:NSObjectProtocol {

    
}

// cell布局中的间距
let kMessageCellMargin: CGFloat =  10.0
// 上下留白
let kMessageCellTopMargin: CGFloat =  2.0
let kMessageCellBottomMargin: CGFloat =  12.0

///头像
let kAvaterImageViewWidth:  CGFloat      = 40.0
let kAvaterImageViewMargin:  CGFloat      = 10.0

/// 名称
let kNameLabelHeight: CGFloat =   14.0
let kNameLabelSpaceX: CGFloat =   12.0
let kNamelabelSpaceY: CGFloat =   1.0


let kAvatarToMessageContent: CGFloat = 5.0
let kMessageCellEdgeOffset: CGFloat = 6.0






class CWChatMessageCell: UITableViewCell {

    weak var delegate: CWMessageCellDelegate?

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
    
    /// 设置数据
    func configureCell(message messageModel: CWChatMessageModel) {
        
        // 设置数据
        
        
        // 更新UI
        
        
    }
    
    /// 
    func updateMessage(_ messageModel: CWChatMessageModel) {
        self.messageModel = messageModel
        // 消息实体
        let message = messageModel.message
        
        // 是自己的
        if message.direction == .send {
            
            // 头像
            avatarImageView.snp.remakeConstraints({ (make) in
                make.width.height.equalTo(kAvaterImageViewWidth)
                make.left.equalTo(-kAvaterImageViewMargin)
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
                make.top.equalTo(usernameLabel.snp.bottom)
                
                make.size.equalTo(messageModel.messageFrame.contentSize)
            })
            
            let image = #imageLiteral(resourceName: "bubble-default-sended")
            let cap = ChatCellUI.right_cap_insets
            messageContentView.image = image.resizableImage(withCapInsets: cap)
            
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
                make.top.equalTo(usernameLabel.snp.bottom).offset(0)
                make.size.equalTo(messageModel.messageFrame.contentSize)
            })

            
            

            let image = #imageLiteral(resourceName: "bubble-default-received")
            let cap = ChatCellUI.left_cap_insets
            messageContentView.image = image.resizableImage(withCapInsets: cap)
            
        }
        
        avatarImageView.yy_setImage(with: nil, placeholder: defaultHeadeImage)
        
        

    }
    
    
    //MARK: 更新状态
    /// 上传消息进度（图片和视频）
    
    //更新消息状态
    func updateMessageCellState() {
        
        // 发送中展示
        if messageModel.message.sendStatus == .sending {
            activityView.startAnimating()
            errorButton.isHidden = true
        }
        // 如果失败就显示重发按钮
        else if messageModel.message.sendStatus == .failed {
            activityView.stopAnimating()
            errorButton.isHidden = false
        } else {
            activityView.stopAnimating()
            errorButton.isHidden = true
        }
    }
    
    
    
    // MARK: cell中的事件处理
    ///头像点击
    func avatarButtonClickDown(_ button:UIButton) {
        
        guard let _ = self.delegate, let message = self.messageModel  else {
            return
        }
        
        
    }
    
    // MARK: 属性
    ///用户名称
    var usernameLabel:UILabel = {
        let usernameLabel = UILabel()
        usernameLabel.backgroundColor = UIColor.clear
        usernameLabel.font = UIFont.systemFont(ofSize: 12)
        usernameLabel.text = "nickname"
        return usernameLabel
    }()
    
    ///头像
    lazy var avatarImageView:UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.contentMode = .scaleAspectFit
        avatarImageView.clipsToBounds = true
        avatarImageView.backgroundColor = UIColor.cyan
        return avatarImageView
    }()
    
    ///消息的背景图片
    lazy var messageContentView:UIImageView = {
        let messageContentView = UIImageView()
        messageContentView.isUserInteractionEnabled = true
        return messageContentView
    }()
    
    //引导
    var activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    lazy var errorButton:UIButton = {
        let errorButton = UIButton(type: .custom)
        errorButton.setImage(UIImage(named:"message_sendfaild"), for: UIControlState())
        errorButton.sizeToFit()
        errorButton.isHidden = true
        return errorButton
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
