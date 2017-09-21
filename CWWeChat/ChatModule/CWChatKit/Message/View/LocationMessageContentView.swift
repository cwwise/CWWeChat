//
//  LocationMessageContentView.swift
//  CWWeChat
//
//  Created by chenwei on 2017/9/15.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import UIKit

class LocationMessageContentView: MessageContentView {

    ///用来分割
    lazy var maskLayer: CAShapeLayer = {
        let maskLayer = CAShapeLayer()
        maskLayer.contentsCenter = CGRect(x: 0.5, y: 0.6, width: 0.1, height: 0.1)
        maskLayer.contentsScale = UIScreen.main.scale
        return maskLayer
    }()
    
    lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = UIColor.white
        return containerView
    }()
    
    // 地址
    fileprivate var addressLabel: UILabel = {
        let addressLabel = UILabel()
        addressLabel.font = UIFont.fontTextMessageText()
        addressLabel.numberOfLines = 1
        addressLabel.textColor = UIColor.black
        return addressLabel
    }()
    
    // 详细地址
    fileprivate var detailLabel: UILabel = {
        let detailLabel = UILabel()
        detailLabel.font = UIFont.systemFont(ofSize: 12)
        detailLabel.numberOfLines = 0
        detailLabel.textColor = UIColor.gray
        return detailLabel
    }()
    
    // 详细地址
    fileprivate var mapImageView: UIImageView = {
        let mapImageView = UIImageView()
        return mapImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let image = #imageLiteral(resourceName: "receiver_background_normal")
        let _ = #imageLiteral(resourceName: "receiver_background_highlight")
        
        let cap = ChatCellUI.left_cap_insets
        bubbleImageView.image = image.resizableImage(withCapInsets: cap)
        
        self.addSubview(containerView)
        containerView.layer.mask = self.maskLayer

        self.addSubview(addressLabel)
        self.addSubview(detailLabel)
        self.addSubview(mapImageView)
    }
    
    override func refresh(message: CWMessageModel) {
        super.refresh(message: message)

        if message.isSend {
            let image = #imageLiteral(resourceName: "SenderAppNodeBkg")
            let cap = ChatCellUI.right_cap_insets
            bubbleImageView.image = image.resizableImage(withCapInsets: cap)            
        } else {
            let image = #imageLiteral(resourceName: "ReceiverAppNodeBkg")
            let cap = ChatCellUI.left_cap_insets
            bubbleImageView.image = image.resizableImage(withCapInsets: cap)
        }
        
        self.maskLayer.contents = self.bubbleImageView.image?.cgImage
        let body = message.messageBody as! CWLocationMessageBody
        addressLabel.text = body.address
        detailLabel.text = body.detail
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.frame = self.bounds
        addressLabel.frame = CGRect(x: 15, y: 10, width: self.bounds.width-2*10, height: 18)
        detailLabel.frame = CGRect(x: 15, y: 32, width: self.bounds.width-2*10, height: 10)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
