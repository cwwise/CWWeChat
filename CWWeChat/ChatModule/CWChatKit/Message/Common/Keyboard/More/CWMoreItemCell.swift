//
//  CWMoreKeyboardCell.swift
//  CWChat
//
//  Created by chenwei on 16/4/6.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit
import SnapKit

class CWMoreItemCell: UICollectionViewCell {

    var item: CWMoreItem? {
        didSet {
            updateInfo()
        }
    }
    
    lazy fileprivate var iconButton:UIButton = {
        let iconButton = UIButton(type: .custom)
        iconButton.doCircleRadius(5)
        return iconButton
    }()
    
    lazy fileprivate var titleLabel:UILabel = {
       let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.textColor = UIColor.gray
        return titleLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(self.iconButton)
        addSubview(self.titleLabel)
        addsnap()
    }
    
    func addsnap()  {
        iconButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView)
            make.centerX.equalTo(self.contentView)
            make.width.equalTo(self.contentView)
            make.height.equalTo(iconButton.snp.width)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.contentView)
            make.bottom.equalTo(self.contentView)
        }
    }
    
    func updateInfo() {
        
        guard let cellitem = item else {
            iconButton.isHidden = true
            titleLabel.isHidden = true
            isUserInteractionEnabled = false
            return
        }
        
        iconButton.isHidden = false
        titleLabel.isHidden = false
        isUserInteractionEnabled = true
        
        titleLabel.text = cellitem.title
        iconButton.setImage(UIImage(named: cellitem.imagePath), for: UIControlState())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
