//
//  CWMessageBody.swift
//  CWWeChat
//
//  Created by chenwei on 2017/3/25.
//  Copyright © 2017年 chenwei. All rights reserved.
//

import UIKit

/// 附件下载状态
public enum CWFileDownloadStatus: Int {
    case downloading
    case successed
    case fail
    case pending
}

/// 附件上传状态
public enum CWFileUploadStatus: Int {
    case uploading
    case successed
    case fail
    case pending
}

// TODO: 先简单这么处理，想到好的方式再修改 （方便查看保存成string）
public protocol CWMessageCoding {
    /// 保存到数据库中的字段
    var messageEncode: String { get }
    
    /// 解析数据库中的数据
    ///
    /// - Parameter content: 数据库中的内容
    func messageDecode(string: String)
}

public protocol CWMessageBody: CWMessageCoding {
    /// 聊天消息
    weak var message: CWMessage? { get set }
    /// 消息类型
    var type: CWMessageType { get set}
}
