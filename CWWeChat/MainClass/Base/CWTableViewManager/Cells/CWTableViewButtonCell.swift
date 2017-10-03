//
//  CWTableViewButtonCell.swift
//  CWWeChat
//
//  Created by chenwei on 2017/4/11.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class CWTableViewButtonCell: CWTableViewCell {

    // common样式下 隐藏
    var actionButton: UIButton = {
        let actionButton = UIButton(type: .custom)
        actionButton.isHidden = true
        actionButton.commitStyle()
        return actionButton
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.textLabel?.textAlignment = .center
        
        self.contentView.addSubview(actionButton)
        addsnap()
    }
    
    func addsnap() {
        actionButton.snp.makeConstraints { (make) in
            make.left.equalTo(kCWCellLeftMargin)
            make.right.equalTo(-kCWCellLeftMargin)
            make.centerY.equalTo(self.contentView)
            make.top.equalTo(5)
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func cellWillAppear() {
        
        guard let item = self.item as? CWButtonItem else {
            return
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
