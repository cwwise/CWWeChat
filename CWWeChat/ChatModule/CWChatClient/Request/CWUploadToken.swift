//
//  CWUploadToken.swift
//  CWWeChat
//
//  Created by wei chen on 2017/4/3.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import Foundation
import Moya

enum CWChatQiniuUpload {

    case qiniutoken

}

extension CWChatQiniuUpload: TargetType {

    var baseURL: URL { return URL(string: "https://api.myservice.com")! }

    var path: String {
        switch self {
        case .qiniutoken:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .qiniutoken:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .qiniutoken:
            return nil
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    var sampleData: Data {
        switch self {
        case .qiniutoken:
            return "Half measures are as bad as nothing at all.".utf8Encoded
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .qiniutoken:
            return .request
        }
    }
    
}

// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return self.data(using: .utf8)!
    }
}
