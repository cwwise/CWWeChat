//
//  MessageViewLayout.swift
//  ChatKit
//
//  Created by wei chen on 2017/10/6.
//

import UIKit
import ChatClient

class MessageViewLayout: NSObject {

    public static var share = MessageViewLayout()

    var setting: MessageLayoutSettings
    
    static func layoutMessage(_ message: Message) -> MessageFrame {
        var messageFrame = MessageFrame()
        
        
        return messageFrame
    }
    
    func setupTextMessage() {
        
    }
    
    
    func setupImageMessage() {
        
    }
    
    func setupVoiceMessage() {
        
        
        
    }
    
    override init() {
        setting = MessageLayoutSettings()
        super.init()
    }
    
}
