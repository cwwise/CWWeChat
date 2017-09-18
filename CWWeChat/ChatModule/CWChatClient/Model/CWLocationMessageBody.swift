//
//  CWLocationMessageBody.swift
//  CWWeChat
//
//  Created by chenwei on 2017/4/20.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class CWLocationMessageBody: NSObject, CWMessageBody {
    weak var message: CWMessage?
    /// 消息体类型
    var type: CWMessageType = .location
    /// 纬度
    var latitude: Double
    /// 经度
    var longitude: Double
    /// 位置信息
    var address: String
    /// 位置信息的图片
    var locationImageURL: URL?
    
    init(latitude: Double, longitude: Double, address: String) {
        self.latitude = latitude
        self.longitude = latitude
        self.address = address
    }
}

extension CWLocationMessageBody {
    
    var messageEncode: String {
        return ""
    }
    
    func messageDecode(string: String) {
        
    }
}
