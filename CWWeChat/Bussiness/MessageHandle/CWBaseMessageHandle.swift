//
//  CWBaseMessageHandle.swift
//  CWXMPPChat
//
//  Created by chenwei on 16/5/30.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit
import MMXXMPPFramework

protocol CWMessageHandleProtocol:NSObjectProtocol {
    func handleResult(handle: CWBaseMessageHandle, message: CWMessageModel, isDelay: Bool)
}

///消息处理的基类
class CWBaseMessageHandle: NSObject {

    //代理
    weak var delegate: CWMessageHandleProtocol?
    
    override init() {
        super.init()
    }
    
    func handleMessage(message: XMPPMessage) {
        
    }
    
    
    func analyMessageContent(message: XMPPMessage) -> (String, CWMessageType) {
        let body = message.elementForName("body")
        let type = body.attributeForName("type")
        if type == nil {
            return (body.stringValue(), CWMessageType(rawValue: 1)!)
        }
        let typeValue = Int(type.stringValue())!
        return (body.stringValue(), CWMessageType(rawValue: typeValue)!)
    }
    
    //这是争对第二种方式获取消息的类型
    /**
     解析消息体，根据消息的前缀 正则匹配出，解析消息的类型
     
     - parameter body: 消息的内容
     
     - returns: 返回消息的类型和消息体
     */
    func analyMessageBody(body: String) -> (String, CWMessageType) {
        //解析message中的body
        do {
            let regex = try NSRegularExpression(pattern: "^\\):\\)1[0-3].{32}", options: [.CaseInsensitive,.DotMatchesLineSeparators])
            let result = regex.numberOfMatchesInString(body, options: .ReportProgress, range: NSRange(location: 0, length: body.characters.count))
            if result > 0 {
                let index = body.startIndex.advancedBy(4)
                let content = body.substringFromIndex(index.advancedBy(1))
                switch body[index] {
                case "0":
                    return (content, .Image)
                case "1":
                    return (content, .Voice)
                default:
                    return (content, .Text)
                }
            } else {
                return (body, .Text)
            }
            
        } catch let error as NSError {
            CWLogError(error.description)
            return (body, .Text)
        }
        
    }
    
}
