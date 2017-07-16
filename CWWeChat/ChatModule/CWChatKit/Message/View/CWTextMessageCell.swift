//
//  CWTextMessageCell.swift
//  CWWeChat
//
//  Created by wei chen on 2017/3/31.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import YYText

class CWTextMessageCell: CWMessageCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func setup() {
        super.setup()
        self.addGeneralView()
        self.messageContentView.addSubview(self.backgroundImageView)
        self.messageContentView.addSubview(self.messageLabel)
    }
    
    override func updateMessage(_ messageModel: CWChatMessageModel) {
        super.updateMessage(messageModel)
        
        // 消息实体
        let message = messageModel.message
        backgroundImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
        // 是自己的发送的消息
        if message.direction == .send {
            let edge = ChatCellUI.right_edge_insets
            messageLabel.snp.makeConstraints { (make) in
                make.edges.equalTo(edge)
            }
        } else {
            let edge = ChatCellUI.left_edge_insets
            messageLabel.snp.makeConstraints { (make) in
                make.edges.equalTo(edge)
            }
        }
        messageLabel.textLayout = messageModel.messageFrame.textLayout
    }
    
    // YYText点击事件
    func didTapMessageLabelText(_ text: NSAttributedString, range: NSRange) {
        
        guard let hightlight = text.yy_attribute(YYTextHighlightAttributeName, at: UInt(range.location)) as? YYTextHighlight else {
            return
        }
        
        guard let info = hightlight.userInfo, info.count > 0, 
            let delegate = self.delegate else {
            return
        }
        
        if let phone = info[kChatTextKeyPhone] as? String {
            delegate.messageCellDidTapPhone(self, phone: phone)
        }
        else if let URLString = info[kChatTextKeyURL] as? String, let URL = URL(string: URLString) {
            delegate.messageCellDidTapLink(self, link: URL)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // 展示文本
    fileprivate lazy var messageLabel: YYLabel = {
        let messageLabel = YYLabel()
        messageLabel.font = UIFont.fontTextMessageText()
        messageLabel.displaysAsynchronously = false
        messageLabel.ignoreCommonProperties = true
        messageLabel.highlightTapAction = ({[weak self] containerView, text, range, rect in
            guard let strongSelf = self else { return }
            strongSelf.didTapMessageLabelText(text, range: range)
        })
        messageLabel.numberOfLines = 0
        return messageLabel
    }()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
