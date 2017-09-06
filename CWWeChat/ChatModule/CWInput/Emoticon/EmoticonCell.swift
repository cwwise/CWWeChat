//
//  EmoticonCell.swift
//  CWWeChat
//
//  Created by wei chen on 2017/7/19.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import Kingfisher

class EmoticonCell: UICollectionViewCell {
    
    var emoticon: Emoticon? {
        didSet {
            updateContent()
        }
    }
    /// 是否为删除按钮
    var isDelete: Bool = false
    
    /// 
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.size = CGSize(width: 32, height: 32)
        return imageView
    }()
    
    /// 大表情时 展示title
    var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.gray
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        return titleLabel
    }() 
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(titleLabel)
    }
    
    func updateContent() {
        // 先简单判断 后期加上 网络表情的处理
        if isDelete {
            imageView.image = UIImage(named: "DeleteEmoticonBtn")
        } else {
            if let emoticon = emoticon {
                imageView.kf.setImage(with: emoticon.originalUrl)
                if emoticon.type == .big {
                    titleLabel.text = emoticon.title
                } else {
                    titleLabel.text = nil
                }
            } else {
                imageView.image = nil
                titleLabel.text = nil
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if emoticon?.type == .big {
            imageView.size = CGSize(width: 60, height: 55)
        } else {
            imageView.size = CGSize(width: 32, height: 32)
        }
        imageView.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        titleLabel.frame = CGRect(x: 0, y: imageView.bottom, width: self.bounds.width, height: 12)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
