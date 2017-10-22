//
//  ChatClientUtil.swift
//  ChatClient
//
//  Created by chenwei on 2017/10/2.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import Foundation
import XMPPFramework

let messageEncoder = JSONEncoder()
let messageDecoder = JSONDecoder()

class ChatClientUtil: NSObject {
    
    static var messageId: String {
        let uuid = UUID().uuidString
        return uuid
    }
    
    static var currentTime: TimeInterval {
        let date = Date()
        return date.timeIntervalSince1970
    }
    
    static func messageBody(with messageType: MessageType) -> MessageBody {
        
        switch messageType {
        case .text:
            return TextMessageBody()
        case .image:
            return ImageMessageBody()
        default:
            fatalError("错误")
        }
        
        
    }
    
}

public extension XMPPModule {
    // 执行代理方法
    public func executeDelegateSelector(_ action: ((AnyObject?, DispatchQueue?) -> Void)) {
        // 处理事件
        // 检查delegate 是否存在，存在就执行方法
        guard let multicastDelegate = self.value(forKey: "multicastDelegate") as? GCDMulticastDelegate else {
            return
        }
        ///遍历出所有的delegate
        let delegateEnumerator = multicastDelegate.delegateEnumerator()
        var delegate: AnyObject?
        var queue: DispatchQueue?
        
        while delegateEnumerator.getNextDelegate(&delegate, delegateQueue: &queue) == true {
            //执行Delegate的方法
            action(delegate, queue)
        }
    }
}


