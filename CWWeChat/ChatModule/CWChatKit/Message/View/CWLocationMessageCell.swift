//
//  CWLocationMessageCell.swift
//  CWWeChat
//
//  Created by chenwei on 2017/4/11.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class CWLocationMessageCell: CWChatMessageCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
        
    override func setup() {
        super.setup()
        addGeneralView()
        
        self.messageContentView.addSubview(backgroundImageView)
        self.messageContentView.addSubview(addressLabel)
        self.messageContentView.addSubview(detailLabel)
        self.messageContentView.addSubview(mapImageView)
    }
    
    override func updateMessage(_ messageModel: CWChatMessageModel) {
        super.updateMessage(messageModel)
        
        backgroundImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
    
        // 消息实体
        let _ = messageModel.message
        
        
        
    }
    
    // 地址
    fileprivate var addressLabel: UILabel = {
        let addressLabel = UILabel()
        addressLabel.font = UIFont.fontTextMessageText()
        addressLabel.numberOfLines = 0
        addressLabel.backgroundColor = UIColor.orange
        return addressLabel
    }()
    
    // 详细地址
    fileprivate var detailLabel: UILabel = {
        let detailLabel = UILabel()
        detailLabel.font = UIFont.fontTextMessageText()
        detailLabel.numberOfLines = 0
        detailLabel.backgroundColor = UIColor.orange
        return detailLabel
    }()
    
    // 详细地址
    fileprivate var mapImageView: UIImageView = {
        let mapImageView = UIImageView()
        return mapImageView
    }()
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
