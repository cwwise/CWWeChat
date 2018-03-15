//
//  TimeMessageHeaderView.swift
//  ChatKit
//
//  Created by wei chen on 2017/10/24.
//

import UIKit

private let kChatTimeLabelMarginTop: CGFloat = 5   //顶部 10 px

class TimeMessageHeaderView: UICollectionReusableView {
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(timeLabel)
    }
    
    public override func layoutSubviews() {
        timeLabel.sizeToFit()
        
        let size = timeLabel.bounds.size
        let x = self.bounds.width - timeLabel.bounds.width + 2*6.0
        let frame = CGRect(x: x/2, y: kChatTimeLabelMarginTop, width: timeLabel.bounds.width + 2*6.0, height: 18)
        self.timeLabel.frame = frame
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
}
