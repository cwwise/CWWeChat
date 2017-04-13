//
//  CWTableViewTextCell.swift
//  CWWeChat
//
//  Created by chenwei on 2017/4/13.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class CWTableViewTextCell: CWTableViewCell {

    lazy var detailTitleLabel:UILabel = {
        let detailTitleLabel = UILabel()
        detailTitleLabel.textColor = UIColor.gray
        detailTitleLabel.font = kCWItemTitleFont
        return detailTitleLabel
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(detailTitleLabel)
        
        addsnap()
    }
    
    func addsnap() {
        detailTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(kCWCellLeftMargin)
            make.right.equalTo(-kCWCellLeftMargin)
            make.centerY.equalTo(self.contentView)
            make.top.equalTo(5)
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func cellWillAppear() {
        super.cellWillAppear()
        
  
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
