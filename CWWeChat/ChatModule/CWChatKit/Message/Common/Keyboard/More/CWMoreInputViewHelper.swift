//
//  CWMoreKeyBoardHelper.swift
//  CWWeChat
//
//  Created by chenwei on 16/7/10.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWMoreInputViewHelper: NSObject {

    /// 更多键盘item的数组
    var chatMoreKeyboardData: [CWMoreItem] = [CWMoreItem]()
    
    override init() {
        
        super.init()
        //创建数据
        let titleArray = ["照片", "拍摄", "小视频", "视频聊天", "红包", "转账",
                          "位置", "收藏", "个人名片", "语音输入", "卡券"]
        let imageArray = ["moreKB_image", "moreKB_video", "moreKB_sight", "moreKB_video_call",
                          "moreKB_wallet", "moreKB_pay", "moreKB_location", "moreKB_favorite",
                          "moreKB_friendcard", "moreKB_voice", "moreKB_wallet"]

        for i in 0..<titleArray.count {
            let type = CWMoreItemType(rawValue: i)!
            let item = CWMoreItem(title: titleArray[i], imagePath: imageArray[i], type: type)
            chatMoreKeyboardData.append(item)
        }

    }
    
    
}
