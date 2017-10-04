//
//  TextMessageContentView.swift
//  ChatKit
//
//  Created by chenwei on 2017/10/4.
//

import UIKit

class TextMessageContentView: MessageContentView {

    private lazy var messageLabel: UILabel = {
        let messageLabel = UILabel()
        messageLabel.numberOfLines = 0
        return messageLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(messageLabel)
    }
    
    override func refresh(message: MessageModel) {
        super.refresh(message: message)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
