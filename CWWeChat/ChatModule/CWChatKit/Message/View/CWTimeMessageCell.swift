//
//  CWTimeMessageCell.swift
//  CWWeChat
//
//  Created by wei chen on 2017/4/3.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

private let kChatTimeLabelMarginTop: CGFloat = 5   //顶部 10 px

public class CWTimeMessageCell: UITableViewCell {
    
    public lazy var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.font = UIFont.systemFont(ofSize: 12)
        timeLabel.layer.cornerRadius = 4
        timeLabel.textAlignment = .center
        timeLabel.layer.masksToBounds = true
        timeLabel.textColor = UIColor.white
        timeLabel.backgroundColor = UIColor.gray
        timeLabel.alpha = 0.5
        return timeLabel
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.timeLabel)
        self.backgroundColor = UIColor.clear
    }
    
    public override func layoutSubviews() {
        timeLabel.sizeToFit()
        timeLabel.size = CGSize(width: timeLabel.width + 2*6.0, height: 18)
        timeLabel.centerX = kScreenWidth/2
        timeLabel.top = kChatTimeLabelMarginTop
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
