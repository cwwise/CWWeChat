//
//  EmoticonDetailHeaderView.swift
//  CWWeChat
//
//  Created by wei chen on 2017/8/24.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import Kingfisher

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
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.textColor = UIColor.black
        self.addSubview(titleLabel)

        subTitleLabel = UILabel()
        subTitleLabel.font = UIFont.systemFont(ofSize: 15)
        subTitleLabel.textColor = UIColor.black
        self.addSubview(subTitleLabel)
        
        actionButton = UIButton(type: .custom)
        self.addSubview(actionButton)
        
        divisionLayer = CALayer()
        self.layer.addSublayer(divisionLayer)

        tipLabel = UILabel()
        tipLabel.textColor = UIColor.white
        tipLabel.font = UIFont.systemFont(ofSize: 14)
        tipLabel.text = "长按可以预览"
        self.addSubview(tipLabel)
    }
    
    func addSnap() {
        
        imageView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.height.equalTo(220)
        }
        
        
    }
    
    func setupInfo() {
        
        imageView.kf.setImage(with: emoticonPackage.banner)
        titleLabel.text = emoticonPackage.name
        subTitleLabel.text = emoticonPackage.subTitle
        
    }
    
    override func layoutSubviews() {
        divisionLayer.frame = CGRect(x: 15, y: self.height-5, width: kScreenWidth-2*15, height: 0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
