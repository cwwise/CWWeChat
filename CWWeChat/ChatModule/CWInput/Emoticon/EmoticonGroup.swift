//
//  EmojiGroup.swift
//  Keyboard
//
//  Created by chenwei on 2017/3/26.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import SwiftyJSON

public class EmoticonGroup: NSObject {
    // id
    var id: String
    // 表情组 名称
    var name: String
    // 标签类型
    var type: EmoticonType = .normal
    /// 表情图像路径
    var iconPath: String
    /// 表情数组
    var emoticons: [Emoticon] = []
    
    var count: Int {
        return emoticons.count
    }
    
    init(id: String,
         name: String = "",
         icon: String,
         emoticons: [Emoticon]) {
        self.id = id
        self.name = name
        self.iconPath = icon
        self.emoticons = emoticons
    }
    
}

public extension EmoticonGroup {
    
    convenience init?(identifier : String) {
        let bundle = Bundle.main
        guard let path = bundle.path(forResource: "emoticons.bundle/\(identifier)/Info", ofType: "plist"),
        let dict = NSDictionary(contentsOfFile: path) else {
            return nil
        }
       
        let json = JSON(dict)
        let emoticonsArray = json["emoticons"].arrayValue
        
        let directory = URL(fileURLWithPath: path).deletingLastPathComponent().path
        
        let id = json["id"].stringValue
        let icon = json["image"].stringValue
        var emoticons: [Emoticon] = []
        let type = json["type"].intValue
        let emoticonType = EmoticonType(rawValue: type) ?? .normal
        for item in emoticonsArray {
            let id = item["id"].stringValue
            let title = item["title"].stringValue
            let _ = item["type"].stringValue
            // 需要添加@2x
            let imagePath = directory + "/" + id + "@2x.png"
            
            let emoticon = Emoticon(id: id, title: title, path: URL(fileURLWithPath: imagePath))
            emoticon.type = emoticonType
            emoticons.append(emoticon)
        }
        
        self.init(id: id, icon: directory + "/" + icon, emoticons: emoticons)
    }
    
}
