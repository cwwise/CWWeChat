//
//  CWBaseMessageCell.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/26.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

protocol ChatMessageCellDelegate:NSObjectProtocol {
    //头像点击
    func messageCellUserAvatarDidClick(user:CWContactUser)
    
    //消息体选中
    func messagecellDidSelect(cell: CWBaseMessageCell)
    
    //MARK: UIMenuController消息
    func messageDelete(cell: CWBaseMessageCell)
    
    func messageCopy(cell: CWBaseMessageCell)
}

// TODO: 修改命名

///头像
let kAvaterWidth:  CGFloat      = 38.0
let kAvaterSpaceX: CGFloat      = 8.0
let kAvaterSpaceY: CGFloat      = 12.0

let kChatAvatarMarginLeft: CGFloat = 10             //头像的 margin left
let kChatAvatarMarginTop: CGFloat = 0               //头像的 margin top
let kChatAvatarWidth: CGFloat = 40                  //头像的宽度

let kNameLabelHeight: CGFloat =   14.0
let kNameLabelSpaceX: CGFloat =   12.0
let kNamelabelSpaceY: CGFloat =   1.0

let kMessagebgSpaceX: CGFloat  =  5.0
let kMessagebgSpaceY: CGFloat  =  1.0


/// 聊天界面baseCell
class CWBaseMessageCell: UITableViewCell {
    
    ///
    var message:CWMessageModel?
    
    ///用户名称
    var usernameLabel:UILabel = {
        let usernameLabel = UILabel()
        usernameLabel.backgroundColor = UIColor.clearColor()
        usernameLabel.font = UIFont.systemFontOfSize(12)
        return usernameLabel
    }()
    
    ///头像
    lazy var avatarButton:UIButton = {
        let avatarButton = UIButton(type: .Custom)
        avatarButton.frame.size = CGSize(width: kAvaterWidth, height: kAvaterWidth)
        avatarButton.addTarget(self,
                               action: #selector(avatarButtonClickDown(_:)),
                               forControlEvents: UIControlEvents.TouchUpInside)
        return avatarButton
    }()
    
    ///手势操作
    private(set) lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(bubbleTapped(_:)))
        return tapGestureRecognizer
    }()
    
    private (set) lazy var longPressGestureRecognizer: UILongPressGestureRecognizer = {
        let longpressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(bubbleLongPressed(_:)))
        longpressGestureRecognizer.delegate = self
        return longpressGestureRecognizer
    }()
    
    ///消息的背景图片
    lazy var messageBackgroundView:UIImageView = {
        let messageBackgroundView = UIImageView()
        messageBackgroundView.userInteractionEnabled = true
        
        return messageBackgroundView
    }()
    
    //引导
    var activityView = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
    lazy var errorButton:UIButton = {
        let errorButton = UIButton(type: .Custom)
        errorButton.setImage(UIImage(named:"message_sendfaild"), forState: .Normal)
        errorButton.sizeToFit()
        errorButton.hidden = true
        return errorButton
    }()
    
    // MARK: 初始化
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clearColor()
        self.selectionStyle = .None
        
        self.contentView.addSubview(self.usernameLabel)
        self.contentView.addSubview(self.avatarButton)
        self.contentView.addSubview(self.messageBackgroundView)
        self.contentView.addSubview(self.activityView)
        self.contentView.addSubview(self.errorButton)
        
        p_addSnap()
    }
    
    func p_addSnap() {
        
        //头像
        self.avatarButton.snp_makeConstraints { (make) in
            make.right.equalTo(self.contentView).offset(-kAvaterSpaceX)
            make.top.equalTo(self.contentView).offset(kAvaterSpaceY)
            make.width.height.equalTo(kAvaterWidth);
        }
        
        self.usernameLabel.snp_makeConstraints { (make) in
            make.top.equalTo(self.avatarButton).offset(-kNamelabelSpaceY)
            make.right.equalTo(self.avatarButton.snp_left).offset(-kNameLabelSpaceX)
        }
    
        self.messageBackgroundView.snp_makeConstraints { (make) in
            make.right.equalTo(self.avatarButton.snp_left).offset(-kMessagebgSpaceX);
            make.top.equalTo(self.usernameLabel.snp_bottom).offset(-kMessagebgSpaceY);
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///赋值
    func updateMessage(message: CWMessageModel) {
        
        if self.message?.messageOwnerType != message.messageOwnerType {
            
        }
        
        
        if message.messageOwnerType == .Myself {

            let string = CWUserAccount.sharedUserAccount().chatuser.avatarURL!
            
            self.avatarButton.af_setImageForState(.Normal, URL: NSURL(string:string)!)
            self.avatarButton.left = Screen_Width - kChatAvatarMarginLeft - kAvaterWidth
            
            self.avatarButton.snp_remakeConstraints(closure: { (make) in
                make.width.height.equalTo(kAvaterWidth);
                make.top.equalTo(self.contentView).offset(kAvaterSpaceY)
                make.right.equalTo(self.contentView).offset(-kAvaterSpaceX)
            })
            
        } else {
            
            let userModel = CWContactManager.findContact(message.messageTargetId!)
            let string = userModel!.avatarURL!
            
            self.avatarButton.af_setImageForState(.Normal, URL: NSURL(string:string)!)
            
            self.avatarButton.snp_remakeConstraints(closure: { (make) in
                make.width.height.equalTo(kAvaterWidth);
                make.top.equalTo(self.contentView).offset(kAvaterSpaceY)
                make.left.equalTo(self.contentView).offset(kAvaterSpaceX)
            })
            
        }
        
        self.usernameLabel.snp_updateConstraints { (make) in
            make.height.equalTo(0)
        }
        
        if  self.message?.messageOwnerType != message.messageOwnerType {
          
            self.messageBackgroundView.snp_remakeConstraints(closure: { (make) in
                
                if message.messageOwnerType == .Myself {
                    make.right.equalTo(self.avatarButton.snp_left).offset(-kMessagebgSpaceX)
                } else {
                    make.left.equalTo(self.avatarButton.snp_right).offset(kMessagebgSpaceX)
                }
                make.top.equalTo(self.usernameLabel.snp_bottom).offset(-kMessagebgSpaceY);
                
            })
            
        }
        
        
        self.message = message
    }
    
    // MARK: cell中的事件处理
    ///头像点击
    func avatarButtonClickDown(button:UIButton) {
        
    }
    
    ///手势事件
    func bubbleTapped(tapGestureRecognizer: UITapGestureRecognizer) {

    }
    
    func bubbleLongPressed(longPressGestureRecognizer: UILongPressGestureRecognizer) {
        if longPressGestureRecognizer.state == .Began {

        }
    }
    
    //MARK: 更新状态
    //上传消息进度（图片和视频）
    func updateProgressView(progress:CGFloat, result: CWMessageUploadState) {
        
    }
    
    //更新消息状态
    func updateMessageCellState() {
        if self.message?.messageSendState == .Sending {
            activityView.startAnimating()
            errorButton.hidden = true
        }
            //如果失败就显示重发按钮
        else if self.message?.messageSendState == .Fail {
            activityView.stopAnimating()
            errorButton.hidden = false
        } else {
            activityView.stopAnimating()
            errorButton.hidden = true
        }
    }
    
}
