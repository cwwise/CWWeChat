//
//  CWAboutHeaderView.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/23.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWAboutHeaderView: UIView {

    /// 文字
    var title: String? {
        didSet {
            self.titleLabel.text = title
        }
    }
    /// iconImage的名称
    var iconPath: String? {
        didSet {
            guard let path = iconPath else {
                return
            }
            self.imageView.image = UIImage(named: path)
        }
    }
    
    fileprivate lazy var titleLabel:UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 17)
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.gray
        return titleLabel
    }()
    
    fileprivate lazy var imageView:UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.titleLabel)
        self.addSubview(self.imageView)
        p_addSnap()

    }
    
    func p_addSnap() {
        
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(8)
            make.centerX.equalTo(self)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.height.equalTo(25)
            make.bottom.equalTo(-5)
            make.left.right.equalTo(self)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
