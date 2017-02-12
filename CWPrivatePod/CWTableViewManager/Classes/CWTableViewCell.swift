//
//  CWTableViewCell.swift
//  CWWeChat
//
//  Created by wei chen on 2017/2/11.
//  Copyright © 2017年 chenwei. All rights reserved.
//

import UIKit
import SnapKit

public protocol CWTableViewCellDelegate: NSObjectProtocol {
    func cellDidSelect()
}


public class CWTableViewCell: UITableViewCell {
    
    public var item: CWTableViewItem!
    
    private lazy var titleLabel:UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = kCWItemTitleFont
        return titleLabel
    }()
    
    private lazy var rightLabel:UILabel = {
        let rightLabel = UILabel()
        rightLabel.textColor = UIColor.gray
        rightLabel.font = kCWItemsubTitleFont
        return rightLabel
    }()
    
    private lazy var rightImageView:UIImageView = {
        let rightImageView = UIImageView()
        return rightImageView
    }()
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(rightImageView)
        self.contentView.addSubview(rightLabel)
        
        p_addSnap()
    }
    
    //MARK: 添加约束
    func p_addSnap() {
        
        self.titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.contentView)
            make.left.equalTo(self.contentView).offset(kCWCellLeftMargin)
        }
        
        self.rightLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self.contentView)
            make.centerY.equalTo(self.contentView)
            make.left.greaterThanOrEqualTo(self.titleLabel.snp.right).offset(20)
        }
        
        self.rightImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.contentView)
            make.right.equalTo(self.rightLabel.snp.left).offset(-2)
        }
        
    }
    
    ///设置item对象
    public func cellWillAppear() {

        titleLabel.text = item.title
        rightLabel.text = item.subTitle
        
        if item.showDisclosureIndicator == false {
            self.accessoryType = .none
            self.rightLabel.snp.updateConstraints({ (make) in
                make.right.equalTo(self.contentView).offset(-15)
            })
        } else {
            self.accessoryType = .disclosureIndicator
            self.rightLabel.snp.updateConstraints({ (make) in
                make.right.equalTo(self.contentView)
            })
        }
        
        if item.disableHighlight {
            self.selectionStyle = .none
        } else {
            self.selectionStyle = .default
        }
        
    }
    
    
}
