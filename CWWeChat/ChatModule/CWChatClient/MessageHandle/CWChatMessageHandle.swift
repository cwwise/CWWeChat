//
//  CWChatMessageHandle.swift
//  CWWeChat
//
//  Created by chenwei on 2017/3/30.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import XMPPFramework

class CWChatMessageHandle: CWMessageHandle {
    
    override func handleMessage(message: XMPPMessage) -> Bool {

        if message.isChatMessageWithBody() {
            // 内容 来源 目标人 消息id
            guard let body = message.body(),
                let from = message.from().user,
                let to = message.to().user,
                let messageId = message.elementID(),
            let bodyType = message.attribute(forName: "msgtype")?.stringValue,
            let bodyValue = Int(bodyType) else {
                return false
            }
            
            var messageDate = Date()
            if message.wasDelayed() {
                messageDate = message.delayedDeliveryDate()
            }
            
            let type = CWMessageType(rawValue: bodyValue) ?? CWMessageType.none
            var messageBody: CWMessageBody!
          
            switch type {
            case .text:
                messageBody = CWTextMessageBody(text: body)
            case .image:
                messageBody = CWImageMessageBody()
                messageBody.messageDecode(string: body)
            default: break
            }
            
            let chatMessage = CWChatMessage(targetId: from, messageID: messageId, direction: .receive, timestamp: messageDate.timeIntervalSince1970, messageBody: messageBody)
            chatMessage.senderId = to
            
            self.delegate?.handMessageComplete(message: chatMessage)
            
            return true
        }
        return false
    }
    
    
    //解析到消息后，应该先下载。还需要优化。
    func analyMessageContent(_ message: XMPPMessage) -> (String, CWMessageType) {
        let body = message.forName("body")!
        let type = body.attribute(forName: "type")
        
        if type == nil  {
            return (body.stringValue!, CWMessageType(rawValue: 1)!)
        }
        let typeValue = Int((type?.stringValue)!)!
        return (body.stringValue!, CWMessageType(rawValue: typeValue)!)
    }
    
    //这是争对第二种方式获取消息的类型
    /**
     解析消息体，根据消息的前缀 正则匹配出，解析消息的类型
     
     - parameter body: 消息的内容
     
     - returns: 返回消息的类型和消息体
     */
    func analyMessageBody(_ body: String) -> (String, CWMessageType) {
        //解析message中的body
        do {
            let regex = try NSRegularExpression(pattern: "^\\):\\)1[0-3].{32}", options: [.caseInsensitive,.dotMatchesLineSeparators])
            let result = regex.numberOfMatches(in: body, options: .reportProgress, range: NSRange(location: 0, length: body.characters.count))
            if result > 0 {
                
                let index = body.index(body.startIndex, offsetBy: 4)
                let content = body.substring(from: index)
                switch body[index] {
                case "0":
                    return (content, .image)
                case "1":
                    return (content, .voice)
                default:
                    return (content, .text)
                }
            } else {
                return (body, .text)
            }
            
        } catch {
            log.error(error)
            return (body, .text)
        }
        
    }
    
}
