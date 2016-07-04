//
//  CWConversationCell.swift
//  CWWeChat
//
//  Created by chenwei on 16/5/28.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit
import SnapKit

///会话cell
class CWConversationCell: UITableViewCell {

    //MARK: 属性
    var conversationModel: CWConversationModel? {
        didSet {
            self.setupUI()
        }
    }
    
    ///头像
    private var headerImageView:UIImageView = {
        let headerImageView = UIImageView()
        return headerImageView
    }()

    ///用户名
    private var usernameLabel:UILabel = {
        let usernameLabel = UILabel()
        usernameLabel.font = UIFont.systemFontOfSize(17)
        return usernameLabel
    }()
    
    ///时间
    private var timeLabel:UILabel = {
        let timeLabel = UILabel()
        timeLabel.font = UIFont.systemFontOfSize(12)
        timeLabel.textColor = UIColor.darkGrayColor()
        return timeLabel
    }()
    
    ///详细信息
    private var detailInfoLabel:UILabel = {
        let detailInfoLabel = UILabel()
        detailInfoLabel.font = UIFont.systemFontOfSize(14)
        detailInfoLabel.textColor = UIColor.grayColor()
        return detailInfoLabel
    }()
    
    ///badgeView
    private var badgeView:CWBadgeView = {
        let badgeView = CWBadgeView()
        badgeView.backgroundColor = UIColor.clearColor()
        return badgeView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = UITableViewCellSelectionStyle.Default
        
        self.contentView.addSubview(self.headerImageView)
        self.contentView.addSubview(self.usernameLabel)
        self.contentView.addSubview(self.timeLabel)
        self.contentView.addSubview(self.detailInfoLabel)
        self.headerImageView.addSubview(self.badgeView)
        
        setupViewFrame()
    }

    
    //MARK:UI
    ///计算frame
    func setupViewFrame() {
        
        headerImageView.snp_makeConstraints { (make) in
            make.left.equalTo(ChatConversationCellUI.headerImageViewLeftPadding)
            make.top.equalTo(ChatConversationCellUI.headerImageViewTopPadding)
            make.bottom.equalTo(-ChatConversationCellUI.headerImageViewTopPadding)
            make.width.equalTo(self.headerImageView.snp_height);
        }
        
        //用户名
        usernameLabel.snp_makeConstraints { (make) in
            make.left.equalTo(self.headerImageView.snp_right).offset(10)
            make.top.equalTo(self.headerImageView).offset(2.0)
            make.right.equalTo(self.timeLabel.snp_left).offset(-5)
        }
        
        //时间
        timeLabel.snp_makeConstraints { (make) in
            make.top.equalTo(usernameLabel)
            make.right.equalTo(self.contentView).offset(-ChatConversationCellUI.headerImageViewLeftPadding)
        }
        
        //详细label
        detailInfoLabel.snp_makeConstraints { (make) in
            make.left.equalTo(usernameLabel)
            make.bottom.equalTo(headerImageView.snp_bottom).offset(-2.0)
            make.right.equalTo(self.contentView).offset(-ChatConversationCellUI.headerImageViewLeftPadding)
        }
        
        badgeView.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.headerImageView.snp_right)
            make.centerY.equalTo(self.headerImageView.snp_top)
            make.width.greaterThanOrEqualTo(BadgeViewWidth)
        }
    }
    
    //MARK:最核心：设置数据
    ///设置数据
    func setupUI()  {
        
        ///解包
        guard let conversationModel = conversationModel else {
            return
        }
        
        let userModel = CWContactManager.findContact(conversationModel.partnerID)
        
        if let userModel = userModel {
            
            self.headerImageView.af_setImageWithURL(NSURL(string: userModel.avatarURL!)!, placeholderImage: defaultHeadeImage)
            self.usernameLabel.text = userModel.nikeName
        }
        
        if let date = conversationModel.conversationDate {
            self.timeLabel.text = ChatTimeTool.timeStringFromSinceDate(date)
        }
        
        self.detailInfoLabel.text = conversationModel.content
        
        self.badgeView.badgeValue = conversationModel.unreadCount
        self.badgeView.sizeToFit()
    }

    //MARK:其他
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
