//
//  CWPhotoBrowserScrollView.swift
//  CWWeChat
//
//  Created by chenwei on 16/7/9.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWPhotoBrowserScrollView: UIScrollView {

    var imageView:UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.clipsToBounds = true
        self.backgroundColor = UIColor.blackColor()
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.delegate = self
        self.autoresizingMask = [.FlexibleHeight,.FlexibleWidth]
        self.minimumZoomScale = 1.0
        self.maximumZoomScale = 2.0
        setupUI()
    }
    
    ///配置
    func setupUI() {
        imageView = UIImageView()
        
        self.addSubview(imageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = self.bounds
    }
    
    
    
    func addGesture() {
        
        
        
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CWPhotoBrowserScrollView:UIScrollViewDelegate {
    
}
