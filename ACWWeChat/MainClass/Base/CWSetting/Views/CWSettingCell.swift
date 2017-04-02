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
    
    fileprivate lazy var titleLabel:UILabel = {
        let titleLabel = UILabel()
        return titleLabel
    }()
    
    fileprivate lazy var rightLabel:UILabel = {
        let rightLabel = UILabel()
        rightLabel.textColor = UIColor.gray
        rightLabel.font = UIFont.systemFont(ofSize: 15)
        return rightLabel
    }()
    
    fileprivate lazy var rightImageView:UIImageView = {
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
    
        self.titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.contentView)
            make.left.equalTo(self.contentView).offset(settingCellLeftMargin)
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
    func setupItem() {
        titleLabel.text = settingItem.title
        rightLabel.text = settingItem.subTitle
        
        if let rightImagePath = settingItem.rightImagePath {
            rightImageView.image = UIImage(named: rightImagePath)
        } else if let rightImageURL = settingItem.rightImageURL  {
            rightImageView.yy_setImage(with: URL(string: rightImageURL), placeholder: nil)
        } else {
            rightImageView.image = nil
        }
        
        if settingItem.showDisclosureIndicator == false {
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
        
        if settingItem.disableHighlight {
            self.selectionStyle = .none
        } else {
            self.selectionStyle = .default
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
