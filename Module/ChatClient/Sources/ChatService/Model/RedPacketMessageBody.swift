//
//  RedPacketMessageBody.swift
//  ChatClient
//
//  Created by chenwei on 2018/3/21.
//

import Foundation

public class RedPacketMessageBody {
    
    var title: String = ""
    
    public init(title: String) {
        self.title = title
    }
    
    init() {
        
    }
    
}

extension RedPacketMessageBody: MessageBody {
    
    public var type: MessageType {
        return .redpacket
    }
    
    public func messageEncode() -> String {
        return ""
    }
    
    public func messageDecode(string: String) {
        
    }
    
    public var description: String {
        return "红包"
    }
    
}
