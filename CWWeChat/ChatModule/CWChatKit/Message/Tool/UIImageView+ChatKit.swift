//
//  UIImageView+ChatKit.swift
//  CWWeChat
//
//  Created by wei chen on 2017/4/21.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import YYWebImage



extension UIImageView {
    
    func cw_setImage(with url: URL?, placeholder: UIImage?) {
        
        let manager = CWChatKit.share.chatWebImageManager
        self.yy_setImage(with: url, placeholder: placeholder, options: YYWebImageOptions(), manager: manager, progress: nil, transform: nil, completion: nil)
    }
    
    
}
