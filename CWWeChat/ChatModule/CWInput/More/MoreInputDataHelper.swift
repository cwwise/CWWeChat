//
//  MoreInputDataHelper.swift
//  CWWeChat
//
//  Created by wei chen on 2017/8/30.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import UIKit

class MoreInputDataHelper: NSObject {

    /// 更多键盘item的数组
    var chatMoreKeyboardData: [MoreItem] = [MoreItem]()
    
    override init() {
        
        super.init()
        //创建数据
        let titleArray = ["照片", "拍摄", "小视频", "视频聊天", "红包", "转账",
                          "位置", "收藏", "个人名片", "语音输入", "卡券"]
        let imageArray = ["moreKB_image", "moreKB_video", "moreKB_sight", "moreKB_video_call",
                          "moreKB_wallet", "moreKB_pay", "moreKB_location", "moreKB_favorite",
                          "moreKB_friendcard", "moreKB_voice", "moreKB_wallet"]
        
        for i in 0..<titleArray.count {
            let type = MoreItemType(rawValue: i)!
            let item = MoreItem(title: titleArray[i], imagename: imageArray[i], type: type)
            chatMoreKeyboardData.append(item)
        }
        
    }
    
}
