//
//  CWChatTextDisplayView.swift
//  CWWeChat
//
//  Created by chenwei on 16/7/9.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWChatTextDisplayView: UIView {

    let width_textView: CGFloat = kScreenWidth * 0.94
    
    var attrString:NSAttributedString? {
        didSet {
            let mutableAttrString = NSMutableAttributedString(attributedString: attrString!)
            mutableAttrString.addAttributes([NSAttributedStringKey.font:UIFont.systemFont(ofSize: 25)],
                                            range: NSMakeRange(0, attrString!.length))
            
            self.textView.attributedText = mutableAttrString
            var size = self.textView.sizeThatFits(CGSize(width: width_textView,height: CGFloat(MAXFLOAT)))
            size.height = size.height > kScreenHeight ? kScreenHeight : size.height;
            
            textView.snp.updateConstraints { (make) in
                make.size.equalTo(size)
            }
        }
    }
    
    fileprivate var textView:UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor.clear
        textView.textAlignment = .center
        textView.isEditable = false
        return textView
    }()
    
    convenience init() {
        self.init(frame:UIScreen.main.bounds)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.addSubview(textView)
        textView.snp.makeConstraints { (make) in
            make.center.equalTo(self)
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(CWChatTextDisplayView.dismiss))
        self.addGestureRecognizer(tapGesture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func showInView(_ view:UIView = UIApplication.shared.keyWindow!,attrText:NSAttributedString,animation:Bool = true) {
        view.addSubview(self)
        self.frame = view.bounds
        self.attrString = attrText
        self.alpha = 0
        UIView.animate(withDuration: 0.15, animations: {
            self.alpha = 1
        }, completion: { (bool) in
            
//            UIApplication.shared.setStatusBarHidden(true, with: .fade)
        })
        
    }
    
    @objc func dismiss() {
//        UIApplication.shared.setStatusBarHidden(false, with: .fade)
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0
        }, completion: { (bool) in
            self.removeFromSuperview()
        }) 
    }
}
