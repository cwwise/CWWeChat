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
    private var messageLabel: UILabel = {
        let messageLabel = UILabel()
        messageLabel.font = UIFont.systemFontOfSize(16)
        messageLabel.numberOfLines = 0
        return messageLabel
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.messageLabel)
    }
    
    ///赋值
    override func updateMessage(message: CWMessageModel) {
        super.updateMessage(message)
        
        messageLabel.text = message.content
        
        if message.messageOwnerType == .Myself {
            
            let sendImage = CWAsset.Message_sender_bg.image.resizableImage()
            let sendImageHL = CWAsset.Message_sender_bgHL.image.resizableImage()
            
            self.messageBackgroundView.image = sendImage
            self.messageBackgroundView.highlightedImage = sendImageHL
            
            self.messageLabel.snp_remakeConstraints(closure: { (make) in
                make.right.equalTo(self.messageBackgroundView).offset(-MSG_SPACE_RIGHT);
                make.top.equalTo(self.messageBackgroundView).offset(MSG_SPACE_TOP);
            })
            
            self.messageBackgroundView.snp_updateConstraints(closure: { (make) in
                make.left.equalTo(self.messageLabel).offset(-MSG_SPACE_LEFT);
                make.bottom.equalTo(self.messageLabel).offset(MSG_SPACE_BTM);
            })
            
        } else if message.messageOwnerType == .Other {
            
            let sendImage = CWAsset.Message_receiver_bg.image.resizableImage()
            let sendImageHL = CWAsset.Message_receiver_bgHL.image.resizableImage()
            
            self.messageBackgroundView.image = sendImage
            self.messageBackgroundView.highlightedImage = sendImageHL
            
            self.messageLabel.snp_remakeConstraints(closure: { (make) in
                make.left.equalTo(self.messageBackgroundView).offset(MSG_SPACE_LEFT);
                make.top.equalTo(self.messageBackgroundView).offset(MSG_SPACE_TOP);
            })
            
            self.messageBackgroundView.snp_updateConstraints(closure: { (make) in
                make.right.equalTo(self.messageLabel).offset(MSG_SPACE_RIGHT);
                make.bottom.equalTo(self.messageLabel).offset(MSG_SPACE_BTM);
            })
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
