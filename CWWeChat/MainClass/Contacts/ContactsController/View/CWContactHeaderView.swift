//
//  CWContactHeaderView.swift
//  CWWeChat
//
//  Created by wei chen on 2017/4/3.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class CWContactHeaderView: UITableViewHeaderFooterView {

    //title
    lazy var titleLabel:UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor(hex: "#8E8E93")
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.numberOfLines = 0
        return titleLabel
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(titleLabel)
        p_addSnap()
    }
    
    func p_addSnap() {
        self.titleLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 10, 0, 10))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
