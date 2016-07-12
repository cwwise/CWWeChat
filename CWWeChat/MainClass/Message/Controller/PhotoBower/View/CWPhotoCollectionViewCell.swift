//
//  CWPhotoCollectionViewCell.swift
//  CWWeChat
//
//  Created by chenwei on 16/7/9.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit


let photoPadding: CGFloat = 20

class CWPhotoCollectionViewCell: UICollectionViewCell {
    
    var scrollView: CWPhotoBrowserScrollView
    
    var photoURL:String! {
        didSet {
            photoFill()
        }
    }
    
    override init(frame: CGRect) {
        scrollView = CWPhotoBrowserScrollView()
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.scrollView.zoomScale = 1.0
        self.scrollView.imageView.image = nil
    }
    
    func setupUI() {
        self.contentView.addSubview(scrollView)
        scrollView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.contentView).inset(UIEdgeInsetsMake(0, 0, 0, photoPadding))
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func photoFill() {
        
        let url = NSURL(string: photoURL)
        scrollView.imageView.af_setImageWithURL(url!) { response in
                                                    if let image = response.result.value {
                                                        self.scrollView.imageView.image = image
                                                    }
        }
    }
    
    
    ///显示进度HUD
    func showHUD() {
        
    }
    
    ///移除进度
    func dismissHUD(animation: Bool){
        
    }
    
    
}
