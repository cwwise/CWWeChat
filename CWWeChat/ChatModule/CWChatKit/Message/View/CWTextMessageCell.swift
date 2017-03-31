//
//  CWTextMessageCell.swift
//  CWWeChat
//
//  Created by wei chen on 2017/3/31.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class CWTextMessageCell: CWChatMessageCell {

    // 展示文本
    fileprivate var messageLabel: UILabel = {
        let messageLabel = UILabel()
        messageLabel.font = UIFont.fontTextMessageText()
        messageLabel.numberOfLines = 0
        messageLabel.backgroundColor = UIColor.orange
        return messageLabel
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.messageLabel)
    }
    
    
    
    override func updateMessage(_ messageModel: CWChatMessageModel) {
        super.updateMessage(messageModel)
        
        let contentSize = messageModel.messageFrame.contentSize
        // 消息实体
        let message = messageModel.message
        
        let content = (message.messageBody as! CWTextMessageBody).text
        messageLabel.attributedText = NSAttributedString(string: content,
                                                         attributes: textAttributes)
        
        // 是自己的
        if message.direction == .send {
            let edge = ChatCellUI.right_edge_insets
            let cap = ChatCellUI.right_cap_insets
            
            let size = CGSize(width: contentSize.width + edge.left + edge.right,
                              height: contentSize.height + edge.top + edge.bottom)
            
            messageBackgroundView.size = size
            messageBackgroundView.right = self.avatarButton.x - kMessageBackgroundSpaceX
            messageBackgroundView.top = self.avatarButton.y
            
            
            
            messageLabel.size = contentSize
            messageLabel.origin = CGPoint(x: messageBackgroundView.x-edge.left,
                                          y: messageBackgroundView.top+edge.top)
            
        } else {
            
            let edge = ChatCellUI.left_edge_insets
            let cap = ChatCellUI.right_cap_insets

            let size = CGSize(width: contentSize.width + edge.left + edge.right,
                              height: contentSize.height + edge.top + edge.bottom)
            
            messageBackgroundView.size = size
            messageBackgroundView.left = self.avatarButton.right + kMessageBackgroundSpaceX
            messageBackgroundView.top = self.avatarButton.y
            
            let image = #imageLiteral(resourceName: "message_receiver_background_normal")
            messageBackgroundView.image = image.resizableImage(withCapInsets: cap)

            
            messageLabel.size = contentSize
            messageLabel.origin = CGPoint(x: messageBackgroundView.x+edge.left,
                                          y: messageBackgroundView.top+edge.top)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
