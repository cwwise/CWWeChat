//
//  TableViewFooterTitleView.swift
//  EFTableViewManager
//
//  Created by chenwei on 2017/10/2.
//

import UIKit

class FooterTitleView: HeaderTitleView {

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.titleLabel.snp.remakeConstraints { (make) in
            make.left.equalTo(kCellLeftMargin)
            make.right.equalTo(-kCellLeftMargin)
            make.top.equalTo(7)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
