//
//  ConversationCell.swift
//  Pods
//
//  Created by chenwei on 2017/10/3.
//

import UIKit
import SnapKit

public class ConversationCell: UITableViewCell {

    override public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .default
        
        self.contentView.addSubview(self.headerImageView)
        self.contentView.addSubview(self.usernameLabel)
        self.contentView.addSubview(self.timeLabel)
        self.contentView.addSubview(self.contentLabel)
        self.headerImageView.addSubview(self.badgeView)
        
        p_snap()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: UI
    func p_snap() {
        
        let leftMargin = 10.0
        let topMargin = 10.0
        
        headerImageView.snp.makeConstraints { (make) in
            make.left.equalTo(leftMargin)
            make.top.equalTo(topMargin)
            make.bottom.equalTo(-topMargin)
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
            make.right.equalTo(self.contentView).offset(-leftMargin)
        }
        
        //详细label
        contentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(usernameLabel)
            make.bottom.equalTo(headerImageView.snp.bottom).offset(-2.0)
            make.right.equalTo(self.contentView).offset(-leftMargin)
        }
    }

    /// 设置数据
    func setupUI()  {
        
        guard let model = conversationModel else {
            return 
        }
        
        // 是单聊
        if model.type == .single {
            
            if let user = ChatKit.share.fetchUser(userId: model.conversationId) {
                self.usernameLabel.text = user.nickname
            } else {
                self.usernameLabel.text = "单聊"
            }
            self.headerImageView.image = ChatAsset.defaultHeadImage.image
        } else {
            
            if let group = ChatKit.share.fetchGroup(groupId: model.conversationId){
                self.usernameLabel.text = group.name
            } else {
                self.usernameLabel.text = "群聊"
            }
//            self.headerImageView.image = ChatAsset.defaultHeadImage.image

        }
        
        
        self.timeLabel.text = model.lastMessageTime
        self.contentLabel.text = model.conversationTitle
        self.badgeView.badgeValue = model.unreadCount
    }
    
    //MARK: 属性
    var conversationModel: ConversationModel? {
        didSet {
            self.setupUI()
        }
    }
    
    ///头像
    private var headerImageView:UIImageView = {
        let headerImageView = UIImageView()
        headerImageView.contentMode = .scaleAspectFill
        return headerImageView
    }()
    
    ///用户名
    private var usernameLabel:UILabel = {
        let usernameLabel = UILabel()
        usernameLabel.font = UIFont.systemFont(ofSize: 17)
        return usernameLabel
    }()
    
    ///时间
    private var timeLabel:UILabel = {
        let timeLabel = UILabel()
        timeLabel.font = UIFont.systemFont(ofSize: 12)
        timeLabel.textColor = UIColor.darkGray
        return timeLabel
    }()
    
    ///详细信息
    private var contentLabel:UILabel = {
        let contentLabel = UILabel()
        contentLabel.font = UIFont.systemFont(ofSize: 14)
        contentLabel.textColor = UIColor.gray
        return contentLabel
    }()
    
    ///badgeView
    private var badgeView: BadgeView = {
        let badgeView = BadgeView()
        badgeView.backgroundColor = UIColor.clear
        return badgeView
    }()
    
}
