//
//  CWTableViewBoolCell.swift
//  CWWeChat
//
//  Created by wei chen on 2017/2/11.
//  Copyright © 2017年 chenwei. All rights reserved.
//

import UIKit

// switch cell
class CWTableViewBoolCell: CWTableViewCell {
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(titleLabel)
        self.accessoryView = cellSwitch
        self.selectionStyle = .none
        p_addSnap()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: 添加约束
    func p_addSnap() {
        
        self.titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.contentView)
            make.left.equalTo(self.contentView).offset(kCWCellLeftMargin)
            make.right.lessThanOrEqualTo(self.contentView).offset(-kCWCellLeftMargin)
        }
        
    }
    
    
    
    func switchChangeStatus(_ cellSwitch: UISwitch) {
        if let delegate = self.delegate {

        }
    }
    
    
    fileprivate lazy var cellSwitch:UISwitch = {
        let cellSwitch = UISwitch()
        cellSwitch.addTarget(self, action: #selector(switchChangeStatus(_:)), for: .valueChanged)
        return cellSwitch
    }()    
    
    
}
