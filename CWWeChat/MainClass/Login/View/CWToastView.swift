//
//  CWToastView.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/28.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

/**
 Toast样式
 
 - Loading:     加载中
 - ShowMessage: 显示消息
 */
enum CWToastViewStyle {
    case Loading
    case ShowMessage
}

class CWToastView: UIView {
    
    /// 样式
    var style: CWToastViewStyle
    /// loading动画
    private let spinner = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
    
    override init(frame: CGRect) {
        style = .Loading
        super.init(frame: frame)
    }
    
    init(style: CWToastViewStyle = .Loading) {
        self.style = style
        let frame = CGRect(x: 0, y: 0, width: 120, height: 120)
        super.init(frame: frame)
        
        //背景颜色
        self.backgroundColor = UIColor(hexString: "#111111")
        self.clipsToBounds = true
        self.layer.cornerRadius = 5
        
        if style == .Loading {
            spinner.startAnimating()
            addSubview(spinner)
        } else {
            
        }
        

    }
    
    override func intrinsicContentSize() -> CGSize {
        return CGSize(width: 120, height: 120)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        spinner.center = center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
