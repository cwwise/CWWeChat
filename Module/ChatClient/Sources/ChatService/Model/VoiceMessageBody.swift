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
    
    // 内部使用
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
    
    var info: [String: String] {
        var info = ["voiceLength": "\(voiceLength)"]
        if let urlString = self.voiceURL?.absoluteString {
            info["voiceURL"] = urlString
        }
        
        if let path = self.voicePath {
            info["path"] = path
        }
        return info
    }
    
    public func messageEncode() -> String {
        do {
            let data = try JSONSerialization.data(withJSONObject: self.info, options: .prettyPrinted)
            return String(data: data, encoding: .utf8) ?? ""
        } catch {
            return ""
        }
    }
    
    public func messageDecode(string: String) {
        guard let data = string.data(using: .utf8) else { return }
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: String]
            if let voiceLength = json?["voiceLength"] {
                self.voiceLength = Float(voiceLength) ?? 0
            }
            if let path = json?["path"] {
                self.voicePath = path
            }
            if let urlstring = json?["voiceURL"],
                let url = URL(string: urlstring) {
                self.voiceURL = url
            }
        } catch {
            
        }
    }
    
    public var description: String {
        return "语音"
    }
}
