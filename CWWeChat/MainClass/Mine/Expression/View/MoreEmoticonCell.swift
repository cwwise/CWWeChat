//
//  MoreEmoticonCell.swift
//  CWWeChat
//
//  Created by chenwei on 2017/8/25.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class MoreEmoticonCell: UICollectionViewCell {
    
    var touchAction: ((MoreEmoticonCell)->Void)?

    lazy var itemButton: UIButton = {
        let itemBtn = UIButton()
        itemBtn.backgroundColor = UIColor.white
        itemBtn.addTarget(self, action: #selector(itemButtonClick), for: .touchUpInside)
        itemBtn.layer.cornerRadius = 10
        itemBtn.layer.masksToBounds = true
        itemBtn.layer.borderColor = UIColor.lightGray.cgColor
        itemBtn.layer.borderWidth = 0.5
        return itemBtn
    }()
    
    
    lazy var itemLabel: UILabel = {
        let itemL = UILabel()
        itemL.textColor = UIColor.gray
        itemL.font = UIFont.systemFont(ofSize: 12.0)
        itemL.textAlignment = .center
        return itemL
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(itemButton)
        addSubview(itemLabel)
        addsnap()
    }
    
    func addsnap()  {
        itemButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView)
            make.centerX.equalTo(self.contentView)
            make.width.equalTo(self)
            make.height.equalTo(itemButton.snp.width)
        }
        
        itemLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.height.equalTo(18)
            make.top.equalTo(itemButton.snp.bottom).offset(8)
        }
    }
    
    @objc func itemButtonClick() {
        
        if let action = self.touchAction {
            action(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
