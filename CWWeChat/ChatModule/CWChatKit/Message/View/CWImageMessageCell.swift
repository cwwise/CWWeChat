//
//  CWImageMessageCell.swift
//  CWWeChat
//
//  Created by chenwei on 2017/4/4.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class CWImageMessageCell: CWChatMessageCell {

    lazy var messageImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func setup() {
        super.setup()
        addGeneralView()
        self.messageContentView.addSubview(self.messageImageView)
    }
    
    override func updateMessage(_ messageModel: CWChatMessageModel) {
        super.updateMessage(messageModel)
        
        // 消息实体
        let message = messageModel.message
        
        let body = message.messageBody as! CWImageMessageBody
        if let url = body.originalURL {
            messageImageView.yy_setImage(with: url, placeholder: nil)
        } else {
            let url = URL(fileURLWithPath: body.originalLocalPath!)
            messageImageView.yy_imageURL = url
        }
        
        messageImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
