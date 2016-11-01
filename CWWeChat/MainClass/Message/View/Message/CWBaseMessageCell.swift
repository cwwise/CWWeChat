//
//  CWBaseMessageCell.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/26.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

/**
 *  cell的点击代理方法
 */
protocol ChatMessageCellDelegate:NSObjectProtocol {
    
    /**
     头像点击的代理方法
     
     - parameter userId: 用户唯一id
     */
    func messageCellUserAvatarDidClick(_ userId: String)
    
    /**
     消息cell点击事件
     
     - parameter cell: 点击的cell
     */
    func messageCellDidSelect(_ cell: CWBaseMessageCell)
    
    /**
     消息cell 双击的点击事件(争对文本)
     
     - parameter cell: 点击的cell
     */
    func messageCellDoubleClick(_ cell: CWBaseMessageCell)

    //MARK: UIMenuController消息
//    func messageDelete(cell: CWBaseMessageCell)
    
//    func messageCopy(cell: CWBaseMessageCell)
}

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
    
    weak var delegate: ChatMessageCellDelegate?
    
    ///
    var message:CWMessageModel?
    
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
        avatarButton.frame.size = CGSize(width: kAvaterWidth, height: kAvaterWidth)
        avatarButton.addTarget(self,
                               action: #selector(avatarButtonClickDown(_:)),
                               for: UIControlEvents.touchUpInside)
        return avatarButton
    }()
    
    fileprivate(set) lazy var doubletapGesture: UITapGestureRecognizer = {
        let doubletapGesture = UITapGestureRecognizer(target: self, action: #selector(bubbleDoubleTapped(_:)))
        doubletapGesture.numberOfTapsRequired = 2
        return doubletapGesture
    }()
    
    fileprivate (set) lazy var longPressGestureRecognizer: UILongPressGestureRecognizer = {
        let longpressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(bubbleLongPressed(_:)))
        longpressGestureRecognizer.delegate = self
        return longpressGestureRecognizer
    }()
    
    ///消息的背景图片
    lazy var messageBackgroundView:UIImageView = {
        let messageBackgroundView = UIImageView()
        messageBackgroundView.isUserInteractionEnabled = true
        
        messageBackgroundView.addGestureRecognizer(self.longPressGestureRecognizer)
        messageBackgroundView.addGestureRecognizer(self.doubletapGesture)
        
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
        
        //头像
        self.avatarButton.snp.makeConstraints { (make) in
            make.right.equalTo(self.contentView).offset(-kAvaterSpaceX)
            make.top.equalTo(self.contentView).offset(kAvaterSpaceY)
            make.width.height.equalTo(kAvaterWidth);
        }
        
        self.usernameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.avatarButton).offset(-kNamelabelSpaceY)
            make.right.equalTo(self.avatarButton.snp.left).offset(-kNameLabelSpaceX)
        }
    
        self.messageBackgroundView.snp.makeConstraints { (make) in
            make.right.equalTo(self.avatarButton.snp.left).offset(-kMessagebgSpaceX);
            make.top.equalTo(self.usernameLabel.snp.bottom).offset(-kMessagebgSpaceY);
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///赋值
    func updateMessage(_ message: CWMessageModel) {
        
        if self.message?.messageOwnerType != message.messageOwnerType {
            
        }
        
        if message.messageOwnerType == .myself {

            let string = CWUserAccount.sharedUserAccount().chatuser.avatarURL!
            
            self.avatarButton.yy_setBackgroundImage(with: URL(string:string), for: .normal, placeholder: defaultHeadeImage)
            self.avatarButton.left = Screen_Width - kChatAvatarMarginLeft - kAvaterWidth
            
            self.avatarButton.snp.remakeConstraints({ (make) in
                make.width.height.equalTo(kAvaterWidth);
                make.top.equalTo(self.contentView).offset(kAvaterSpaceY)
                make.right.equalTo(self.contentView).offset(-kAvaterSpaceX)
            })
            
        } else {
            
            let userModel = CWContactManager.findContact(message.messageTargetId!)
            let string = userModel!.avatarURL!
            
            self.avatarButton.yy_setBackgroundImage(with: URL(string:string), for: .normal, placeholder: defaultHeadeImage)
            
            self.avatarButton.snp.remakeConstraints({ (make) in
                make.width.height.equalTo(kAvaterWidth);
                make.top.equalTo(self.contentView).offset(kAvaterSpaceY)
                make.left.equalTo(self.contentView).offset(kAvaterSpaceX)
            })
            
        }
        
        self.usernameLabel.snp.updateConstraints { (make) in
            make.height.equalTo(0)
        }
        
        if self.message?.messageOwnerType != message.messageOwnerType {
            
            self.messageBackgroundView.snp.remakeConstraints({ (make) in
                
                if message.messageOwnerType == .myself {
                    make.right.equalTo(self.avatarButton.snp.left).offset(-kMessagebgSpaceX)
                } else {
                    make.left.equalTo(self.avatarButton.snp.right).offset(kMessagebgSpaceX)
                }
                make.top.equalTo(self.usernameLabel.snp.bottom).offset(-kMessagebgSpaceY);
                
            })
        }
        
        self.message = message
    }
    
    // MARK: cell中的事件处理
    ///头像点击
    func avatarButtonClickDown(_ button:UIButton) {
        
        guard let delegate = self.delegate,let message = self.message  else {
            return
        }
        
        if message.messageOwnerType == .myself {
            delegate.messageCellUserAvatarDidClick(message.messageSendId!)
        } else {
            delegate.messageCellUserAvatarDidClick(message.messageTargetId!)
        }
        
    }
    
    // MARK: 手势事件
    func bubbleTapped(_ tapGestureRecognizer: UITapGestureRecognizer) {
        guard let delegate = self.delegate else {
            return
        }
        delegate.messageCellDidSelect(self)

    }
    
    func bubbleDoubleTapped(_ tapGestureRecognizer: UITapGestureRecognizer) {
        guard let delegate = self.delegate else {
            return
        }
        delegate.messageCellDoubleClick(self)
    }
    
    
    
    func bubbleLongPressed(_ longPressGestureRecognizer: UILongPressGestureRecognizer) {
        if longPressGestureRecognizer.state == .began {

        }
    }
    
    //MARK: 更新状态
    //上传消息进度（图片和视频）
    func updateProgressView(_ progress:CGFloat, result: CWMessageUploadState) {
        
    }
    
    //更新消息状态
    func updateMessageCellState() {
        if self.message?.messageSendState == .sending {
            activityView.startAnimating()
            errorButton.isHidden = true
        }
            //如果失败就显示重发按钮
        else if self.message?.messageSendState == .fail {
            activityView.stopAnimating()
            errorButton.isHidden = false
        } else {
            activityView.stopAnimating()
            errorButton.isHidden = true
        }
    }
    
}
