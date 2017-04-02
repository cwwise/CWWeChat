//
//  CWBaseMessageHandle.swift
//  CWXMPPChat
//
//  Created by chenwei on 16/5/30.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit
import XMPPFramework

protocol CWMessageHandleProtocol:NSObjectProtocol {
    func handleResult(_ handle: CWBaseMessageHandle, message: CWMessageModel, isDelay: Bool)
}

///消息处理的基类,待改善
class CWBaseMessageHandle: NSObject {

    //代理
    weak var delegate: CWMessageHandleProtocol?
    
    override init() {
        super.init()
    }
    
    func handleMessage(_ message: XMPPMessage) {
        
    }
    
    //解析到消息后，应该先下载。还需要优化。
    func analyMessageContent(_ message: XMPPMessage) -> (String, CWChatMessageType) {
        let body = message.forName("body")!
        let type = body.attribute(forName: "type")
        
        if type == nil  {
            return (body.stringValue!, CWChatMessageType(rawValue: 1)!)
        }
        let typeValue = Int((type?.stringValue)!)!
        return (body.stringValue!, CWChatMessageType(rawValue: typeValue)!)
    }
    
    //这是争对第二种方式获取消息的类型
    /**
     解析消息体，根据消息的前缀 正则匹配出，解析消息的类型
     
     - parameter body: 消息的内容
     
     - returns: 返回消息的类型和消息体
     */
    func analyMessageBody(_ body: String) -> (String, CWChatMessageType) {
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
            
        } catch let error as NSError {
            CWLogError((error.description as AnyObject) as! String)
            return (body, .text)
        }
        
    }
    
}
