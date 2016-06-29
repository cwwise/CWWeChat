//
//  CWToastView.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/28.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

/**
 一些部分参照 https://github.com/scalessec/Toast-Swift/blob/master/Toast/Toast.swift
 */


/**
 Toast样式
 
 - Loading:     加载中
 - ShowMessage: 显示消息
 */
public enum CWToastViewStyle {
    case Loading
    case ShowMessage
}

let ToastView_Width: CGFloat = 120
let ToastView_Height: CGFloat = 120

public class CWToastView: UIView {
    
    /**
     Swift closures can't be directly associated with objects via the
     Objective-C runtime, so the (ugly) solution is to wrap them in a
     class that can be used with associated objects.
     */
    private class ToastCompletionWrapper {
        var completion: ((Bool) -> Void)?
        
        init(_ completion: ((Bool) -> Void)?) {
            self.completion = completion
        }
    }
    
    var text: String = "" {
        didSet {
            self.textLabel.text = text
        }
    }
    /// 样式
    var style: CWToastViewStyle
    /// loading动画
    private let spinner = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
    
    private let textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.font = UIFont.systemFontOfSize(14)
        textLabel.frame = CGRect(x: 0, y: 0, width: ToastView_Width, height: 20)
        textLabel.textColor = UIColor.whiteColor()
        textLabel.textAlignment = .Center
        return textLabel
    }()
    
    private let imageView: UIImageView = {
       let imageView = UIImageView(image: UIImage(named: "show_success"))
        imageView.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        imageView.contentMode = .ScaleAspectFit
        return imageView
    }()
    
    internal init(style: CWToastViewStyle = .Loading, text: String = "") {
        self.style = style
        let frame = CGRect(x: 0, y: 0, width: ToastView_Width, height: ToastView_Height)
        super.init(frame: frame)
        
        //背景颜色
        self.backgroundColor = UIColor(hexString: "#111111")
        self.clipsToBounds = true
        self.layer.cornerRadius = 5
        self.alpha = 0.7
        
        if style == .Loading {
            spinner.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
            self.addSubview(spinner)
            spinner.startAnimating()
        } else {
            self.addSubview(imageView)
        }
        textLabel.text = text
        self.addSubview(textLabel)
    }
    
    override public func intrinsicContentSize() -> CGSize {
        return CGSize(width: 120, height: 120)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        spinner.center = CGPoint(x: ToastView_Width/2, y: ToastView_Height/2-10)
        imageView.center = CGPoint(x: ToastView_Width/2, y: ToastView_Height/2-10)
        textLabel.center = CGPoint(x: ToastView_Width/2, y: ToastView_Height/2+30)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: 显示方法
    /***/
    /**
     Creates and presents a new toast view with a message. Duration, position, and
     style can be set explicitly.
     
     @param message The message to be displayed
     @param duration The toast duration
     @param position The toast's position
     @param style The style. The shared style will be used when nil
     */
    public func makeToast(message: String, duration: NSTimeInterval, style: CWToastViewStyle) {
        self.makeToast(message, duration: duration, style: style, completion: nil)
    }
    
    public func makeToast(message: String?, duration: NSTimeInterval, style: CWToastViewStyle = .Loading, completion: ((didTap: Bool) -> Void)?) {
 
    
    }
    
}




public class CWToastManager {
    
    public static let shared = CWToastManager()

    
    
}


