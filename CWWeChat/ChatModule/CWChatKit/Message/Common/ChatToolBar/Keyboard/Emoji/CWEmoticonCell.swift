//
//  CWEmoticonCell.swift
//  CWWeChat
//
//  Created by chenwei on 2017/4/20.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class CWEmoticonCell: UICollectionViewCell {
    
    var emoticon: CWEmoji? {
        willSet {
            
        }
    }
    
    var isDelete: Bool = false {
        willSet {
            if newValue == isDelete {
                return
            }
        }
    }
    
    var imageView: UIImageView
    
    override init(frame: CGRect) {
        imageView = UIImageView()
        super.init(frame: frame)
        
        imageView.contentMode = .scaleAspectFit
        imageView.size = CGSize(width: 32, height: 32)
        self.contentView.addSubview(imageView)
    }
    
    
    func updateContent() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
