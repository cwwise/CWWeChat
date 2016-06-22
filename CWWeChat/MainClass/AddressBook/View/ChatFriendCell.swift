//
//  ChatFriendCell.swift
//  CWChat
//
//  Created by chenwei on 16/4/11.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit
import SnapKit
import AlamofireImage

let  FRIENDS_SPACE_X:CGFloat     =    10.0
let  FRIENDS_SPACE_Y:CGFloat     =    9.0

class ChatFriendCell: UITableViewCell {
    
    ///用户model
    var userModel:CWChatUserModel? {
        didSet {
            self.setupUI()
        }
    }
    
    lazy var avatarImageView:UIImageView = {
        let avatarImageView = UIImageView()
        return avatarImageView
    }()
    
    lazy var usernameLabel:UILabel = {
        let usernameLabel = UILabel()
        usernameLabel.font = UIFont.systemFontOfSize(15)
        return usernameLabel
    }()
    
    lazy var subTitleLabel:UILabel = {
        let subTitleLabel = UILabel()
        subTitleLabel.font = UIFont.systemFontOfSize(14.0)
        subTitleLabel.textColor = UIColor.grayColor()
        subTitleLabel.hidden = true
        return subTitleLabel
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.contentView.addSubview(avatarImageView)
        self.contentView.addSubview(usernameLabel)
        self.contentView.addSubview(subTitleLabel)
        addSnap()
    }
    
    func addSnap() {
        avatarImageView.snp_makeConstraints { (make) in
            make.left.equalTo(FRIENDS_SPACE_X)
            make.top.equalTo(FRIENDS_SPACE_Y)
            make.bottom.equalTo(-FRIENDS_SPACE_Y-0.5)
            make.width.equalTo(avatarImageView.snp_height);
        }
        
        usernameLabel.snp_makeConstraints { (make) in
            make.left.equalTo(avatarImageView.snp_right).offset(FRIENDS_SPACE_X)
            make.centerY.equalTo(avatarImageView)
            make.right.equalTo(self.contentView).offset(FRIENDS_SPACE_X).offset(-20)
        }
    }
    
    ///设置UI
    func setupUI() {
        
        guard let userModel = userModel else {
            return
        }
        
        if (userModel.avatarPath != nil) {
            self.avatarImageView.image = UIImage(named: userModel.avatarPath!)
        } else {
            self.avatarImageView.af_setImageWithURL(NSURL(string: userModel.avatarURL)!)
        }
        self.usernameLabel.text = userModel.nikeName;
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}