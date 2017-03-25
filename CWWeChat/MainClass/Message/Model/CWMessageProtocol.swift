//
//  CWMessageProtocol.swift
//  CWWeChat
//
//  Created by chenwei on 16/4/4.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

///MARK: 会话记录
///会话提示类型
public enum CWConversationClueType: Int {
    case none
    case point
    case pointWithNumber
}

//MARK: 消息
///消息聊天类型
public enum CWChatType: Int {
    case none
    case personal
    case group
}

///消息所属类型
public enum CWMessageOwnerType : Int {
    case none  //未知
    case system   //系统消息
    case myself   //自己发送的
    case other    //接受到朋友发送的
    
    //获取cell的reuseIdentifier
    func reuseIdentifier(_ messageType: CWMessageType) -> String {
        let typeIdentifier = messageType.reuseIdentifier()
        switch self {
        case .myself:
            return typeIdentifier+"_send"
        case .other:
            return typeIdentifier+"_receive"
        default:
            return typeIdentifier+"_none"
        }
    }
    
}

///消息类型
public enum CWMessageType : Int {
    case none  = -1          //未知
    case time  = 0         //时间
    
    case text               //文字
    case image              //图片
    case voice              //声音
    case video              //视频
    case expression         //表情
    
    //获取cell的reuseIdentifier
    func reuseIdentifier() -> String {
        switch self {
        case .text:
            return "ChatMessageTextCell"
        case .image:
            return "ChatMessageImageCell"
        case .voice:
            return "ChatMessageVoiceCell"
        case .video:
            return "ChatMessageVideoCell"
        case .expression:
            return "ChatMessageExpressionCell"
            
        case .time:
            return "ChatMessageTimeCell"
        default:
            return "ChatMessageCell"
        }
    }
}

///消息发送的状态
public enum CWMessageSendState : Int {
    case none               //默认消息状态
    case sending            //消息发送中
    case fail              //消息发送失败
    case success           //消息发送成功
    
    init(state: Bool) {
        if state {
            self = .success
        } else {
            self = .fail
        }
    }
}


///消息播放状态(声音和视频)
public enum CWMessagePlayState : Int {
    case none    = 0             //无播放（自己发送的默认是无播放）
    case unPlay  = -1              //未播放 (接收的语言消息默认是未播放)
    case playing = 1              //播放中
    case played  = 2             //已经播放过
    
    init (state: Bool) {
        if state {
            self = .played
        } else {
            self = .unPlay
        }
    }
    
}

/**
 消息上传状态(争对资源文件)
 
 - None:    没有状态默认
 - Loading: 上传当中
 - Success: 上传成功
 - Fail:    上传失败
 */
public enum CWMessageUploadState: Int {
    case none = -1
    case loading
    case success
    case fail
}


let  Max_Showtime_Message_Count:Int     =     10
let  Max_Showtime_Message_Second:Double =     60

