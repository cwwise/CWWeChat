//
//  CWContactDetailFooterView.swift
//  CWWeChat
//
//  Created by wei chen on 2017/4/27.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class CWContactDetailFooterView: UIView {

    var button: UIButton = UIButton(type: .custom)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    func setupUI() {
        
        button.setTitle("发消息", for: .normal)
        button.commitStyle()
        self.addSubview(button)
        
        button.snp.makeConstraints { (make) in
            make.left.equalTo(kCWCellLeftMargin)
            make.right.equalTo(-kCWCellLeftMargin)
            make.top.equalTo(15)
            make.height.equalTo(44)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }



}
