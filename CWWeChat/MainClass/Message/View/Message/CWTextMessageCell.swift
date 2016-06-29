//
//  CWTextMessageCell.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/26.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

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
    override func updateMessage(message: CWMessageModel?) {
        super.updateMessage(message)
        
        messageLabel.text = message!.content
        
        if message?.messageOwnerType == .Myself {
            
            let sendImage = CWAsset.Message_receiver_bg.image.resizableImage()
            let sendImageHL = CWAsset.Message_receiver_bgHL.image.resizableImage()
            
            self.messageBackgroundView.image = sendImage
            self.messageBackgroundView.highlightedImage = sendImageHL
            
            self.messageLabel.snp_remakeConstraints(closure: { (make) in
                
            })
            
            self.messageBackgroundView.snp_updateConstraints(closure: { (make) in
//                make.right.equalTo(<#T##other: CGFloat##CGFloat#>)
            })
            
        } else if message?.messageOwnerType == .Other {
            
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
