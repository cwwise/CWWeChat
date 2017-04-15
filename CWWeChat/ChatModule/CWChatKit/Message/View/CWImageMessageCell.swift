//
//  CWImageMessageCell.swift
//  CWWeChat
//
//  Created by chenwei on 2017/4/4.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class CWImageMessageCell: CWChatMessageCell {

    lazy var messageImageView: CWChatImageView = {
        let messageImageView = CWChatImageView()
        return messageImageView
    }()
    
    ///用来分割
    lazy var maskLayer: CAShapeLayer = {
        let maskLayer = CAShapeLayer()
        maskLayer.contentsCenter = CGRect(x: 0.5, y: 0.6, width: 0.1, height: 0.1)
        maskLayer.contentsScale = UIScreen.main.scale
        return maskLayer
    }()
    

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func setup() {
        super.setup()
        addGeneralView()
        
        self.messageContentView.layer.mask = self.maskLayer
        self.messageContentView.addSubview(self.messageImageView)
    }
    
    override func updateMessage(_ messageModel: CWChatMessageModel) {
        super.updateMessage(messageModel)
    
        self.maskLayer.contents = self.backgroundImageView.image?.cgImage
        self.maskLayer.frame = CGRect(origin: .zero, size: messageModel.messageFrame.contentSize)
    
        messageImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
        
        // 消息实体
        let message = messageModel.message
        let body = message.messageBody as! CWImageMessageBody
        
        if let path = body.originalLocalPath {
            let url = URL(fileURLWithPath: kChatUserImagePath+path)
            messageImageView.yy_setImage(with: url, placeholder: nil, options: .progressiveBlur, completion: nil)
        } else if let url = body.originalURL {
            messageImageView.yy_setImage(with: url, placeholder: nil, options: .progressiveBlur, completion: nil)
        } else {
            messageImageView.image = nil
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
