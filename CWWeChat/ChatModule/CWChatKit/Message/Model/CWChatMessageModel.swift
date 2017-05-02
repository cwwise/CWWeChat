//
//  CWChatMessageModel.swift
//  CWWeChat
//
//  Created by chenwei on 2017/3/25.
//  Copyright © 2017年 chenwei. All rights reserved.
//

import UIKit
import YYText.YYTextUtilities

enum CWMediaPlayStutus {
    case none
    case playing
    case played
}


public let kChatTextAttribute = [NSForegroundColorAttributeName:UIColor.black,
                                  NSFontAttributeName: UIFont.fontTextMessageText()]
/// 消息model
public class CWChatMessageModel: NSObject {

    /// 聊天消息
    var message: CWChatMessage
    
    /// 是否显示时间
    var showTime: Bool = false
    /// 音频播放状态 默认未播放
    var mediaPlayStutus: CWMediaPlayStutus = .none
    /// 上传进度
    var uploadProgress: Float = 0.0
    
    /// 是否是发送方
    var isSend: Bool
    /// 消息
    var messageFrame = CWChatMessageFrame()
    
    /// 文本消息
    var content: String?
    
    public init(message: CWChatMessage) {
        self.message = message
        self.isSend = message.direction == .send
        super.init()
        
        switch message.messageType {
        case .text:
            setupTextMessage()
        case .image:
            setupImageMessage()
        case .voice:
            setupVoiceMessage()
        case .expression:
            setupExpressionMessage()
        case .location:
            setupLocationMessage()
        default:
            break

        }
        
        
    }
    
    func setupTextMessage() {
        
        let content = (message.messageBody as! CWTextMessageBody).text
        let size = CGSize(width: kChatTextMaxWidth, height: CGFloat.greatestFiniteMagnitude)
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
        contentSize = CGSize(width: contentSize.width+edge.left+edge.right,
                             height: contentSize.height+edge.top+edge.bottom)
        let heightOfCell = contentSize.height + kMessageCellBottomMargin + kMessageCellTopMargin
        
        messageFrame = CWChatMessageFrame(heightOfCell: heightOfCell,
                                          contentSize: contentSize,
                                          textLayout: textLayout)
    }
    
    
    func setupImageMessage() {
        
        var contentSize: CGSize
        let imageSize = (message.messageBody as! CWImageMessageBody).size
        //根据图片的比例大小计算图片的frame
        if imageSize.width > imageSize.height {
            var height = kChatImageMaxWidth * imageSize.height / imageSize.width
            height = max(kChatImageMinWidth, height)
            contentSize = CGSize(width: ceil(kChatImageMaxWidth), height: ceil(height))
        } else {
            var width = kChatImageMaxWidth * imageSize.width / imageSize.height
            width = max(kChatImageMinWidth, width)
            contentSize = CGSize(width: ceil(width), height: ceil(kChatImageMaxWidth))
        }
        
        let edge = UIEdgeInsets.zero
        contentSize = CGSize(width: contentSize.width+edge.left+edge.right,
                             height: contentSize.height+edge.top+edge.bottom)
        
        let heightOfCell = contentSize.height + kMessageCellBottomMargin + kMessageCellTopMargin
        messageFrame = CWChatMessageFrame(heightOfCell: heightOfCell, contentSize: contentSize)
    }
    
    
    func setupVoiceMessage() {

        let voiceMessage = message.messageBody as! CWVoiceMessageBody
        var scale: CGFloat = CGFloat(voiceMessage.voiceLength)/60.0
        if scale > 1 {
            scale = 1
        }
        let contentSize = CGSize(width: ceil(scale*kChatVoiceMaxWidth)+70, height: kAvaterImageViewWidth+13)
        let heightOfCell: CGFloat = contentSize.height + kMessageCellBottomMargin + kMessageCellTopMargin
        messageFrame = CWChatMessageFrame(heightOfCell: heightOfCell, contentSize: contentSize)
    }
    
    func setupLocationMessage() {
        
        
    }
    
    func setupExpressionMessage() {
        
        
    }
    
}
