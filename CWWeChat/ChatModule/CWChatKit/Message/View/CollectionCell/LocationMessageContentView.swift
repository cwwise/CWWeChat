//
//  LocationMessageContentView.swift
//  CWWeChat
//
//  Created by chenwei on 2017/9/15.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import UIKit

class LocationMessageContentView: MessageContentView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(addressLabel)
        self.addSubview(detailLabel)
        self.addSubview(mapImageView)
    }
    
    override func refresh(message: CWMessageModel) {

        
    }
    
    // 地址
    fileprivate var addressLabel: UILabel = {
        let addressLabel = UILabel()
        addressLabel.font = UIFont.fontTextMessageText()
        addressLabel.numberOfLines = 0
        addressLabel.backgroundColor = UIColor.orange
        return addressLabel
    }()
    
    // 详细地址
    fileprivate var detailLabel: UILabel = {
        let detailLabel = UILabel()
        detailLabel.font = UIFont.fontTextMessageText()
        detailLabel.numberOfLines = 0
        detailLabel.backgroundColor = UIColor.orange
        return detailLabel
    }()
    
    // 详细地址
    fileprivate var mapImageView: UIImageView = {
        let mapImageView = UIImageView()
        return mapImageView
    }()
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
