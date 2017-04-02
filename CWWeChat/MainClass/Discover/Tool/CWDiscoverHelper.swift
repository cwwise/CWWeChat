//
//  CWDiscoverHelper.swift
//  CWWeChat
//
//  Created by chenwei on 16/5/28.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWDiscoverHelper: NSObject {

    var discoverMenuData:[[CWMenuItem]]
    
    override init() {
        discoverMenuData = [[CWMenuItem]]()
        super.init()
        
        let item1 = CWMenuItem(iconImageName: CWAsset.Discover_album.rawValue, title: "朋友圈")
        item1.rightIconURL = "http://img4.duitang.com/uploads/item/201510/16/20151016113134_TZye4.thumb.224_0.jpeg";
        item1.showRightRedPoint = true
        let item2 = CWMenuItem(iconImageName: CWAsset.Discover_QRcode.rawValue, title: "扫一扫")
        let item3 = CWMenuItem(iconImageName: CWAsset.Discover_shake.rawValue, title: "摇一摇")
        let item4 = CWMenuItem(iconImageName: CWAsset.Discover_location.rawValue, title: "附近的人")
        let item5 = CWMenuItem(iconImageName: CWAsset.Discover_bottle.rawValue, title: "漂流瓶")
        let item6 = CWMenuItem(iconImageName: CWAsset.Discover_shopping.rawValue, title: "购物")
        let item7 = CWMenuItem(iconImageName: CWAsset.Discover_game.rawValue, title: "游戏")
        
        discoverMenuData.append([item1])
        discoverMenuData.append([item2,item3])
        discoverMenuData.append([item4,item5])
        discoverMenuData.append([item6,item7])
    }
    
}
