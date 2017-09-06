//
//  CWMessageTextContent.swift
//  CWWeChat
//
//  Created by wei chen on 2017/7/14.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import YYText

class CWMessageTextContent: CWMessageContentView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(messageLabel)
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
//            delegate.messageCellDidTapPhone(self, phone: phone)
        }
        else if let URLString = info[kChatTextKeyURL] as? String, let URL = URL(string: URLString) {
//            delegate.messageCellDidTapLink(self, link: URL)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
}
