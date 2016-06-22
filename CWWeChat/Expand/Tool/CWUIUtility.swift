//
//  CWUIUtility.swift
//  CWWeChat
//
//  Created by chenwei on 16/5/31.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWUIUtility: NSObject {
    
    class func textHeightOfText(text: NSString?, width: CGFloat, attributes:[String:AnyObject] ) -> CGFloat {
        
        guard let text = text else {
            return 0
        }
        
        let size = CGSize(width: width, height: CGFloat.max)
        let contentSize = text.boundingRectWithSize(size, options: .UsesLineFragmentOrigin, attributes: attributes, context: nil).size
        return contentSize.height
    }
    
}