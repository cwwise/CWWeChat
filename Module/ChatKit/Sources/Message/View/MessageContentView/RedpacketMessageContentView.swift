//
//  RedpacketMessageContentView.swift
//  ChatKit
//
//  Created by chenwei on 2018/3/21.
//

import UIKit

// frame: 190*80
class RedpacketMessageContentView: MessageContentView {
    
    var iconImageView: UIImageView = {
        let frame = CGRect(x: 8, y: 15, width: 36, height: 36)
        let iconImageView = UIImageView(frame: frame)
        iconImageView.image = #imageLiteral(resourceName: "chat_redpackek_icon")
        return iconImageView
    }()
    
    /// 内容
    var contentLabel: UILabel = {
        let contentLabel = UILabel()
        contentLabel.textColor = UIColor.white
        contentLabel.font = UIFont.systemFont(ofSize: 15)
        return contentLabel
    }()
    
    /// 提示文字
    var tipLabel: UILabel = {
        let tipLabel = UILabel()
        tipLabel.text = "领取红包"
        tipLabel.textColor = UIColor.white
        tipLabel.font = UIFont.systemFont(ofSize: 13)
        return tipLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(iconImageView)
        self.addSubview(contentLabel)
        self.addSubview(tipLabel)
        
        contentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconImageView.snp.right).offset(7)
            make.right.equalTo(-15)
            make.top.equalTo(14)
        }
        
        tipLabel.snp.makeConstraints { (make) in
            make.left.equalTo(contentLabel)
            make.top.equalTo(contentLabel.snp.bottom).offset(5)
            make.right.equalTo(contentLabel)
        }
        
        self.menuItems = [MenuAction.deleteItem]
    }
    
    override func refresh(message: MessageModel) {
        self.message = message
        bubbleImageView.image = #imageLiteral(resourceName: "chat_redpackek_content")
        
        contentLabel.text = "恭喜发财，大吉大利"
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
