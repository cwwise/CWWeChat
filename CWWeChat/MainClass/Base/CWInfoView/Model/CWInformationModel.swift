//
//  CWInformationModel.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/28.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

enum CWInformationType {
    case Default
    case OnlyTitle
    case Images
    case Button
    case Other
}


class CWInformationModel: NSObject {

    ///主标题
    var title: String
    ///副标题
    var subTitle: String?
    
    init(title: String, subTitle: String? = nil, type: CWSettingItemType = .Default) {
        self.title = title
        self.subTitle = subTitle
        super.init()
    }
    
}
