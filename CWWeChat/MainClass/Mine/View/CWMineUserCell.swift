//
//  CWMineUserCell.swift
//  CWWeChat
//
//  Created by chenwei on 16/5/29.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

let MINE_SPACE_X: CGFloat  =  14.0
let MINE_SPACE_Y: CGFloat  =  12.0

class CWMineUserCell: UITableViewCell {

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
    
    private lazy var nikenameLabel:UILabel = {
        let nikenameLabel = UILabel()
        nikenameLabel.font = UIFont.systemFontOfSize(17)
        return nikenameLabel
    }()
    
    private lazy var usernameLabel:UILabel = {
        let usernameLabel = UILabel()
        usernameLabel.font = UIFont.systemFontOfSize(14)
        return usernameLabel
    }()
    
    private lazy var QRImageView:UIImageView = {
        let QRImageView = UIImageView()
        QRImageView.image = CWAsset.Mine_cell_myQR.image
        return QRImageView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.accessoryType = .DisclosureIndicator
        self.contentView.addSubview(avatarImageView)
        self.contentView.addSubview(nikenameLabel)
        self.contentView.addSubview(usernameLabel)
        self.contentView.addSubview(QRImageView)
        
        p_addSnap()
    }
    
    //MARK: 添加约束
    func p_addSnap() {
        //头像
        avatarImageView.snp_makeConstraints { (make) in
            make.left.equalTo(MINE_SPACE_X)
            make.top.equalTo(MINE_SPACE_Y)
            make.width.equalTo(self.avatarImageView.snp_height)
            make.centerY.equalTo(self.contentView)
        }
        
        //昵称
        nikenameLabel.snp_makeConstraints { (make) in
            make.left.equalTo(self.avatarImageView.snp_right).offset(MINE_SPACE_Y)
            make.bottom.equalTo(self.avatarImageView.snp_centerY).offset(-3.5)
        }
        
        //用户名
        usernameLabel.snp_makeConstraints { (make) in
            make.left.equalTo(self.nikenameLabel)
            make.top.equalTo(self.avatarImageView.snp_centerY).offset(5.0)
        }
        
        //二维码
        QRImageView.snp_makeConstraints { (make) in
            make.centerY.equalTo(self.contentView)
            make.width.height.equalTo(18)
            make.right.equalTo(self.contentView)
        }
        
    }
    
    func setupUserInfomation() {
        
        guard let userModel = userModel else {
            return
        }
    
        let url = NSURL(string: userModel.avatarURL!)!
        self.avatarImageView.af_setImageWithURL(url)

        nikenameLabel.text = userModel.nikeName
        if let userName = userModel.userName {
            usernameLabel.text = "微信号:"+userName
        } else {
            usernameLabel.text = ""
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
