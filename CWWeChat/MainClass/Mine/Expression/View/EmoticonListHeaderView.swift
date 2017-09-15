//
//  EmoticonListHeaderView.swift
//  CWWeChat
//
//  Created by chenwei on 2017/8/23.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class EmoticonListHeaderView: UITableViewHeaderFooterView {

    var titleLabel: UILabel!
    
    var accessoryView: UIButton!
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.white
        setupUI()
        addSnap()
    }
    
    func setupUI() {
        titleLabel = UILabel()
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        self.contentView.addSubview(titleLabel)
        
        accessoryView = UIButton(type: .custom)
        accessoryView.addTarget(self, action: #selector(accessoryAction), for: .touchUpInside)
        self.contentView.addSubview(accessoryView)
    }
    
    func addSnap() {
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(30)
        }
        
        accessoryView.snp.makeConstraints { (make) in
            
        }
        
    }
    
    @objc func accessoryAction() {
        
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
