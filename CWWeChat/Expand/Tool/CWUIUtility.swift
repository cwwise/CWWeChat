//
//  CWUIUtility.swift
//  CWWeChat
//
//  Created by chenwei on 16/5/31.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWUIUtility: NSObject {
    
    class func textHeightOfText(_ text: String?, width: CGFloat, attributes:[NSAttributedStringKey:AnyObject] ) -> CGFloat {
        
        guard let text = text else {
            return 0
        }
        
        let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let contentSize = text.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil).size
        return ceil(contentSize.height)
    }
    
}
