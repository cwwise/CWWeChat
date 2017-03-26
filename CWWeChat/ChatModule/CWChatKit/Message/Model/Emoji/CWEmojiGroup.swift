//
//  CWEmojiGroup.swift
//  CWWeChat
//
//  Created by chenwei on 2017/3/26.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class CWEmojiGroup: NSObject {
    
    var type:CWEmojiType? {
        
        didSet {
            switch type! {
            case .emoji:
                rowNumber = 3
                colNumber = 7
            default:
                rowNumber = 2
                colNumber = 4
            }
            pageItemCount = rowNumber * colNumber
            pageNumber = self.count / self.pageItemCount + (self.count % self.pageItemCount == 0 ? 0: 1)
        }
        
    }
    var groupIconPath:String?
    var groupName:String?
    var dataPath:String?
    
    var emojiData = Array<CWEmoji>() {
        
        didSet {
            pageItemCount = rowNumber * colNumber
            pageNumber = self.count / self.pageItemCount + (self.count % self.pageItemCount == 0 ? 0: 1)
        }
        
    }
    
    var pageItemCount:Int = 0
    var pageNumber:Int = 0
    var rowNumber:Int  = 0
    var colNumber:Int  = 0
    
    var count: Int {
        return emojiData.count
    }
    
    func objectAtIndex(_ index:Int) -> CWEmoji {
        return self.emojiData[index]
    }
}

