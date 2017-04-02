//
//  CWMessageFrame.swift
//  CWWeChat
//
//  Created by chenwei on 16/7/3.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

struct CWMessageFrame {
    var heightOfCell: CGFloat
    var contentSize: CGSize
    
    init(heightOfCell: CGFloat, contentSize: CGSize) {
        self.heightOfCell = heightOfCell
        self.contentSize = contentSize
    }
    
}
