//
//  CWTableHeaderTitleView.swift
//  CWWeChat
//
//  Created by chenwei on 2017/4/11.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class CWTableHeaderTitleView: UITableViewHeaderFooterView {

    //
    lazy var titleLabel:UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.gray
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.numberOfLines = 0
        return titleLabel
    }()
    
    var text: String? {
        didSet {
            titleLabel.text = text
        }
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(titleLabel)
        p_addSnap()
    }
    
    //MARK: 添加约束
    func p_addSnap() {
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(kCWCellLeftMargin)
            make.right.equalTo(-kCWCellLeftMargin)
            make.bottom.equalTo(-7)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
