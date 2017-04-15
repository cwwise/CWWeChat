//
//  CWChatMessageModel.swift
//  CWWeChat
//
//  Created by chenwei on 2017/3/25.
//  Copyright © 2017年 chenwei. All rights reserved.
//

import UIKit
import YYText.YYTextUtilities

public let kChatTextAttribute = [NSForegroundColorAttributeName:UIColor.black,
                                  NSFontAttributeName: UIFont.fontTextMessageText()]
/// 消息model
public class CWChatMessageModel: NSObject {

    /// 聊天消息
    var message: CWChatMessage
    
    /// 是否显示时间
    var showTime: Bool = false
    /// 消息
    var messageFrame = CWChatMessageFrame()
    /// 文本消息
    var content: String?
    
    public init(message: CWChatMessage) {
        self.message = message;
        super.init()
        
        switch message.messageType {
        case .text:
            setupTextMessage()
        case .image:
            setupImageMessage()
        case .voice:
            setupVoiceMessage()
        default:
            break

        }
        
        
    }
    
    func setupTextMessage() {
        
        let content = (message.messageBody as! CWTextMessageBody).text
        let size = CGSize(width: 200, height: CGFloat.greatestFiniteMagnitude)
        var edge: UIEdgeInsets
        if message.direction == .send {
            edge = ChatCellUI.right_edge_insets
        } else {
            edge = ChatCellUI.left_edge_insets
        }
        
        let modifier = CWTextLinePositionModifier(font: UIFont.fontTextMessageText())
        // YYTextContainer
        let textContainer = YYTextContainer(size: size)
        textContainer.linePositionModifier = modifier
        textContainer.maximumNumberOfRows = 0
        
        let textAttri = CWChatTextParser.parseText(content)!
        let textLayout = YYTextLayout(container: textContainer, text: textAttri)!
        
        var contentSize = textLayout.textBoundingSize
        contentSize = CGSize(width: ceil(contentSize.width)+edge.left+edge.right,
                             height: ceil(contentSize.height)+edge.top+edge.bottom)
        let heightOfCell = contentSize.height + kMessageCellBottomMargin + kMessageCellTopMargin
        
        messageFrame = CWChatMessageFrame(heightOfCell: heightOfCell,
                                          contentSize: contentSize,
                                          textLayout: textLayout)
    }
    
    
    func setupImageMessage() {
        
        var contentSize: CGSize = CGSize.zero
        let imageSize = (message.messageBody as! CWImageMessageBody).size
        //根据图片的比例大小计算图片的frame
        if imageSize.width > imageSize.height {
            var height = kChatImageMaxWidth * imageSize.height / imageSize.width
            height = [kChatImageMinWidth,height].max()!
            contentSize = CGSize(width: ceil(kChatImageMaxWidth), height: ceil(height))
        } else {
            var width = kChatImageMaxWidth * imageSize.width / imageSize.height
            width = [kChatImageMinWidth,width].max()!
            contentSize = CGSize(width: ceil(width), height: ceil(kChatImageMaxWidth))
        }
        
        let edge = UIEdgeInsets.zero
        contentSize = CGSize(width: ceil(contentSize.width)+edge.left+edge.right,
                             height: ceil(contentSize.height)+edge.top+edge.bottom)
        
        let heightOfCell = contentSize.height + kMessageCellBottomMargin + kMessageCellTopMargin
        messageFrame = CWChatMessageFrame(heightOfCell: heightOfCell, contentSize: contentSize)
    }
    
    
    func setupVoiceMessage() {

        let voiceMessage = message.messageBody as! CWVoiceMessageBody
        
        var contentSize: CGSize = CGSize.zero
        let heightOfCell: CGFloat = 60
        
//        if let voiceLength = voiceMessage.voiceLength {
//            let scale: CGFloat = CGFloat(voiceLength)/60.0
//            contentSize = CGSize(width: ceil(scale*kChatVoiceMaxWidth)+30, height: kAvaterWidth+12)
//        }
        contentSize = CGSize(width: 100, height: kAvaterImageViewWidth+14)
        messageFrame = CWChatMessageFrame(heightOfCell: heightOfCell, contentSize: contentSize)
        
    }
    
}
