//
//  LocationMessageBody.swift
//  ChatKit
//
//  Created by chenwei on 2017/10/3.
//

import Foundation

class LocationMessageBody: MessageBody {
    var type: MessageType {
        return .location
    }    
    /// 纬度
    var latitude: Double
    /// 经度
    var longitude: Double
    /// 位置信息
    var address: String
    
    var detail: String?
    
    init() {
        self.latitude = 0.0
        self.longitude = 0.0
        self.address = ""
    }
    
    init(latitude: Double,
         longitude: Double,
         address: String = "") {
        self.latitude = latitude
        self.longitude = latitude
        self.address = address
    }
    
    
    func messageEncode() -> String {
        return ""
    }
    
    func messageDecode(string: String) {
        
    }
    
    var description: String {
        return "位置信息"
    }
}
