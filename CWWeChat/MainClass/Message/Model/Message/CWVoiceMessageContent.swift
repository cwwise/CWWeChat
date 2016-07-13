//
//  CWVoiceMessageContent.swift
//  CWWeChat
//
//  Created by chenwei on 16/7/12.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWVoiceMessageContent: CWMessageContent {

    /// 录音长度
    var voiceLength: Float?
    /// 网络路径
    var voiceURL: String?
    /// 本地路径
    var voicePath: String?
    
    init(voicePath: String) {
        self.voicePath = voicePath
        super.init()
    }
    
    init(voiceURL: String) {
        self.voiceURL = voiceURL
        super.init()
    }
    
}
