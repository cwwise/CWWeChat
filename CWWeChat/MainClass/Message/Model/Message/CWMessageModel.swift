//
//  CWMessageModel.swift
//  CWXMPPChat
//
//  Created by chenwei on 16/5/30.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWMessageModel: NSObject {

    ///消息ID
    var messageID: String
    
    var messageSendId : String?    //发送人 ID
    var messageTargetId : String? //接受人 ID
    
    ///消息类型
    var messageType: CWMessageType
    ///聊天类型
    var chatType: CWChatType
    ///消息所属者
    var messageOwnerType: CWMessageOwnerType
    ///消息发送时间
    var messageSendDate: Date
//    var messageReceivedDate: NSDate

    ///消息状态
    var messageSendState: CWMessageSendState
//    var messageReadState: CWMessageReadState   //消息读取状态

    var messageUploadState: CWMessageUploadState
    
    var showTime: Bool = false
    /// 消息内容
    var messageContent: CWMessageContent?
    
    var messageFrame: CWMessageFrame!
    
    var content: String?
    
    /// 在会话界面显示
    var conversationContent:String? {
        switch messageType {
        case .text:
            return self.content
        case .image:
            return "[图片]"
        case .voice:
            return "[声音]"
        default:
            return self.content
        }
    }
    
    override init() {
        messageID = String.UUIDString()
        messageType = .none
        messageOwnerType = .none
        chatType = .personal
        messageSendDate = Date()
        messageSendState = .none
        messageUploadState = .none
        super.init()
    }
    
    convenience init(targetId: String, messageID: String = String.UUIDString(), ownerType: CWMessageOwnerType = .myself, content: CWMessageContent) {
        self.init()
        self.messageTargetId = targetId
        self.messageOwnerType = ownerType
        self.messageContent = content
        self.messageID = messageID
        
        if content.isKind(of: CWTextMessageContent.self) {
            self.messageType = .text
            let contentString = (content as! CWTextMessageContent).content
            let size = CGSize(width: kChatTextMaxWidth, height: CGFloat.greatestFiniteMagnitude)
            let attributes = [NSForegroundColorAttributeName:UIColor.white,
                              NSFontAttributeName: UIFont.systemFont(ofSize: 16)]
            var contentSize = contentString.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil).size
            
            contentSize = CGSize(width: ceil(contentSize.width), height: ceil(contentSize.height)+1)
            let heightOfCell = contentSize.height + 40
            
            self.messageFrame = CWMessageFrame(heightOfCell: heightOfCell, contentSize: contentSize)
        }
        
        else if content.isKind(of: CWImageMessageContent.self) {
            self.messageType = .image

            var contentSize: CGSize = CGSize.zero
            let imageMessage = content as! CWImageMessageContent
            
            if let imagePath = imageMessage.imagePath  {
                let local_imagePath = CWUserAccount.sharedUserAccount().pathUserChatImage(imagePath)
                let isExist = FileManager.default.fileExists(atPath: local_imagePath)
                
                if isExist {
                    let imageSize = imageMessage.imageSize
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
                } else {
                    contentSize = CGSize(width: 60, height: 60)
                }
            } else {
                let imageSize = imageMessage.imageSize
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
            }
            
            let heightOfCell = ceil(contentSize.height)+1 + 10
            self.messageFrame = CWMessageFrame(heightOfCell: heightOfCell, contentSize: contentSize)
            
        }
        
        else if content.isKind(of: CWVoiceMessageContent.self) {

            self.messageType = .voice
            let voiceMessage = content as! CWVoiceMessageContent
            
            var contentSize: CGSize = CGSize.zero
            let heightOfCell: CGFloat = 60
            
            if let voiceLength = voiceMessage.voiceLength {
                let scale: CGFloat = CGFloat(voiceLength)/60.0
                contentSize = CGSize(width: ceil(scale*kChatVoiceMaxWidth)+30, height: kAvaterWidth+12)
            }

            self.messageFrame = CWMessageFrame(heightOfCell: heightOfCell, contentSize: contentSize)
            
        }
    }

    
    
}
