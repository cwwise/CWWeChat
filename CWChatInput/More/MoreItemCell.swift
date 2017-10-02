//
//  MoreItemCell.swift
//  Keyboard
//
//  Created by chenwei on 2017/7/20.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import UIKit
import SnapKit


class MoreItemCell: UICollectionViewCell {
    
    var item: MoreItem? {
        didSet {
            updateInfo()
        }
    }
    
    var touchAction: ((MoreItem)->Void)?
    
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
        itemL.font = UIFont.systemFont(ofSize: 11.0)
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
            make.size.equalTo(CGSize(width: 60, height: 60))
        }
                
        itemLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.height.equalTo(21)
            make.top.equalTo(itemButton.snp.bottom).offset(6)
        }
    }
    
    @objc func itemButtonClick() {
        if let item = self.item, let action = self.touchAction {
            action(item)
        }
    }
    
    func updateInfo() {
        
        guard let cellitem = item else {
            itemButton.isHidden = true
            itemLabel.isHidden = true
            return
        }
        
        itemButton.isHidden = false
        itemLabel.isHidden = false
        
        itemLabel.text = cellitem.title
        itemButton.setImage(UIImage(named: cellitem.imagename), for: .normal)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
