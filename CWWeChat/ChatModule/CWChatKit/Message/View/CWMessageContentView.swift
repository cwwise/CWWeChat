//
//  CWMessageContentView.swift
//  CWWeChat
//
//  Created by wei chen on 2017/7/16.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

protocol CWMessageContentViewDelegate: NSObjectProtocol {
    func onCatchEvent(_ event: NSObject)
}

class CWMessageContentView: UIView {

    weak var delegate: CWMessageContentViewDelegate?
    
    private(set) var message: CWMessageModel?
    
    var bubbleImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.clipsToBounds = true
    }
    
    func refresh(message: CWMessageModel) {
        self.message = message
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
