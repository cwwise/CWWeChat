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
        
        self.contentView.addSubview(headerImageView)
        self.contentView.addSubview(usernameLabel)
        self.contentView.addSubview(timeLabel)
        self.contentView.addSubview(contentLabel)
        self.headerImageView.addSubview(badgeView)
        
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
    
    ///头像
    public var headerImageView: UIImageView = {
        let headerImageView = UIImageView()
        headerImageView.contentMode = .scaleAspectFill
        return headerImageView
    }()
    
    ///用户名
    public var usernameLabel: UILabel = {
        let usernameLabel = UILabel()
        usernameLabel.font = UIFont.systemFont(ofSize: 17)
        return usernameLabel
    }()
    
    ///时间
    public var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.font = UIFont.systemFont(ofSize: 12)
        timeLabel.textColor = UIColor.darkGray
        return timeLabel
    }()
    
    ///详细信息
    public var contentLabel: UILabel = {
        let contentLabel = UILabel()
        contentLabel.font = UIFont.systemFont(ofSize: 14)
        contentLabel.textColor = UIColor.gray
        return contentLabel
    }()
    
    ///badgeView
    public var badgeView: BadgeView = {
        let badgeView = BadgeView()
        badgeView.backgroundColor = UIColor.clear
        return badgeView
    }()
    
}
