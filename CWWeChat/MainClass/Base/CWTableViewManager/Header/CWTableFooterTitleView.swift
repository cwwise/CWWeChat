//
//  CWTableFooterTitleView.swift
//  CWWeChat
//
//  Created by chenwei on 2017/4/11.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class CWTableFooterTitleView: CWTableHeaderTitleView {

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.titleLabel.snp.remakeConstraints { (make) in
            make.left.equalTo(kCWCellLeftMargin)
            make.right.equalTo(-kCWCellLeftMargin)
            make.top.equalTo(7)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
