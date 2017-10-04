//
//  VoiceMessageBody.swift
//  ChatClient
//
//  Created by chenwei on 2017/10/4.
//

import UIKit

public class VoiceMessageBody {    
    /// 录音长度
    public var voiceLength: Float = 0
    /// 网络路径
    public var voiceURL: URL?
    /// 本地路径
    public var voicePath: String?
    
    init() {
        
    }
    
    public init(voicePath: String? = nil,
                voiceURL: URL? = nil,
                voiceLength: Float) {
        self.voicePath = voicePath
        self.voiceURL = voiceURL
        self.voiceLength = voiceLength
    }
}

extension VoiceMessageBody: MessageBody {
    
    public var type: MessageType { 
        return .voice
    }
    
    public func messageEncode() -> String {
        return "text"
    }
    
    public func messageDecode(string: String) {
        
    }
    
    public var description: String {
        return ""
    }
}
