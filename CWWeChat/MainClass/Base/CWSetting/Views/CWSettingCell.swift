//
//  CWSettingCell.swift
//  CWWeChat
//
//  Created by chenwei on 16/5/31.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit
import YYWebImage

let settingCellLeftMargin: CGFloat = 15

class CWSettingCell: UITableViewCell, CWSettingDataProtocol {

    var settingItem: CWSettingItem! {
        didSet {
          setupItem()
        }
    }
    
    private lazy var titleLabel:UILabel = {
        let titleLabel = UILabel()
        return titleLabel
    }()
    
    private lazy var rightLabel:UILabel = {
        let rightLabel = UILabel()
        rightLabel.textColor = UIColor.grayColor()
        rightLabel.font = UIFont.systemFontOfSize(15)
        return rightLabel
    }()
    
    private lazy var rightImageView:UIImageView = {
        let rightImageView = UIImageView()
        return rightImageView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(rightImageView)
        self.contentView.addSubview(rightLabel)

        p_addSnap()
    }
    

    //MARK: 添加约束
    func p_addSnap() {
    
        self.titleLabel.snp_makeConstraints { (make) in
            make.centerY.equalTo(self.contentView)
            make.left.equalTo(self.contentView).offset(settingCellLeftMargin)
        }
        
        self.rightLabel.snp_makeConstraints { (make) in
            make.right.equalTo(self.contentView)
            make.centerY.equalTo(self.contentView)
            make.left.greaterThanOrEqualTo(self.titleLabel.snp_right).offset(20)
        }
        
        self.rightImageView.snp_makeConstraints { (make) in
            make.centerY.equalTo(self.contentView)
            make.right.equalTo(self.rightLabel.snp_left).offset(-2)
        }
        
    }
    
    ///设置item对象
    func setupItem() {
        titleLabel.text = settingItem.title
        rightLabel.text = settingItem.subTitle
        
        if let rightImagePath = settingItem.rightImagePath {
            rightImageView.image = UIImage(named: rightImagePath)
        } else if let rightImageURL = settingItem.rightImageURL  {
            rightImageView.yy_setImageWithURL(NSURL(string: rightImageURL), placeholder: nil)
        } else {
            rightImageView.image = nil
        }
        
        if settingItem.showDisclosureIndicator == false {
            self.accessoryType = .None
            self.rightLabel.snp_updateConstraints(closure: { (make) in
                make.right.equalTo(self.contentView).offset(-15)
            })
        } else {
            self.accessoryType = .DisclosureIndicator
            self.rightLabel.snp_updateConstraints(closure: { (make) in
                make.right.equalTo(self.contentView)
            })
        }
        
        if settingItem.disableHighlight {
            self.selectionStyle = .None
        } else {
            self.selectionStyle = .Default
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
