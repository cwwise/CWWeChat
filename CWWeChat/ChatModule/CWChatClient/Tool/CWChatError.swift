//
//  CWChatError.swift
//  CWWeChat
//
//  Created by wei chen on 2017/4/3.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

public enum CWChatErrorCode: Int, CustomStringConvertible {
    /// 认证失败
    case authenticationFailed
    case userAlreadyLogin
    
    case serverNotReachable
    case serverTimeout
    case serverUnknownError
    
    case customer

    public var description: String {
        var string = ""
        switch self {
        case .authenticationFailed:
            string = "认证失败"
        case .userAlreadyLogin:
            string = "用户已经登陆"
        case .serverNotReachable:
            string = "未连接服务器"
        case .serverTimeout:
            string = "连接服务器操时"
        case .serverUnknownError:
            string = "连接服务器未知错误"
        default:
            string = ""
        }
        return string
    }
    
}

/// 定义的错误
public class CWChatError: NSObject {
    /// 错误码
    var errorCode: CWChatErrorCode
    /// 错误描述
    var errorDescription: String
    
    public init(errorCode: CWChatErrorCode = .customer, error: String? = nil) {
        self.errorCode = errorCode
        if let error = error {
            errorDescription = error
        } else {
            errorDescription = errorCode.description
        }
    }
}
