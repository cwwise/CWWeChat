//
//  CWChatTextMessageCell.swift
//  CWWeChat
//
//  Created by chenwei on 2017/9/7.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import UIKit
import YYText

class CWChatTextMessageCell: CWBaseMessageCell {
    
    // 文本
    fileprivate lazy var messageLabel: YYLabel = {
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
    
    override func refresh(message: CWMessageModel) {
        super.refresh(message: message)
        messageLabel.textLayout = message.textLayout
        messageLabel.frame = self.messageContentView.bounds
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
    

}
