//
//  CWMenuCell.swift
//  CWWeChat
//
//  Created by chenwei on 16/5/28.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit
import Kingfisher

let redPoint_Width:CGFloat = 8.0

class CWMenuCell: UITableViewCell {

    var menuItem: CWMenuItem! {
        didSet {
            self.setupItem()
        }
    }
    
    //
    fileprivate lazy var iconImageView:UIImageView = {
       let iconImageView = UIImageView()
        return iconImageView
    }()
    
    fileprivate lazy var titleLabel:UILabel = {
        let titleLabel = UILabel()
        return titleLabel
    }()
    
    fileprivate lazy var rightImageView:UIImageView = {
        let rightImageView = UIImageView()
        return rightImageView
    }()
    
    fileprivate lazy var redPointView:UIView = {
        let redPointView = UIView()
        redPointView.backgroundColor = UIColor.red
        redPointView.layer.masksToBounds = true
        redPointView.layer.cornerRadius = redPoint_Width/2
        return redPointView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        self.accessoryType = .disclosureIndicator
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

        self.iconImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(leftOffset)
            make.centerY.equalTo(self.contentView)
            make.width.height.equalTo(iconImageView_Width)
        }
        
        self.titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.iconImageView)
            make.left.equalTo(self.iconImageView.snp.right).offset(leftOffset)
            make.right.lessThanOrEqualTo(self.contentView).offset(leftOffset)
        }
        
        self.rightImageView.snp.makeConstraints { (make) in
            make.right.equalTo(self.contentView).offset(1)
            make.centerY.equalTo(self.iconImageView)
            make.width.height.equalTo(31)
        }

        //红点
        self.redPointView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.rightImageView.snp.right).offset(1)
            make.centerY.equalTo(self.rightImageView.snp.top).offset(1)
            make.width.height.equalTo(redPoint_Width)
        }
    }
    
    
    //设置值
    func setupItem() {
        
        self.iconImageView.image = UIImage(named: menuItem.iconImageName)
        self.titleLabel.text = menuItem.title
        
        if let rightIconURL = menuItem.rightIconURL {
        
            let url = URL(string: rightIconURL)!
            self.rightImageView.kf.setImage(with: url, placeholder: nil)
        
        } else {
        
            self.rightImageView.snp.updateConstraints({ (make) in
                make.width.equalTo(0)
            })
        }
        
        self.redPointView.isHidden = !menuItem.showRightRedPoint
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
