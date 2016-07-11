//
//  CWEmojiGroup.swift
//  CWWeChat
//
//  Created by chenwei on 16/7/9.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWEmojiGroup: NSObject {

    var type:CWEmojiType? {
        
        didSet {
            switch type! {
            case .Emoji:
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
    
    var emojiData = Array<CWChatEmoji>() {
        
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
    
    func objectAtIndex(index:Int) -> CWChatEmoji {
        return self.emojiData[index]
    }
}
