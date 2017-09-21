//
//  CWLocationMessageBody.swift
//  CWWeChat
//
//  Created by chenwei on 2017/4/20.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import Foundation
import SwiftyJSON

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
    var detail: String?
    /// 位置信息的图片
    var locationImageURL: URL?
    
    init(latitude: Double = 0.0,
         longitude: Double = 0.0,
         address: String = "") {
        self.latitude = latitude
        self.longitude = latitude
        self.address = address
    }
}

extension CWLocationMessageBody {
    
    var info: [String: String] {
        var info = ["latitude": "\(latitude)", "longitude": "\(longitude)","address": "\(address)"]
        if let urlString = self.locationImageURL?.absoluteString {
            info["url"] = urlString
        }
        return info
    }
    
    var messageEncode: String {
        do {
            let data = try JSONSerialization.data(withJSONObject: self.info, options: .prettyPrinted)
            return String(data: data, encoding: .utf8) ?? ""
        } catch {
            return ""
        }
    }
    
    func messageDecode(string: String) {
        let json: JSON = JSON(parseJSON: string)
        self.latitude = json["latitude"].doubleValue
        self.longitude = json["longitude"].doubleValue
        self.address = json["address"].stringValue
    }
}
