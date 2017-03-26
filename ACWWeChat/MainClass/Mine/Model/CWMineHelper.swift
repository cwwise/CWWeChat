//
//  CWMineHelper.swift
//  CWWeChat
//
//  Created by chenwei on 16/5/29.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWMineHelper: NSObject {

    var mineMenuData:[[CWMenuItem]]
    
    override init() {
        mineMenuData = [[CWMenuItem]]()
        super.init()
        
        //占位
        let item1 = CWMenuItem(iconImageName: "", title: "")
        
        let item2 = CWMenuItem(iconImageName: CWAsset.Mine_album.rawValue, title: "相册")
        let item3 = CWMenuItem(iconImageName: CWAsset.Mine_favorites.rawValue, title: "收藏")
        let item4 = CWMenuItem(iconImageName: CWAsset.Mine_wallet.rawValue, title: "钱包")
        let item5 = CWMenuItem(iconImageName: CWAsset.Mine_card.rawValue, title: "优惠券")
        let item6 = CWMenuItem(iconImageName: CWAsset.Mine_expression.rawValue, title: "表情")
        let item7 = CWMenuItem(iconImageName: CWAsset.Mine_setting.rawValue, title: "设置")
        
        mineMenuData.append([item1])
        mineMenuData.append([item2,item3,item4,item5])
        mineMenuData.append([item6])
        mineMenuData.append([item7])
        
        
    }
}
