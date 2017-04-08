//
//  CWNewFriendCell.swift
//  CWWeChat
//
//  Created by chenwei on 2017/4/8.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class CWNewFriendCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(avatarImageView)
        self.contentView.addSubview(usernameLabel)
        self.contentView.addSubview(messageLabel)

        p_snap()
    }
    
    func p_snap() {
        
        avatarImageView.snp.makeConstraints { (make) in
            make.left.equalTo(ChatSessionCellUI.headerImageViewLeftPadding)
            make.top.equalTo(ChatSessionCellUI.headerImageViewTopPadding)
            make.bottom.equalTo(-ChatSessionCellUI.headerImageViewTopPadding)
            make.width.equalTo(self.avatarImageView.snp.height);
        }
        
        //用户名
        usernameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(avatarImageView.snp.right).offset(10)
            make.top.equalTo(avatarImageView).offset(2.0)
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
    
    lazy var avatarImageView:UIImageView = {
        let avatarImageView = UIImageView()
        return avatarImageView
    }()
    
    lazy var usernameLabel:UILabel = {
        let usernameLabel = UILabel()
        usernameLabel.backgroundColor = UIColor.white
        usernameLabel.font = UIFont.systemFont(ofSize: 16)
        return usernameLabel
    }()
    
    //邀请信息
    lazy var messageLabel:UILabel = {
        let messageLabel = UILabel()
        messageLabel.backgroundColor = UIColor.gray
        messageLabel.font = UIFont.systemFont(ofSize: 14)
        return messageLabel
    }()
    
    lazy var actionButton:UIButton = {
        let actionButton = UIButton(type: .custom)
        actionButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return actionButton
    }()

}
