//
//  CWImageMessageCell.swift
//  CWWeChat
//
//  Created by chenwei on 2017/4/4.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class CWImageMessageCell: CWMessageCell {

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
    

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func setup() {
        super.setup()
        self.addGeneralView()
        
        self.messageContentView.layer.mask = self.maskLayer
        self.messageContentView.addSubview(self.messageImageView)
        
        self.messageContentView.addGestureRecognizer(tapGestureRecognizer)
        self.tapGestureRecognizer.require(toFail: doubletapGesture)
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
        
        // 如果图片是自己发送，图片正在上传过程中是没有URL的，所以是用本地路径的图片。
        if let url = body.originalURL {
            messageImageView.kf.setImage(with: url, placeholder: nil)
        }
        else if let path = body.originalLocalPath {
            let url = URL(fileURLWithPath: kChatUserImagePath+path)
            messageImageView.kf.setImage(with: url, placeholder: nil)
        } else  {
            messageImageView.image = nil
        }

    }
    
    override func updateState() {
        // 消息实体
        let message = messageModel.message
        
        if message.sendStatus == .failed {
            errorButton.isHidden = false
        } else if message.sendStatus == .successed {
            errorButton.isHidden = true
        } else {
            errorButton.isHidden = true
        }
        
    }
    
    override func updateProgress() {
        
        if messageModel.isSend == false {
            messageImageView.hideProgressView()
            return
        }
        
        if messageModel.message.sendStatus == .failed ||
           messageModel.message.sendStatus == .successed{
            messageImageView.hideProgressView()
        } else {
            let progress = Int(messageModel.uploadProgress * 100)
            messageImageView.showProgress(progress)
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
