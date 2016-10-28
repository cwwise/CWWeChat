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
    fileprivate lazy var avatarImageView:UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.cornerRadius = 5
        return avatarImageView
    }()
    
    /// 用户名
    fileprivate lazy var usernameLabel:UILabel = {
        let usernameLabel = UILabel()
        usernameLabel.font = UIFont.systemFont(ofSize: 17)
        return usernameLabel
    }()
    
    /// 微信号
    fileprivate lazy var wxnameLabel:UILabel = {
        let wxnameLabel = UILabel()
        wxnameLabel.font = UIFont.systemFont(ofSize: 14)
        wxnameLabel.textColor = UIColor.gray
        return wxnameLabel
    }()
    
    /// 昵称
    fileprivate lazy var nikenameLabel:UILabel = {
        let nikenameLabel = UILabel()
        nikenameLabel.font = UIFont.systemFont(ofSize: 14)
        nikenameLabel.textColor = UIColor.gray
        return nikenameLabel
    }()
    
 
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.accessoryType = .none
        self.selectionStyle = .none
        
        self.contentView.addSubview(avatarImageView)
        self.contentView.addSubview(usernameLabel)
        self.contentView.addSubview(wxnameLabel)
        self.contentView.addSubview(nikenameLabel)
        p_addSnap()
    }
    
    //MARK: 添加约束
    func p_addSnap() {
        //头像
        avatarImageView.snp.makeConstraints { (make) in
            make.left.equalTo(mine_space_x)
            make.top.equalTo(mine_space_y)
            make.width.equalTo(self.avatarImageView.snp.height)
            make.centerY.equalTo(self.contentView)
        }
        
        //用户名
        usernameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.avatarImageView.snp.top).offset(3.0)
            make.left.equalTo(self.avatarImageView.snp.right).offset(mine_space_y)
        }
        
        //用户名
        wxnameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.usernameLabel)
            make.top.equalTo(self.usernameLabel.snp.bottom).offset(5.0)
        }
        
        //昵称
        nikenameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.usernameLabel)
            make.top.equalTo(self.wxnameLabel.snp.bottom).offset(3.0)
        }
    }
    
    func setupUserInfomation() {
        
        guard let userModel = userModel else {
            return
        }
        
        let url = URL(string: userModel.avatarURL!)!
        self.avatarImageView.yy_setImageWithURL(url, placeholder: nil)
        
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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
