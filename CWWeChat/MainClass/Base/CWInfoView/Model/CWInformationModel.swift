//
//  CWInformationModel.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/28.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

enum CWInformationType {
    case `default`
    case onlyTitle
    case images
    case button
    case other
}

class CWInformationModel: NSObject {

    /// 主标题
    var title: String
    /// 副标题
    var subTitle: String?
    /// 类型
    var type: CWInformationType

    
    ///是否显示箭头（默认YES）
    var showDisclosureIndicator: Bool = true
    ///禁止高亮（默认NO）
    var disableHighlight: Bool = false
    
    init(title: String, subTitle: String? = nil, type: CWInformationType = .default) {
        self.title = title
        self.subTitle = subTitle
        self.type = type
        super.init()
    }
    
}


