//
//  CWEmoticonCell.swift
//  CWWeChat
//
//  Created by chenwei on 2017/4/20.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import YYWebImage

class CWEmoticonCell: UICollectionViewCell {
    
    var emoticon: CWEmoji? {
        willSet {
            if newValue == emoticon {
                return
            }
        }
    }
    
    var isDelete: Bool = false {
        willSet {
            if newValue == isDelete {
                return
            }
        }
    }
    
    var imageView: UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.contentMode = .scaleAspectFit
        imageView.size = CGSize(width: 32, height: 32)
        self.contentView.addSubview(imageView)
    }
    
    func updateContent() {
        // 先简单判断 后期加上 网络表情的处理
        if isDelete {
            imageView.image = nil
        } else {
            let imagePath = Bundle.main.path(forResource: emoticon?.png, ofType: nil)
            imageView.yy_setImage(with: URL(fileURLWithPath: imagePath!), options: .ignoreDiskCache)
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.center = CGPoint(x: self.width/2, y: self.height/2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
