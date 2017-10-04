//
//  LocationMessageBody.swift
//  ChatKit
//
//  Created by chenwei on 2017/10/3.
//

import Foundation

public class LocationMessageBody {
    /// 纬度
    public var latitude: Double
    /// 经度
    public var longitude: Double
    /// 位置信息
    public var address: String
    
    public var detail: String?
    
    init() {
        self.latitude = 0.0
        self.longitude = 0.0
        self.address = ""
    }
    
    public init(latitude: Double,
         longitude: Double,
         address: String = "") {
        self.latitude = latitude
        self.longitude = latitude
        self.address = address
    }
}

extension LocationMessageBody: MessageBody {
    
    public var type: MessageType {
        return .location
    }    
    
    public func messageEncode() -> String {
        return ""
    }
    
    public func messageDecode(string: String) {
        
    }
    
    public var description: String {
        return "位置信息"
    }
}
