//
//  CWChatTextDisplayView.swift
//  CWWeChat
//
//  Created by chenwei on 16/7/9.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWChatTextDisplayView: UIView {

    let width_textView: CGFloat = Screen_Width * 0.94
    
    var attrString:NSAttributedString? {
        didSet {
            let mutableAttrString = NSMutableAttributedString(attributedString: attrString!)
            mutableAttrString.addAttributes([NSFontAttributeName:UIFont.systemFontOfSize(25)],
                                            range: NSMakeRange(0, attrString!.length))
            
            self.textView.attributedText = mutableAttrString
            var size = self.textView.sizeThatFits(CGSizeMake(width_textView,CGFloat(MAXFLOAT)))
            size.height = size.height > Screen_Height ? Screen_Height : size.height;
            
            textView.snp_updateConstraints { (make) in
                make.size.equalTo(size)
            }
        }
    }
    
    private var textView:UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor.clearColor()
        textView.textAlignment = .Center
        textView.editable = false
        return textView
    }()
    
    convenience init() {
        self.init(frame:UIScreen.mainScreen().bounds)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        self.addSubview(textView)
        textView.snp_makeConstraints { (make) in
            make.center.equalTo(self)
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(CWChatTextDisplayView.dismiss))
        self.addGestureRecognizer(tapGesture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func showInView(view:UIView = UIApplication.sharedApplication().keyWindow!,attrText:NSAttributedString,animation:Bool = true) {
        view.addSubview(self)
        self.frame = view.bounds
        self.attrString = attrText
        self.alpha = 0
        UIView.animateWithDuration(0.15, animations: {
            self.alpha = 1
        }) { (bool) in
            UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: .Fade)
        }
        
    }
    
    func dismiss() {
        UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: .Fade)
        UIView.animateWithDuration(0.2, animations: {
            self.alpha = 0
        }) { (bool) in
            self.removeFromSuperview()
        }
    }
}
