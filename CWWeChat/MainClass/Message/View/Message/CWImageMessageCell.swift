//
//  CWImageMessageCell.swift
//  CWWeChat
//
//  Created by chenwei on 16/7/3.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWImageMessageCell: CWBaseMessageCell {

    lazy var messageImageView:CWChatImageView = {
        let messageImageView = CWChatImageView(frame:CGRectZero)
        messageImageView.userInteractionEnabled = false
        return messageImageView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(messageImageView)
    }
    
    ///重写setMessage方法
    override func updateMessage(message: CWMessageModel) {
        super.updateMessage(message)
        
        let imageMessage = message as! CWImageMessageModel
        //如果是自己发送，在右边
        if message.messageOwnerType == .Myself {
            let sendImage = CWAsset.Message_sender_bg.image.resizableImage()
            messageImageView.backgroundImage = sendImage
        } else {
            let receiveImage = CWAsset.Message_receiver_bg.image.resizableImage()
            messageImageView.backgroundImage = receiveImage
        }
//        let imagePath = NSFileManager.pathUserChatImage(imageMessage.imagePath!)
//        messageImageView.setThumbnailPath(imagePath)
        updateProgressView(0, result: message.messageUploadState)
        
        updateMessageCellState()
    }
    
    override func updateProgressView(progress:CGFloat, result: CWMessageUploadState) {
        messageImageView.updateProgressView(progress, result: result)
    }
    
    override func updateMessageCellState() {
        super.updateMessageCellState()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
