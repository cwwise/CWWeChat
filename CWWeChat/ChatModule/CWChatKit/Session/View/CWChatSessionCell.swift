//
//  CWChatSessionCell.swift
//  CWWeChat
//
//  Created by chenwei on 2017/3/26.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class CWChatSessionCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = UITableViewCellSelectionStyle.default
        
        self.contentView.addSubview(self.headerImageView)
        self.contentView.addSubview(self.usernameLabel)
        self.contentView.addSubview(self.timeLabel)
        self.contentView.addSubview(self.detailInfoLabel)
        self.headerImageView.addSubview(self.badgeView)
        
        p_snap()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: UI
    ///计算frame
    func p_snap() {
        
        headerImageView.snp.makeConstraints { (make) in
            make.left.equalTo(ChatSessionCellUI.headerImageViewLeftPadding)
            make.top.equalTo(ChatSessionCellUI.headerImageViewTopPadding)
            make.bottom.equalTo(-ChatSessionCellUI.headerImageViewTopPadding)
            make.width.equalTo(self.headerImageView.snp.height);
        }
        
        //用户名
        usernameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.headerImageView.snp.right).offset(10)
            make.top.equalTo(self.headerImageView).offset(2.0)
            make.right.equalTo(self.timeLabel.snp.left).offset(-5)
        }
        
        //时间
        timeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(usernameLabel)
            make.right.equalTo(self.contentView).offset(-ChatSessionCellUI.headerImageViewLeftPadding)
        }
        
        //详细label
        detailInfoLabel.snp.makeConstraints { (make) in
            make.left.equalTo(usernameLabel)
            make.bottom.equalTo(headerImageView.snp.bottom).offset(-2.0)
            make.right.equalTo(self.contentView).offset(-ChatSessionCellUI.headerImageViewLeftPadding)
        }
        
        badgeView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.headerImageView.snp.right)
            make.centerY.equalTo(self.headerImageView.snp.top)
            make.width.greaterThanOrEqualTo(BadgeViewWidth)
        }
    }
    
    /// 设置数据
    func setupUI()  {
        
        //
        guard let sessionModel = self.sessionModel else {
            
            
            return
        }
        
//        let userModel = CWContactManager.findContact(conversationModel.partnerID)
//        
//        if let userModel = userModel {
//            self.headerImageView.yy_setImage(with: URL(string: userModel.avatarURL!)!, placeholder: defaultHeadeImage)
//            self.usernameLabel.text = userModel.nikeName
//        }
        
        self.timeLabel.text = sessionModel.lastMessageTime
        self.detailInfoLabel.text = sessionModel.content
        
        self.badgeView.badgeValue = sessionModel.unreadCount
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: 属性
    var sessionModel: CWChatSessionModel? {
        didSet {
            self.setupUI()
        }
    }
    
    ///头像
    fileprivate var headerImageView:UIImageView = {
        let headerImageView = UIImageView()
        return headerImageView
    }()
    
    ///用户名
    fileprivate var usernameLabel:UILabel = {
        let usernameLabel = UILabel()
        usernameLabel.font = UIFont.systemFont(ofSize: 17)
        return usernameLabel
    }()
    
    ///时间
    fileprivate var timeLabel:UILabel = {
        let timeLabel = UILabel()
        timeLabel.font = UIFont.systemFont(ofSize: 12)
        timeLabel.textColor = UIColor.darkGray
        return timeLabel
    }()
    
    ///详细信息
    fileprivate var detailInfoLabel:UILabel = {
        let detailInfoLabel = UILabel()
        detailInfoLabel.font = UIFont.systemFont(ofSize: 14)
        detailInfoLabel.textColor = UIColor.gray
        return detailInfoLabel
    }()
    
    ///badgeView
    fileprivate var badgeView:CWBadgeView = {
        let badgeView = CWBadgeView()
        badgeView.backgroundColor = UIColor.clear
        return badgeView
    }()

}
