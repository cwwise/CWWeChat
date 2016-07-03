//
//  CWBaseMessageCell.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/26.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

// TODO: 修改命名

///头像
let AVATAR_WIDTH:CGFloat        = 38.0
let AVATAR_SPACE_X:CGFloat      = 8.0
let AVATAR_SPACE_Y:CGFloat      = 12.0

let kChatAvatarMarginLeft: CGFloat = 10             //头像的 margin left
let kChatAvatarMarginTop: CGFloat = 0               //头像的 margin top
let kChatAvatarWidth: CGFloat = 40                  //头像的宽度

let NAMELABEL_HEIGHT: CGFloat  =   14.0
let NAMELABEL_SPACE_X: CGFloat =   12.0
let NAMELABEL_SPACE_Y: CGFloat =   1.0

let MESSAGEBG_SPACE_X: CGFloat  =     5.0
let MESSAGEBG_SPACE_Y: CGFloat    =  1.0


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
        avatarButton.frame.size = CGSize(width: AVATAR_WIDTH, height: AVATAR_WIDTH)
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
            make.right.equalTo(self.contentView).offset(-AVATAR_SPACE_X)
            make.top.equalTo(self.contentView).offset(AVATAR_SPACE_Y)
            make.width.height.equalTo(AVATAR_WIDTH);
        }
        
        self.usernameLabel.snp_makeConstraints { (make) in
            make.top.equalTo(self.avatarButton).offset(-NAMELABEL_SPACE_Y)
            make.right.equalTo(self.avatarButton.snp_left).offset(-NAMELABEL_SPACE_X)
        }
    
        self.messageBackgroundView.snp_makeConstraints { (make) in
            make.right.equalTo(self.avatarButton.snp_left).offset(-MESSAGEBG_SPACE_X);
            make.top.equalTo(self.usernameLabel.snp_bottom).offset(-MESSAGEBG_SPACE_Y);
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
            self.avatarButton.left = Screen_Width - kChatAvatarMarginLeft - AVATAR_WIDTH
            
            self.avatarButton.snp_remakeConstraints(closure: { (make) in
                make.width.height.equalTo(AVATAR_WIDTH);
                make.top.equalTo(self.contentView).offset(AVATAR_SPACE_Y)
                make.right.equalTo(self.contentView).offset(-AVATAR_SPACE_X)
            })
            
        } else {
            
            let userModel = CWContactManager.findContact(message.messageReceiveId!)
            let string = userModel!.avatarURL!
            
            self.avatarButton.af_setImageForState(.Normal, URL: NSURL(string:string)!)
            
            self.avatarButton.snp_remakeConstraints(closure: { (make) in
                make.width.height.equalTo(AVATAR_WIDTH);
                make.top.equalTo(self.contentView).offset(AVATAR_SPACE_Y)
                make.left.equalTo(self.contentView).offset(AVATAR_SPACE_X)
            })
            
        }
        
        self.usernameLabel.snp_updateConstraints { (make) in
            make.height.equalTo(0)
        }
        
        if  self.message?.messageOwnerType != message.messageOwnerType {
          
            self.messageBackgroundView.snp_remakeConstraints(closure: { (make) in
                
                if message.messageOwnerType == .Myself {
                    make.right.equalTo(self.avatarButton.snp_left).offset(-MESSAGEBG_SPACE_X)
                } else {
                    make.left.equalTo(self.avatarButton.snp_right).offset(MESSAGEBG_SPACE_X)
                }
                make.top.equalTo(self.usernameLabel.snp_bottom).offset(-MESSAGEBG_SPACE_Y);
                
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
