//
//  CWChatMessageModel.swift
//  CWWeChat
//
//  Created by chenwei on 2017/3/25.
//  Copyright © 2017年 chenwei. All rights reserved.
//

import UIKit

public let textAttributes = [NSForegroundColorAttributeName:UIColor.white,
                      NSFontAttributeName: UIFont.fontTextMessageText()]
/// 消息model
class CWChatMessageModel: NSObject {

    /// 聊天消息
    var message: CWChatMessage
    
    /// 是否显示时间
    var showTime: Bool = false
    /// 消息
    var messageFrame = CWChatMessageFrame()
    /// 文本消息
    var text: NSAttributedString = {
        return NSAttributedString()
    }()
    
    init(message: CWChatMessage) {
        self.message = message;
        
        switch message.messageType {
        case .text:
            
            let content = (message.messageBody as! CWTextMessageBody).text
            let size = CGSize(width: 100, height: CGFloat.greatestFiniteMagnitude)

   
            var contentSize = content.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: textAttributes, context: nil).size
            
            contentSize = CGSize(width: ceil(contentSize.width),
                                 height: ceil(contentSize.height)+1)

            let heightOfCell = contentSize.height + 40

            messageFrame = CWChatMessageFrame(heightOfCell: heightOfCell,
                                              contentSize: contentSize)

            break
        default: break

        }
        
        
    }
    
    
}
