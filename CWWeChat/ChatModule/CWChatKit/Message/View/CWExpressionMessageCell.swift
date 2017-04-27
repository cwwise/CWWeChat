//
//  CWExpressionMessageCell.swift
//  CWWeChat
//
//  Created by chenwei on 2017/4/20.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import YYWebImage

class CWExpressionMessageCell: CWChatMessageCell {

    lazy var expressionView: YYAnimatedImageView = {
        let expressionView = YYAnimatedImageView()
        expressionView.backgroundColor = UIColor.clear
        return expressionView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func setup() {
        super.setup()
        addGeneralView()
        self.messageContentView.addSubview(self.expressionView)
    }
    
    override func updateMessage(_ messageModel: CWChatMessageModel) {
        super.updateMessage(messageModel)
        
        expressionView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
        
//        // 消息实体
//        let message = messageModel.message
//        let body = message.messageBody as! CWExpressMessageBody
//        
//        if let path = body.localPath {
//            let url = URL(fileURLWithPath: kChatUserImagePath+path)
//            expressionView.yy_setImage(with: url, placeholder: nil, options: .progressiveBlur, completion: nil)
//        } else if let url = body.remoteURL {
//            expressionView.yy_setImage(with: url, placeholder: nil, options: .progressiveBlur, completion: nil)
//        } else {
//            expressionView.image = nil
//        }
        
        
    }
    
    override func updateState() {
        super.updateState()
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
