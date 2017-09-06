//
//  CWMomentHeaderView.swift
//  CWWeChat
//
//  Created by chenwei on 2017/6/23.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class CWMomentHeaderView: UIView {

    var usernameLabel: UILabel = {
       let usernameLabel = UILabel()
        usernameLabel.font = UIFont.systemFont(ofSize: 17)
        usernameLabel.textColor = UIColor.white
        usernameLabel.textAlignment = .right
        return usernameLabel
    }()
    
    var headerImageView: UIImageView = {
       let headerImageView = UIImageView()
        headerImageView.layer.borderColor = UIColor.white.cgColor;
        headerImageView.layer.borderWidth = 2.5
        
        return headerImageView
    }()
    
    var backgroundImageView: UIImageView = {
       let backgroundImageView = UIImageView()
        backgroundImageView.image = UIImage(named: "fc_background")
        return backgroundImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    func setupUI() {
        self.addSubview(backgroundImageView)
        self.addSubview(usernameLabel)
        self.addSubview(headerImageView)
        self.backgroundColor = UIColor.white
        
        self.backgroundImageView.frame = CGRect(x: 0, y: -50, width: self.width, height: self.height)
        self.headerImageView.snp.makeConstraints { (make) in
            make.bottom.equalTo(backgroundImageView.snp.bottom).offset(25)
            make.right.equalTo(-10)
            make.size.equalTo(CGSize(width: 70, height: 70))
        }
        
        self.usernameLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(backgroundImageView.snp.bottom).offset(-10)
            make.right.equalTo(headerImageView.snp.left).offset(-20)
        }
        
        self.usernameLabel.text = "武藤游戏boy"
        let url = URL(string: kImageBaseURLString+"chenwei.jpg")
        self.headerImageView.kf.setImage(with: url)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
