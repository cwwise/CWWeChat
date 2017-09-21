//
//  EmoticonMessageContentView.swift
//  CWWeChat
//
//  Created by wei chen on 2017/9/17.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import UIKit
import Kingfisher

class EmoticonMessageContentView: MessageContentView {

    lazy var emoticonView: AnimatedImageView = {
        let emoticonView = AnimatedImageView()
        emoticonView.backgroundColor = UIColor.clear
        emoticonView.contentMode = .scaleAspectFit
        return emoticonView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.bubbleImageView.isHidden = true
        addSubview(emoticonView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func refresh(message: CWMessageModel) {
        super.refresh(message: message)
        
        let emoticonBody = message.messageBody as! CWEmoticonMessageBody
        if let url = emoticonBody.originalURL {
            emoticonView.kf.setImage(with: url)
        } else if let path = emoticonBody.originalLocalPath {
            let url = URL(fileURLWithPath: path)
            emoticonView.kf.setImage(with: url)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        emoticonView.frame = self.bounds
    }
}
