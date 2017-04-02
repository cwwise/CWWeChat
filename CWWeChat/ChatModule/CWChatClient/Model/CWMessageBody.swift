//
//  CWMessageBody.swift
//  CWWeChat
//
//  Created by chenwei on 2017/3/25.
//  Copyright © 2017年 chenwei. All rights reserved.
//

import UIKit

/// 附件下载状态
enum CWFileDownloadStatus: Int {
    case downloading
    case successed
    case fail
    case pending
}

// TODO: 先简单这么处理，想到好的方式再修改
protocol CWMessageCoding {
    /// 保存到数据库中的字段
    var messageEncode: String { get }
    
    /// 解析数据库中的数据
    ///
    /// - Parameter content: 数据库中的内容
    func messageDecode(string: String)
}

protocol CWMessageBody: CWMessageCoding {
    /// 聊天消息
    weak var message: CWChatMessage? { get set }
    /// 消息类型
    var type: CWMessageType { get set}
}
