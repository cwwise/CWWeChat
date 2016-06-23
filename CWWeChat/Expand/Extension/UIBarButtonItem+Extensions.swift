//
//  UIBarButtonItem+Chat.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/23.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    class func fixBarItemSpaceWidth(spaceWidth: CGFloat) -> UIBarButtonItem {
        let fixspaceItem =  UIBarButtonItem(barButtonSystemItem: .FixedSpace, target: nil, action: nil)
        fixspaceItem.width = spaceWidth
        return fixspaceItem
    }
    
    
}
