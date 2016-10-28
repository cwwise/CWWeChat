//
//  CWAboutHeaderView.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/23.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWAboutHeaderView: UITableViewHeaderFooterView {

    /// 文字
    var title: String? {
        didSet {
            self.titleLabel.text = title
        }
    }
    /// iconImage的名称
    var iconPath: String? {
        didSet {
            self.imageView.image = UIImage(named: iconPath!)
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
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.imageView)

        p_addSnap()
    }
    
    func p_addSnap() {
        
        imageView.snp_makeConstraints { (make) in
            make.top.equalTo(self.contentView).offset(4)
            make.centerX.equalTo(self.contentView)
            make.bottom.equalTo(self.titleLabel.snp.top).offset(1)
            make.width.equalTo(self.imageView.snp_height).multipliedBy(1)
        }
        
        titleLabel.snp_makeConstraints { (make) in
            make.height.equalTo(25)
            make.bottom.equalTo(self.contentView).offset(-10)
            make.left.right.equalTo(self.contentView)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
