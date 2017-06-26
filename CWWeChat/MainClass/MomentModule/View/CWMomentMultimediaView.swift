//
//  CWMomentMultimediaView.swift
//  CWWeChat
//
//  Created by chenwei on 2017/6/24.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

// 新闻链接
class CWMomentMultimediaView: UIView {
    
    var imageView: UIImageView = UIImageView() 
    var contentLabel: UILabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(hex: "#f7f7f7")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        contentLabel.numberOfLines = 2
        contentLabel.font = UIFont.systemFont(ofSize: 14)
        contentLabel.textColor = UIColor.black
        
        self.addSubview(imageView)
        self.addSubview(contentLabel)

        imageView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 40, height: 40))
            make.left.top.equalTo(5)
        }
        
        contentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(5+40+5)
            make.top.equalTo(5)
            make.right.bottom.equalTo(-5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
