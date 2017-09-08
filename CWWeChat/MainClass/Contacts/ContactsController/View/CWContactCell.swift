//
//  CWContactCell.swift
//  CWWeChat
//
//  Created by wei chen on 2017/4/3.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

private let kContactCellLeftMargin:CGFloat     =    10.0
private let kContactCellTopMargin:CGFloat     =    9.0

let kHeight_ContactCell: CGFloat = 54

class CWContactCell: UITableViewCell {
    
    ///用户model
    var contactModel: CWUserModel! {
        didSet {
            self.setupUI()
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(avatarImageView)
        self.contentView.addSubview(usernameLabel)
        add_snap()
    }
    
    func add_snap() {
        avatarImageView.snp.makeConstraints { (make) in
            make.left.equalTo(kContactCellLeftMargin)
            make.top.equalTo(kContactCellTopMargin)
            make.centerY.equalTo(self.contentView)
            make.width.equalTo(avatarImageView.snp.height);
        }
        
        usernameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(avatarImageView.snp.right).offset(kContactCellLeftMargin)
            make.centerY.equalTo(avatarImageView)
            make.right.equalTo(self.contentView).offset(kContactCellLeftMargin).offset(-20)
        }
    }
    
    ///设置UI
    func setupUI() {
        // 待修改
        if let avatarImage = contactModel.avatarImage {
            self.avatarImageView.image = avatarImage
        } else {
            self.avatarImageView.kf.setImage(with: contactModel.avatarURL, placeholder: defaultHeadeImage) 
        }
        self.usernameLabel.text = contactModel.nickname;
    }
    
    lazy var avatarImageView:UIImageView = {
        let avatarImageView = UIImageView()
        return avatarImageView
    }()
    
    lazy var usernameLabel:UILabel = {
        let usernameLabel = UILabel()
        usernameLabel.backgroundColor = UIColor.white
        usernameLabel.font = UIFont.systemFont(ofSize: 15)
        return usernameLabel
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
