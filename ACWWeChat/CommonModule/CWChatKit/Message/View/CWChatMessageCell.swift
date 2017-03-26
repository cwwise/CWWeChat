//
//  CWChatMessageCell.swift
//  CWWeChat
//
//  Created by chenwei on 2017/3/26.
//  Copyright © 2017年 chenwei. All rights reserved.
//

import UIKit

class CWChatMessageCell: UITableViewCell {

    ///用户名称
    var usernameLabel:UILabel = {
        let usernameLabel = UILabel()
        usernameLabel.backgroundColor = UIColor.clear
        usernameLabel.font = UIFont.systemFont(ofSize: 12)
        return usernameLabel
    }()
    
    //引导
    var activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    lazy var errorButton:UIButton = {
        let errorButton = UIButton(type: .custom)
        errorButton.setImage(UIImage(named:"message_sendfaild"), for: UIControlState())
        errorButton.sizeToFit()
        errorButton.isHidden = true
        return errorButton
    }()
    
}
