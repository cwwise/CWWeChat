//
//  CWImageMessageCell.swift
//  CWWeChat
//
//  Created by chenwei on 16/7/3.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

/**
 ImageCell
 */
class CWImageMessageCell: CWBaseMessageCell {

    /// 自定义ImageView
    lazy var messageImageView:CWChatImageView = {
        let messageImageView = CWChatImageView(frame:CGRect.zero)
        messageImageView.isUserInteractionEnabled = true
        messageImageView.addGestureRecognizer(self.tapGestureRecognizer)
        return messageImageView
    }()
    
    ///手势操作
    fileprivate(set) lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(bubbleTapped(_:)))
        return tapGestureRecognizer
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(messageImageView)
    }
    
    ///重写setMessage方法
    override func updateMessage(_ message: CWMessageModel) {
        super.updateMessage(message)
        
        //如果是自己发送，在右边
        if message.messageOwnerType == .myself {
            let sendImage = CWAsset.Message_sender_bg.image.resizableImage()
            messageImageView.backgroundImage = sendImage
            
            messageImageView.snp_remakeConstraints(closure: { (make) in
                make.top.equalTo(self.messageBackgroundView)
                make.right.equalTo(self.messageBackgroundView)
            })
            
        } else {
            
            let receiveImage = CWAsset.Message_receiver_bg.image.resizableImage()
            messageImageView.backgroundImage = receiveImage
            
            messageImageView.snp_remakeConstraints(closure: { (make) in
                make.top.equalTo(self.messageBackgroundView)
                make.left.equalTo(self.messageBackgroundView)
            })
        }
        
        //设置size
        self.messageImageView.snp_updateConstraints { (make) in
            make.size.equalTo(message.messageFrame.contentSize)
        }
        
        //根据图片的类型，加载不同的路径，存在问题(如何让本地和远端统一)
        let imageMessageContent = message.messageContent as! CWImageMessageContent
        if let imagePath = imageMessageContent.imagePath {
            let imagePath = CWUserAccount.sharedUserAccount().pathUserChatImage(imagePath)
            messageImageView.setThumbnailPath(imagePath)
        }
        else if let imageUrl = imageMessageContent.imageUrl {
            messageImageView.setThumbnailURL(imageUrl)
        }
        
        
        updateProgressView(0, result: message.messageUploadState)
//        updateMessageCellState()
    }
    
    /// 更新cell状态
    override func updateProgressView(_ progress:CGFloat, result: CWMessageUploadState) {
        messageImageView.updateProgressView(progress, result: result)
    }
    
    override func updateMessageCellState() {
        super.updateMessageCellState()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
