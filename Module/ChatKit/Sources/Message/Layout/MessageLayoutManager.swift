//
//  MessageLayoutManager.swift
//  ChatKit
//
//  Created by wei chen on 2017/10/23.
//

import UIKit
import ChatClient

class MessageLayoutManager {
    
    static let share = MessageLayoutManager()
    
    var setting = MessageLayoutSettings.share

    private var itemWidth: CGFloat {
        return kScreenWidth
    }
    
    private init() {
        
    }
    
    func configurate(message: MessageModel) {
        
        setupAvatarFrame(with: message.messageFrame, message: message)
        setupUsernameFrame(with: message.messageFrame, message: message)
        setupContainerFrame(with: message.messageFrame, message: message)
        setupStateFrame(with: message.messageFrame, message: message)
        
        // 计算高度
        let itemHeight = message.messageFrame.messageContainerFrame.height + setting.messageToBottomPadding + setting.messageToTopPadding
        
        message.messageFrame.sizeOfItem = CGSize(width: itemWidth, height: itemHeight)
    }
}

extension MessageLayoutManager {
    
    // 头像
    func setupAvatarFrame(with attributes: MessageFrame, message: MessageModel) {
        let size: CGSize = setting.avaterSize
        let origin: CGPoint
        if message.isSend {
            origin = CGPoint(x: itemWidth - setting.contentToLeftPadding - size.width,
                             y: setting.messageToTopPadding)
        } else {
            origin = CGPoint(x: setting.contentToLeftPadding, y: setting.messageToTopPadding)
        }
        attributes.avaterFrame = CGRect(origin: origin, size: size)
    }
    
    // 昵称(如果有昵称，则昵称和头像y一样)
    func setupUsernameFrame(with attributes: MessageFrame, message: MessageModel) {
        
        var size: CGSize = setting.usernameSize
        let origin: CGPoint
        if message.showUsername == false {
            size = CGSize.zero
        }
        
        if message.isSend {
            origin = CGPoint(x: attributes.avaterFrame.minX - setting.usernameLeftPadding - size.width,
                             y: attributes.avaterFrame.minY)
        } else {
            origin = CGPoint(x: attributes.avaterFrame.maxX + setting.usernameLeftPadding,
                             y: attributes.avaterFrame.minY)
        }
        attributes.usernameFrame = CGRect(origin: origin, size: size)
    }
    
    func setupContainerFrame(with attributes: MessageFrame, message: MessageModel) {
        
        // 如果是文字
        var contentSize: CGSize = CGSize.zero
        
        switch message.messageType {
        case .text:
            
            let content = (message.messageBody as! TextMessageBody).text
            let size = CGSize(width: kChatTextMaxWidth, height: CGFloat.greatestFiniteMagnitude)
            var edge: UIEdgeInsets
            if message.isSend {
                edge = ChatCellUI.right_edge_insets
            } else {
                edge = ChatCellUI.left_edge_insets
            }
            
            let textFont = setting.contentTextFont
            let textAttributes = [NSAttributedStringKey.font: textFont,
                                  NSAttributedStringKey.foregroundColor: UIColor.black]
            
            let textAttributedString = NSAttributedString(string: content, attributes: textAttributes)
            let options: NSStringDrawingOptions = [.usesLineFragmentOrigin, .usesFontLeading]
            let frame = textAttributedString.boundingRect(with: size, options: options, context: nil)
            
            contentSize = CGSize(width: ceil(frame.size.width)+edge.left+edge.right,
                                 height: ceil(frame.size.height)+edge.top+edge.bottom)
            
        case .image:
            let imageSize = (message.messageBody as! ImageMessageBody).size
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
            
        case .voice:
            
            let voiceMessage = message.messageBody as! VoiceMessageBody
            var scale: CGFloat = CGFloat(voiceMessage.voiceLength)/60.0
            if scale > 1 {
                scale = 1
            }
            contentSize = CGSize(width: ceil(scale*kChatVoiceMaxWidth)+70,
                                 height: setting.avaterSize.height+13)
            
        case .emoticon:
            contentSize = CGSize(width: 120, height: 120)
            
        case .location:
            contentSize = CGSize(width: 250, height: 150)
            
        default:
            break
        }
        
        let origin: CGPoint
        if message.isSend {
            origin = CGPoint(x: attributes.avaterFrame.minX - setting.usernameLeftPadding - contentSize.width,
                             y: attributes.usernameFrame.minY)
        } else {
            origin = CGPoint(x: attributes.avaterFrame.maxX + setting.usernameLeftPadding,
                             y: attributes.usernameFrame.minY)
        }
        attributes.messageContainerFrame = CGRect(origin: origin, size: contentSize)
    }
    
    func setupStateFrame(with attributes: MessageFrame, message: MessageModel) {
        let containerFrame = attributes.messageContainerFrame
        let origin: CGPoint
        if message.isSend {
            origin = CGPoint(x: containerFrame.minX - 2 - setting.errorSize.width,
                             y: containerFrame.midY - 10)
        } else {
            origin = CGPoint(x: containerFrame.minX + 2 + setting.errorSize.width,
                             y: containerFrame.midY - 10)
        }
        attributes.errorFrame = CGRect(origin: origin, size: setting.errorSize)
        attributes.activityFrame = CGRect(origin: origin, size: setting.errorSize)
    }
    
}
