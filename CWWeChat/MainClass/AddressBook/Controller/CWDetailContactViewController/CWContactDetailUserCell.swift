//
//  CWContactDetailUserCell.swift
//  CWWeChat
//
//  Created by chenwei on 16/7/6.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWContactDetailUserCell: UITableViewCell {
    
    let mine_space_x: CGFloat  =  14.0
    let mine_space_y: CGFloat  =  12.0
    
    var userModel: CWContactUser? {
        didSet {
            self.setupUserInfomation()
        }
    }
    
    //
    private lazy var avatarImageView:UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.cornerRadius = 5
        return avatarImageView
    }()
    
    /// 用户名
    private lazy var usernameLabel:UILabel = {
        let usernameLabel = UILabel()
        usernameLabel.font = UIFont.systemFontOfSize(17)
        return usernameLabel
    }()
    
    /// 微信号
    private lazy var wxnameLabel:UILabel = {
        let wxnameLabel = UILabel()
        wxnameLabel.font = UIFont.systemFontOfSize(14)
        wxnameLabel.textColor = UIColor.grayColor()
        return wxnameLabel
    }()
    
    /// 昵称
    private lazy var nikenameLabel:UILabel = {
        let nikenameLabel = UILabel()
        nikenameLabel.font = UIFont.systemFontOfSize(14)
        nikenameLabel.textColor = UIColor.grayColor()
        return nikenameLabel
    }()
    
 
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.accessoryType = .None
        self.selectionStyle = .None
        
        self.contentView.addSubview(avatarImageView)
        self.contentView.addSubview(usernameLabel)
        self.contentView.addSubview(wxnameLabel)
        self.contentView.addSubview(nikenameLabel)
        p_addSnap()
    }
    
    //MARK: 添加约束
    func p_addSnap() {
        //头像
        avatarImageView.snp_makeConstraints { (make) in
            make.left.equalTo(mine_space_x)
            make.top.equalTo(mine_space_y)
            make.width.equalTo(self.avatarImageView.snp_height)
            make.centerY.equalTo(self.contentView)
        }
        
        //用户名
        usernameLabel.snp_makeConstraints { (make) in
            make.top.equalTo(self.avatarImageView.snp_top).offset(3.0)
            make.left.equalTo(self.avatarImageView.snp_right).offset(mine_space_y)
        }
        
        //用户名
        wxnameLabel.snp_makeConstraints { (make) in
            make.left.equalTo(self.usernameLabel)
            make.top.equalTo(self.usernameLabel.snp_bottom).offset(5.0)
        }
        
        //昵称
        nikenameLabel.snp_makeConstraints { (make) in
            make.left.equalTo(self.usernameLabel)
            make.top.equalTo(self.wxnameLabel.snp_bottom).offset(3.0)
        }
    }
    
    func setupUserInfomation() {
        
        guard let userModel = userModel else {
            return
        }
        
        let url = NSURL(string: userModel.avatarURL!)!
        self.avatarImageView.af_setImageWithURL(url)
        
        usernameLabel.text = userModel.userName
        if let userName = userModel.userName {
            wxnameLabel.text = "微信号:"+userName
        } else {
            wxnameLabel.text = ""
        }
        
        if let nikeName = userModel.nikeName {
            nikenameLabel.text = "昵称:"+nikeName
        } else {
            nikenameLabel.text = "昵称:"+""
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
