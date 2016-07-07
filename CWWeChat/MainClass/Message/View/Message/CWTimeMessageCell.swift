//
//  CWTimeMessageCell.swift
//  CWWeChat
//
//  Created by chenwei on 16/7/6.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWTimeMessageCell: UITableViewCell {

    var message:CWMessageModel?
    
    private let kChatTimeLabelMaxWdith : CGFloat = Screen_Width - 30*2
    private let kChatTimeLabelMarginTop: CGFloat = 10   //顶部 10 px
    
    lazy var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.font = UIFont.systemFontOfSize(12)
        timeLabel.layer.cornerRadius = 4
        timeLabel.textAlignment = .Center
        timeLabel.layer.masksToBounds = true
        timeLabel.textColor = UIColor.whiteColor()
        timeLabel.backgroundColor = UIColor.grayColor()
        timeLabel.alpha = 0.5
        return timeLabel
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.timeLabel)
        self.backgroundColor = UIColor.clearColor()
        self.timeLabel.snp_makeConstraints { (make) in
            make.height.equalTo(20)
            make.centerX.equalTo(self.contentView)
            make.top.equalTo(self.contentView).offset(kChatTimeLabelMarginTop)
        }
    }
    
    func updateMessage(message: CWMessageModel) {
        self.message = message
        self.timeLabel.text = message.content
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
