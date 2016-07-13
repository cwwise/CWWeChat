//
//  CWMenuCell.swift
//  CWWeChat
//
//  Created by chenwei on 16/5/28.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

let redPoint_Width:CGFloat = 8.0

class CWMenuCell: UITableViewCell {

    var menuItem: CWMenuItem! {
        didSet {
            self.setupItem()
        }
    }
    
    //
    private lazy var iconImageView:UIImageView = {
       let iconImageView = UIImageView()
        return iconImageView
    }()
    
    private lazy var titleLabel:UILabel = {
        let titleLabel = UILabel()
        return titleLabel
    }()
    
    private lazy var rightImageView:UIImageView = {
        let rightImageView = UIImageView()
        return rightImageView
    }()
    
    private lazy var redPointView:UIView = {
        let redPointView = UIView()
        redPointView.backgroundColor = UIColor.redColor()
        redPointView.layer.masksToBounds = true
        redPointView.layer.cornerRadius = redPoint_Width/2
        return redPointView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        self.accessoryType = .DisclosureIndicator
        self.contentView.addSubview(iconImageView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(rightImageView)
        self.contentView.addSubview(redPointView)
        
        p_addSnap()
    }
    
    //MARK: 添加约束
    func p_addSnap() {
        
        let leftOffset: CGFloat = 15
        let iconImageView_Width: CGFloat = 25

        self.iconImageView.snp_makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(leftOffset)
            make.centerY.equalTo(self.contentView)
            make.width.height.equalTo(iconImageView_Width)
        }
        
        self.titleLabel.snp_makeConstraints { (make) in
            make.centerY.equalTo(self.iconImageView)
            make.left.equalTo(self.iconImageView.snp_right).offset(leftOffset)
            make.right.lessThanOrEqualTo(self.contentView).offset(leftOffset)
        }
        
        self.rightImageView.snp_makeConstraints { (make) in
            make.right.equalTo(self.contentView).offset(1)
            make.centerY.equalTo(self.iconImageView)
            make.width.height.equalTo(31)
        }

        //红点
        self.redPointView.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.rightImageView.snp_right).offset(1)
            make.centerY.equalTo(self.rightImageView.snp_top).offset(1)
            make.width.height.equalTo(redPoint_Width)
        }
    }
    
    
    //设置值
    func setupItem() {
        
        self.iconImageView.image = UIImage(named: menuItem.iconImageName)
        self.titleLabel.text = menuItem.title
        
        if let rightIconURL = menuItem.rightIconURL {
            
            self.rightImageView.snp_updateConstraints(closure: { (make) in
                make.width.equalTo(self.rightImageView.snp_width)
            })
            let url = NSURL(string: rightIconURL)!
            self.rightImageView.yy_setImageWithURL(url, placeholder: nil)
        
        } else {
        
            self.rightImageView.snp_updateConstraints(closure: { (make) in
                make.width.equalTo(0)
            })
        }
        
        self.redPointView.hidden = !menuItem.showRightRedPoint
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
