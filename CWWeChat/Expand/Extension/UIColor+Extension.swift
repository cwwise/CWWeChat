//
//  UIColor+Extension.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/22.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import Foundation
import UIKit
import Hue

extension UIColor {
    // 主要文字
    class func normalTextColor() -> UIColor {
        return UIColor(hex: "#353535")
    }
    
    class func chatSystemColor() -> UIColor {
        return UIColor(hex: "#09BB07")
    }
    
    class func navigationBarCocor() -> UIColor {
        return UIColor(hex: "#141414")
    }
    
    //tableView背景色
    class func tableViewBackgroundColor() -> UIColor {
        return UIColor(hex: "#EFEFF4")
    }
    
    //tableView分割线颜色
    class func tableViewCellLineColor() -> UIColor {
        return UIColor(hex: "#D9D9D9")
    }
    
    //searchBar Color
    class func searchBarTintColor() -> UIColor {
        return UIColor(hex: "#EEEEF3")
    }
    
    class func defaultBlackColor() -> UIColor {
        return UIColor(hex: "#2e3132")
    }
    
    class func searchBarBorderColor() -> UIColor {
        return UIColor(hex: "#EEEEF3")
    }
    
    class func redTipColor() -> UIColor {
        return UIColor(hex: "#D84042")
    }
    
    class func chatBoxColor() -> UIColor {
        return UIColor(hex: "#F4F4F6")
    }
    
    class func chatBoxLineColor() -> UIColor {
        return UIColor(hex: "#BCBCBC")
    }
    
}
