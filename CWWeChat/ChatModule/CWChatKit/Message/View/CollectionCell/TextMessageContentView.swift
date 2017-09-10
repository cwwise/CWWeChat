//
//  CWTextMessageContentView.swift
//  CWWeChat
//
//  Created by chenwei on 2017/9/8.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import UIKit
import YYText

class TextMessageContentView: MessageContentView {
    // 文本
    private lazy var messageLabel: YYLabel = {
        let messageLabel = YYLabel()
        messageLabel.displaysAsynchronously = false
        messageLabel.ignoreCommonProperties = true
        messageLabel.highlightTapAction = ({[weak self] containerView, text, range, rect in
            guard let strongSelf = self else { return }
            strongSelf.didTapMessageLabelText(text, range: range)
        })
        messageLabel.numberOfLines = 0
        return messageLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(messageLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func refresh(message: CWMessageModel) {
        super.refresh(message: message)
        messageLabel.textLayout = message.textLayout
        
        // 是自己的发送的消息
        if message.isSend == true {
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
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let message = message else {
            messageLabel.frame = self.bounds
            return
        }
        
        
        
        
          
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
          //  delegate.messageCellDidTapPhone(self, phone: phone)
        }
        else if let URLString = info[kChatTextKeyURL] as? String, let URL = URL(string: URLString) {
          //  delegate.messageCellDidTapLink(self, link: URL)
        }
    }
    
    
    // 配置menuAction
    
    
    
}
