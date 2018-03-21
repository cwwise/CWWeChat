//
//  CWMineUserCell.swift
//  CWWeChat
//
//  Created by chenwei on 16/5/29.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWMineUserCell: UITableViewCell {

    var userModel: CWUserModel! {
        didSet {
            self.setupUserInfomation()
        }
    }
    
    //
    private lazy var avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.cornerRadius = 5
        return avatarImageView
    }()
    
    private lazy var nikenameLabel: UILabel = {
        let nikenameLabel = UILabel()
        nikenameLabel.font = UIFont.systemFont(ofSize: 17)
        return nikenameLabel
    }()
    
    private lazy var usernameLabel: UILabel = {
        let usernameLabel = UILabel()
        usernameLabel.font = UIFont.systemFont(ofSize: 14)
        return usernameLabel
    }()
    
    private lazy var QRImageView: UIImageView = {
        let QRImageView = UIImageView()
        QRImageView.image = CWAsset.Mine_cell_myQR.image
        return QRImageView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.accessoryType = .disclosureIndicator
        self.contentView.addSubview(avatarImageView)
        self.contentView.addSubview(nikenameLabel)
        self.contentView.addSubview(usernameLabel)
        self.contentView.addSubview(QRImageView)
        
        p_addSnap()
    }
    
    func p_addSnap() {
        //头像
        avatarImageView.snp.makeConstraints { (make) in
            make.left.equalTo(14.0)
            make.top.equalTo(12.0)
            make.width.equalTo(self.avatarImageView.snp.height)
            make.centerY.equalTo(self.contentView)
        }
        
        //昵称
        nikenameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.avatarImageView.snp.right).offset(14.0)
            make.bottom.equalTo(self.avatarImageView.snp.centerY).offset(-3.5)
        }
        
        //用户名
        usernameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.nikenameLabel)
            make.top.equalTo(self.avatarImageView.snp.centerY).offset(5.0)
        }
        
        //二维码
        QRImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.contentView)
            make.width.height.equalTo(18)
            make.right.equalTo(self.contentView)
        }
        
    }
    
    func setupUserInfomation() {
        
        let nikename = userModel.nickname ?? ""
        self.avatarImageView.kf.setImage(with: userModel.avatarURL, placeholder: kDefaultHeadImage)

        nikenameLabel.text = nikename
        usernameLabel.text = userModel.username
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
