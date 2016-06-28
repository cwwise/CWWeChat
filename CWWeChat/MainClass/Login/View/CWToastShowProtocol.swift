//
//  CWToastShowProtocol.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/28.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

protocol CWToastShowProtocol: class {
    func showToast(style: CWToastViewStyle, text: String)
}

extension CWToastShowProtocol where Self: UIViewController {
    
    func showToast(style: CWToastViewStyle, text: String) {
        let toastView = CWToastView(style: style)
        toastView.center = self.view.center
        toastView.text = text
        self.view.addSubview(toastView)
    }
    
    
}