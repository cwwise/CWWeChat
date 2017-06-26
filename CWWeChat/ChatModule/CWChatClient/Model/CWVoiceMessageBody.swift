//
//  CWVoiceMessageBody.swift
//  CWWeChat
//
//  Created by wei chen on 2017/4/15.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class CWVoiceMessageBody: NSObject, CWMessageBody {

    weak var message: CWMessage?
    /// 消息体类型
    var type: CWMessageType = .voice
    
    /// 录音长度
    var voiceLength: Float
    /// 网络路径
    var voiceURL: URL?
    /// 本地路径
    var voicePath: String?
    
    init(voicePath: String? = nil,
         voiceURL: URL? = nil,
         voiceLength: Float) {
        self.voicePath = voicePath
        self.voiceURL = voiceURL
        self.voiceLength = voiceLength
        super.init()
    }
}

extension CWVoiceMessageBody {
    var messageEncode: String {
        return ""
    }
    
    func messageDecode(string: String) {

    }
}
