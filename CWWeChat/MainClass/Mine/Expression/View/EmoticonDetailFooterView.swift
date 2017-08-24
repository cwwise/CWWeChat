//
//  EmoticonDetailFooterView.swift
//  CWWeChat
//
//  Created by wei chen on 2017/8/24.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class EmoticonDetailFooterView: UICollectionReusableView {
    
    var emoticonPackage: EmoticonPackage! {
        didSet {
            setupInfo()
        }
    }
    
    var userImageView: UIImageView!
    var userLabel: UILabel!
    
    
    var copyrightLabel: UILabel!
    // 服务声明
    var serveButton: UIButton!
    // 侵权投诉
    var tortButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    func setupUI() {
        
    }
    
    func addSnap() {
        
    }
    
    func setupInfo() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
