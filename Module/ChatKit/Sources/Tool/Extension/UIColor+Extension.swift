//
//  UIColor+Extension.swift
//  ChatKit
//
//  Created by chenwei on 2017/10/3.
//

import Foundation
import UIKit
import Hue

extension UIColor {
    // 主要文字
    class var normalText: UIColor {
        return UIColor(hex: "#353535")
    }
    
    class var chatSystem: UIColor {
        return UIColor(hex: "#09BB07")
    }
    
    class var navigationBar: UIColor {
        return UIColor(hex: "#141414")
    }
    
    //tableView背景色
    class var tableViewBackground: UIColor {
        return UIColor(hex: "#EFEFF4")
    }
    
    //tableView分割线颜色
    class var tableViewCellLine: UIColor {
        return UIColor(hex: "#D9D9D9")
    }
    
    //searchBar Color
    class var searchBarTint: UIColor {
        return UIColor(hex: "#EEEEF3")
    }
    
    class var defaultBlack: UIColor {
        return UIColor(hex: "#2e3132")
    }
    
    class var searchBarBorder: UIColor {
        return UIColor(hex: "#EEEEF3")
    }
    
    class var redTip: UIColor {
        return UIColor(hex: "#D84042")
    }
    
    class var chatBox: UIColor {
        return UIColor(hex: "#F4F4F6")
    }
    
    class var chatBoxLine: UIColor {
        return UIColor(hex: "#BCBCBC")
    }
    
}
