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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        messageImageView.layer.mask = self.maskLayer
        self.addSubview(messageImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func refresh(message: CWMessageModel) {
        super.refresh(message: message)
        
        self.maskLayer.contents = self.bubbleImageView.image?.cgImage

        // 消息实体
        let body = message.messageBody as! CWImageMessageBody
        
        // 如果图片是自己发送，图片正在上传过程中是没有URL的，所以是用本地路径的图片。
        if let url = body.originalURL {
            messageImageView.kf.setImage(with: url, placeholder: nil)
        }
        else if let path = body.originalLocalPath {
            let url = URL(fileURLWithPath: path)
            messageImageView.kf.setImage(with: url, placeholder: nil)
        } else  {
            messageImageView.image = nil
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let _ = message else {
            return
        }
        

        maskLayer.frame = self.bounds
        messageImageView.frame = self.bounds
        
    }

}
