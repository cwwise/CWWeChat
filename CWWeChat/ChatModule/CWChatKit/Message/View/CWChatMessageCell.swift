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

///头像
let kAvaterWidth:  CGFloat      = 38.0

/// 名称
let kNameLabelHeight: CGFloat =   14.0
let kNameLabelSpaceX: CGFloat =   12.0
let kNamelabelSpaceY: CGFloat =   1.0
/// 背景
let kMessageBackgroundSpaceY: CGFloat  =  1.0
let kMessageBackgroundSpaceX: CGFloat  =  5.0


// cell布局中的间距
let kMessageCellMargin: CGFloat =  10.0
// 上下留白
let kMessageCellTopMargin: CGFloat =  2.0
let kMessageCellBottomMargin: CGFloat =  12.0



class CWChatMessageCell: UITableViewCell {

    weak var delegate: CWMessageCellDelegate?

    var messageModel: CWChatMessageModel!
    
    ///用户名称
    var usernameLabel:UILabel = {
        let usernameLabel = UILabel()
        usernameLabel.backgroundColor = UIColor.clear
        usernameLabel.font = UIFont.systemFont(ofSize: 12)
        return usernameLabel
    }()
    
    ///头像
    lazy var avatarButton:UIButton = {
        let avatarButton = UIButton(type: .custom)
        avatarButton.size = CGSize(width: kAvaterWidth, height: kAvaterWidth)
        avatarButton.addTarget(self,
                               action: #selector(avatarButtonClickDown(_:)),
                               for: UIControlEvents.touchUpInside)
        return avatarButton
    }()
    
    ///消息的背景图片
    lazy var messageBackgroundView:UIImageView = {
        let messageBackgroundView = UIImageView()
        messageBackgroundView.isUserInteractionEnabled = true
        
        return messageBackgroundView
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
    
    
    // MARK: 初始化
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clear
        self.selectionStyle = .none
        
        self.contentView.addSubview(self.usernameLabel)
        self.contentView.addSubview(self.avatarButton)
        self.contentView.addSubview(self.messageBackgroundView)
        self.contentView.addSubview(self.activityView)
        self.contentView.addSubview(self.errorButton)
        
        p_addSnap()
    }

    func p_addSnap() {
        
        let origin = CGPoint(x: kScreenWidth - kMessageCellMargin - kAvaterWidth,
                             y: kMessageCellTopMargin)
        self.avatarButton.origin = origin
        
//        self.usernameLabel.snp.makeConstraints { (make) in
//            make.top.equalTo(self.avatarButton).offset(-kNamelabelSpaceY)
//            make.right.equalTo(self.avatarButton.snp.left).offset(-kNameLabelSpaceX)
//        }
        
        self.messageBackgroundView.snp.makeConstraints { (make) in
            make.right.equalTo(self.avatarButton.snp.left).offset(-kMessageBackgroundSpaceX);
            make.top.equalTo(self.usernameLabel.snp.bottom).offset(-kMessageBackgroundSpaceY);
        }
        
        
        
    }
    
    /// 
    func updateMessage(_ messageModel: CWChatMessageModel) {
        self.messageModel = messageModel

        // 消息实体
        let message = messageModel.message
        
        let contentSize = messageModel.messageFrame.contentSize
        
        // 是自己的
        if message.direction == .send {
            
            var origin = CGPoint(x: kScreenWidth - kMessageCellMargin - kAvaterWidth,
                                 y: kMessageCellTopMargin)
            self.avatarButton.origin = origin

            let edge = ChatCellUI.right_cap_insets
            let size = CGSize(width: contentSize.width + edge.left + edge.right,
                              height: contentSize.height + edge.top + edge.bottom)
            let backgroundOrigin = CGPoint(x: origin.x, y: kMessageBackgroundSpaceY)

            
            
        } else {
            
            let origin = CGPoint(x: kMessageCellMargin,
                                 y: kMessageCellTopMargin)
            self.avatarButton.origin = origin
            
            
            
        }
        
        
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
        
        guard let delegate = self.delegate, let message = self.messageModel  else {
            return
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
