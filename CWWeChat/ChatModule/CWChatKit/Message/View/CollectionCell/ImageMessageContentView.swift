//
//  ImageMessageContentView.swift
//  CWWeChat
//
//  Created by chenwei on 2017/9/8.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import UIKit

class ImageMessageContentView: MessageContentView {

    lazy var messageImageView: CWChatImageView = {
        let messageImageView = CWChatImageView()
        messageImageView.backgroundColor = UIColor.gray
        return messageImageView
    }()
    
    ///用来分割
    lazy var maskLayer: CAShapeLayer = {
        let maskLayer = CAShapeLayer()
        maskLayer.contentsCenter = CGRect(x: 0.5, y: 0.6, width: 0.1, height: 0.1)
        maskLayer.contentsScale = UIScreen.main.scale
        return maskLayer
    }()
    
    

}
