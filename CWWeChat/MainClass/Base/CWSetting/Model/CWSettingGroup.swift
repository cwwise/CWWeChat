//
//  CWSettingGroup.swift
//  CWWeChat
//
//  Created by chenwei on 16/5/31.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWSettingGroup: NSObject {

    var headerTitle: String? {
        didSet {
            let width = Screen_Width - 2*15
            let attributes = [NSForegroundColorAttributeName:UIColor.whiteColor(),
                              NSFontAttributeName: UIFont.systemFontOfSize(14)]
            headerHeight = CWUIUtility.textHeightOfText(headerTitle, width: width, attributes: attributes) + 0.5 + 5.0
        }
    }
    
    var footerTitle: String? {
        didSet {
            let width = Screen_Width - 2*15
            let attributes = [NSForegroundColorAttributeName:UIColor.whiteColor(),
                              NSFontAttributeName: UIFont.systemFontOfSize(14)]
            footerHeight = CWUIUtility.textHeightOfText(footerTitle, width: width, attributes: attributes) + 15 + 5.0
        }
    }
    
    private(set) var headerHeight: CGFloat = 0.5
    private(set) var footerHeight: CGFloat = 20
    
    var count: Int {
        return sectionItems.count
    }

    var sectionItems: [AnyObject]
    
    //http://www.jianshu.com/p/bf6a8a054156
    init(headerTitle: String? = nil, footerTitle: String? = nil,items: [AnyObject]) {
        self.sectionItems = items
        super.init()
        
        //bug 并不会触发didSet方法
//        self.headerTitle = headerTitle
//        self.footerTitle = footerTitle
        self.setValue(headerTitle, forKey: "headerTitle")
        self.setValue(footerTitle, forKey: "footerTitle")
    }
    
    subscript(index : Int) -> CWSettingItem? {
        if index > count {
            return nil
        }
        return sectionItems[index] as? CWSettingItem
    }

    
    func itemObjectAtIndex(index: Int) -> AnyObject {
        return sectionItems[index]
    }
    
}
