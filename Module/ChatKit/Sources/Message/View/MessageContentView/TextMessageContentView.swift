//
//  TextMessageContentView.swift
//  ChatKit
//
//  Created by chenwei on 2017/10/4.
//

import UIKit
import ChatClient

class TextMessageContentView: MessageContentView {

    private lazy var messageLabel: MessageLabel = {
        let messageLabel = MessageLabel()
        messageLabel.numberOfLines = 0
        return messageLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(messageLabel)
    }
    
    override func refresh(message: MessageModel) {
        super.refresh(message: message)
        
        let textBody = message.messageBody as! TextMessageBody
        let textFont = MessageLayoutSettings.share.contentTextFont
        let textAttributes = [NSAttributedStringKey.font: textFont,
                              NSAttributedStringKey.foregroundColor: UIColor.black]
        
        let textAttributedString = NSAttributedString(string: textBody.text, attributes: textAttributes)
        messageLabel.attributedText = textAttributedString
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let message = message else {
            messageLabel.frame = self.bounds
            return
        }
        
        let edge: UIEdgeInsets
        if message.isSend == true {
            edge = ChatCellUI.right_edge_insets
        } else {
            edge = ChatCellUI.left_edge_insets
        }
        
        let x = self.bounds.minX + edge.left
        let y = self.bounds.minY + edge.top
        let width = self.bounds.width - edge.left - edge.right
        let height = self.bounds.height - edge.top - edge.bottom
        
        let frame = CGRect(x: x, y: y, width: width, height: height)
        messageLabel.frame = frame
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
