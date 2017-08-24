//
//  EmoticonDetailHeaderView.swift
//  CWWeChat
//
//  Created by wei chen on 2017/8/24.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class EmoticonDetailHeaderView: UICollectionReusableView {
    
    var imageView: UIImageView!
    
    var titleLabel: UILabel!
    
    var subTitleLabel: UILabel!
    
    var actionButton: UIButton!
    
    var divisionLayer: CALayer!
    //
    var tipLabel: UILabel!
    
    var emoticonPackage: EmoticonPackage!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    func setupUI() {
        
        imageView = UIImageView()
        self.addSubview(imageView)
        
        titleLabel = UILabel()
        self.addSubview(titleLabel)

        subTitleLabel = UILabel()
        self.addSubview(subTitleLabel)
        
        actionButton = UIButton(type: .custom)
        self.addSubview(actionButton)
        
        divisionLayer = CALayer()
        self.layer.addSublayer(divisionLayer)

        tipLabel = UILabel()
        self.addSubview(tipLabel)
    }
    
    func addSnap() {
        
    }
    
    func setupInfo() {
        
    }
    
    override func layoutSubviews() {
        divisionLayer.frame = CGRect(x: 15, y: self.height-5, width: kScreenWidth-2*15, height: 0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
