//
//  CWTextMessageCell.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/26.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

let  MSG_SPACE_TOP:CGFloat       =   14
let  MSG_SPACE_BTM:CGFloat       =   20
let  MSG_SPACE_LEFT:CGFloat      =   19
let  MSG_SPACE_RIGHT:CGFloat     =   22

class CWTextMessageCell: CWBaseMessageCell {

    //TODO: 将字体大小用类来管理
    fileprivate var messageLabel: UILabel = {
        let messageLabel = UILabel()
        messageLabel.font = UIFont.fontTextMessageText()
        messageLabel.numberOfLines = 0
//        messageLabel.backgroundColor = UIColor.cyanColor()
        return messageLabel
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.messageLabel)
    }
    
    ///赋值
    override func updateMessage(_ message: CWMessageModel) {
        super.updateMessage(message)
        
        let textMessage = message.messageContent as! CWTextMessageContent
        messageLabel.attributedText = CWChatTextParser.parseText(textMessage.content, font: UIFont.fontTextMessageText())
        
        if message.messageOwnerType == .myself {
            
            let sendImage = CWAsset.Message_sender_bg.image.resizableImage()
            let sendImageHL = CWAsset.Message_sender_bgHL.image.resizableImage()
            
            self.messageBackgroundView.image = sendImage
            self.messageBackgroundView.highlightedImage = sendImageHL
            
            self.messageLabel.snp.remakeConstraints({ (make) in
                make.right.equalTo(self.messageBackgroundView).offset(-MSG_SPACE_RIGHT);
                make.top.equalTo(self.messageBackgroundView).offset(MSG_SPACE_TOP);
            })
            
            self.messageBackgroundView.snp.updateConstraints({ (make) in
                make.left.equalTo(self.messageLabel).offset(-MSG_SPACE_LEFT);
                make.bottom.equalTo(self.messageLabel).offset(MSG_SPACE_BTM);
            })
            
        } else if message.messageOwnerType == .other {
            
            let sendImage = CWAsset.Message_receiver_bg.image.resizableImage()
            let sendImageHL = CWAsset.Message_receiver_bgHL.image.resizableImage()
            
            self.messageBackgroundView.image = sendImage
            self.messageBackgroundView.highlightedImage = sendImageHL
            
            self.messageLabel.snp.remakeConstraints({ (make) in
                make.left.equalTo(self.messageBackgroundView).offset(MSG_SPACE_LEFT);
                make.top.equalTo(self.messageBackgroundView).offset(MSG_SPACE_TOP);
            })
            
            self.messageBackgroundView.snp.updateConstraints({ (make) in
                make.right.equalTo(self.messageLabel).offset(MSG_SPACE_RIGHT);
                make.bottom.equalTo(self.messageLabel).offset(MSG_SPACE_BTM);
            })
            
        }
        
        self.messageLabel.snp.updateConstraints { (make) in
            make.size.equalTo(message.messageFrame.contentSize)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
