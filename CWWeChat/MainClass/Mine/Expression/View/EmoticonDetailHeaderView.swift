//
//  EmoticonDetailHeaderView.swift
//  CWWeChat
//
//  Created by wei chen on 2017/8/24.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftyImage

class EmoticonDetailHeaderView: UICollectionReusableView {
    
    var imageView: UIImageView!
    
    var titleLabel: UILabel!
    
    var subTitleLabel: UILabel!
    
    var actionButton: UIButton!
    
    var divisionLayer: CALayer!
    //
    var tipLabel: UILabel!
    
    var emoticonPackage: EmoticonPackage! {
        didSet {
            setupInfo()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        addSnap()
    }
    
    func setupUI() {
        
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        self.addSubview(imageView)
        
        titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textColor = UIColor.black
        self.addSubview(titleLabel)

        subTitleLabel = UILabel()
        subTitleLabel.font = UIFont.systemFont(ofSize: 14)
        subTitleLabel.textColor = UIColor(hex: "#6c6c6c")
        subTitleLabel.numberOfLines = 0
        self.addSubview(subTitleLabel)
        
        actionButton = UIButton(type: .custom)
        let normalImage = UIImage.size(width: 10, height: 10).color(UIColor(hex: "#1AAD19")).corner(radius: 5).image.resizableImage()
        actionButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        actionButton.setBackgroundImage(normalImage, for: .normal)
        self.addSubview(actionButton)
        
        divisionLayer = CALayer()
        divisionLayer.backgroundColor = UIColor(hex: "#ebebeb").cgColor
        self.layer.addSublayer(divisionLayer)

        tipLabel = UILabel()
        tipLabel.backgroundColor = UIColor.white
        tipLabel.textColor = UIColor(hex: "#ccc")
        tipLabel.font = UIFont.systemFont(ofSize: 12)
        tipLabel.text = " 长按表情可以预览 "
        self.addSubview(tipLabel)
    }
    
    func addSnap() {
        
        imageView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.height.equalTo(220)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(25)
            make.left.equalTo(15)
        }
        
        subTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.equalTo(15)
        }
        
        actionButton.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.right.equalTo(-15)
            make.size.equalTo(CGSize(width: 90, height: 32))
        }
        
        tipLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.bottom.equalTo(self)
        }
    }
    
    func setupInfo() {
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: emoticonPackage.banner)
        titleLabel.text = emoticonPackage.name
        subTitleLabel.text = emoticonPackage.subTitle
        
        // 显示动画
        if emoticonPackage.emoticonList.first?.format == .gif {
            
        } else {
            
            
        }
        
        actionButton.setTitle("下载", for: .normal)

        
        
    }
    
    override func layoutSubviews() {
        divisionLayer.frame = CGRect(x: 15, y: self.height-8, width: kScreenWidth-2*15, height: 0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
