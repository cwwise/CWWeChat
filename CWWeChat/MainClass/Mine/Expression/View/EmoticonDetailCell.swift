//
//  EmoticonDetailCell.swift
//  CWWeChat
//
//  Created by chenwei on 2017/8/24.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import Kingfisher

class EmoticonDetailCell: UICollectionViewCell {
    
    var imageView: AnimatedImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView = AnimatedImageView()
        imageView.autoPlayAnimatedImage = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        self.contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
    }
    
    override var isSelected: Bool {
        willSet {
            if newValue {
                self.contentView.backgroundColor = UIColor.lightGray
            } else {
                self.contentView.backgroundColor = UIColor.white
            }
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
