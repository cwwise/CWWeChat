//
//  UIColor+Extension.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/22.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import Foundation
import UIKit
import UIColor_Hex_Swift

extension UIColor {
    
    class func chatSystemColor() -> UIColor {
        return UIColor( "#09BB07")
    }
    
    class func navigationBarCocor() -> UIColor {
        return UIColor( "#141414")
    }
    
    //tableView背景色
    class func tableViewBackgroundColor() -> UIColor {
        return UIColor( "#EFEFF4")
    }
    
    //tableView分割线颜色
    class func tableViewCellLineColor() -> UIColor {
        return UIColor(white: 0.5, alpha: 0.3)
    }
    
    //searchBar Color
    class func searchBarTintColor() -> UIColor {
        return UIColor( "#EEEEF3")
    }
    
    class func defaultBlackColor() -> UIColor {
        return UIColor( "#2e3132")
    }
    
    class func searchBarBorderColor() -> UIColor {
        return UIColor( "#EEEEF3")
    }
    
    class func redTipColor() -> UIColor {
        return UIColor("#D84042")
    }
    
    class func chatBoxColor() -> UIColor {
        return UIColor("#F4F4F6")
    }
    
    class func chatBoxLineColor() -> UIColor {
        return UIColor("#BCBCBC")
    }
    
}
