//
//  CWEmoticonToolItemCell.swift
//  CWWeChat
//
//  Created by wei chen on 2017/7/19.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class EmoticonToolItemCell: UICollectionViewCell {

    var imageView: UIImageView = UIImageView()
    private var line: CALayer = CALayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    private func setupUI() {
        line.backgroundColor = UIColor(white: 0.9, alpha: 1.0).cgColor
        
        imageView.contentMode = .scaleAspectFit
        imageView.bounds = CGRect(x: 0, y: 0, width: 25, height: 25)
        
        contentView.addSubview(imageView)
        contentView.layer.addSublayer(line)
        
        selectedBackgroundView = UIView()
        selectedBackgroundView?.backgroundColor = UIColor(red:0.93, green:0.93, blue:0.95, alpha:1.00)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.center = CGPoint(x: bounds.midX, y: bounds.midY)
        
        line.frame = CGRect(x: bounds.maxX - 0.25, y: 8, width: 0.5, height: bounds.height - 16)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
