//
//  CWMoreKeyboardCell.swift
//  CWChat
//
//  Created by chenwei on 16/4/6.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit
import SnapKit

class CWMoreKeyboardCell: UICollectionViewCell {

    var item:CWMoreKeyboardItem? {
        didSet {
            updateInfo()
        }
    }
    
    lazy private var iconButton:UIButton = {
        let iconButton = UIButton(type: .Custom)
        iconButton.doCircleRadius(5)
        return iconButton
    }()
    
    lazy private var titleLabel:UILabel = {
       let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFontOfSize(12)
        titleLabel.textColor = UIColor.grayColor()
        return titleLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(self.iconButton)
        addSubview(self.titleLabel)
        addsnap()
    }
    
    func addsnap()  {
        iconButton.snp_makeConstraints { (make) in
            make.top.equalTo(self.contentView)
            make.centerX.equalTo(self.contentView)
            make.width.equalTo(self.contentView)
            make.height.equalTo(iconButton.snp_width)
        }
        
        titleLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.contentView)
            make.bottom.equalTo(self.contentView)
        }
    }
    
    func updateInfo() {
        guard let cellitem = item else {
            iconButton.hidden = true
            titleLabel.hidden = true
            userInteractionEnabled = false
            return
        }
        
        iconButton.hidden = false
        titleLabel.hidden = false
        userInteractionEnabled = true
        titleLabel.text = cellitem.title
        iconButton.setImage(UIImage(named: cellitem.imagePath), forState: .Normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
