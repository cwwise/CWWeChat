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


protocol CWMessageBody {
    /// 聊天消息
    weak var message: CWChatMessage? { get set }
    /// 消息类型
    var type: CWMessageType { get set}
}

