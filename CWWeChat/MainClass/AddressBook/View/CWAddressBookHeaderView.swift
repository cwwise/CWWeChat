//
//  CWAddressBookHeaderView.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/23.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWAddressBookHeaderView: UITableViewHeaderFooterView {
    
    //title
    internal lazy var titleLabel:UILabel = {
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
    
    func p_addSnap() {
        self.titleLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 10, 0, 10))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
