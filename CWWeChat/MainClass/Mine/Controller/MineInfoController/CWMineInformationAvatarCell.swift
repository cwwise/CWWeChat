//
//  CWMineInformationAvatarCell.swift
//  CWWeChat
//
//  Created by chenwei on 16/7/8.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWMineInformationAvatarCell: UITableViewCell {

    var settingItem: CWSettingItem! {
        didSet {
            setupItem()
        }
    }
    
    private lazy var titleLabel:UILabel = {
        let titleLabel = UILabel()
        return titleLabel
    }()
    
    
    private lazy var headerImageView:UIImageView = {
        let headerImageView = UIImageView()
        return headerImageView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.accessoryType = .DisclosureIndicator
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(headerImageView)
        
        p_addSnap()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: 添加约束
    func p_addSnap() {
        
        self.titleLabel.snp_makeConstraints { (make) in
            make.centerY.equalTo(self.contentView)
            make.left.equalTo(self.contentView).offset(settingCellLeftMargin)
        }
        
        
        self.headerImageView.snp_makeConstraints { (make) in
            make.right.equalTo(self.contentView)
            make.top.equalTo(self.contentView).offset(8)
            make.bottom.equalTo(self.contentView).offset(-8)
            make.width.equalTo(self.headerImageView.snp_height)

        }
        
    }
    
    func setupItem() {
        titleLabel.text = settingItem.title
        
        if let rightImagePath = settingItem.rightImagePath {
            headerImageView.image = UIImage(named: rightImagePath)
        } else if let rightImageURL = settingItem.rightImageURL  {
            headerImageView.af_setImageWithURL(NSURL(string: rightImageURL)!)
        } else {
            headerImageView.image = nil
        }
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
