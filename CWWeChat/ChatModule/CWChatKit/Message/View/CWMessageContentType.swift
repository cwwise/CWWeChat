//
//  CWMessageContent.swift
//  CWWeChat
//
//  Created by wei chen on 2017/7/14.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

protocol CWMessageContentType: NSObjectProtocol {
   
    var layoutMargins: UIEdgeInsets { get }

}


extension CWMessageContentType where Self: UIView {


    
}

