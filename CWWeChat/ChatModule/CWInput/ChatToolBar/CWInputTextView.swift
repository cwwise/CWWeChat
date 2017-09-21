//
//  CWInputTextView.swift
//  CWWeChat
//
//  Created by chenwei on 2017/4/11.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class CWInputTextView: UITextView {

    //MARK: 属性
    var placeHolder: String? {
        didSet {
            let maxChars = CWInputTextView.maxCharactersPerLine()
            guard var placeHolder = placeHolder else {
                return
            }
            
            if placeHolder.characters.count > maxChars {
                let index = placeHolder.characters.index(placeHolder.startIndex, offsetBy: -8)
                placeHolder = String(placeHolder[..<index])
                self.placeHolder = placeHolder.trimWhitespace() + "..."
            }
            self.setNeedsDisplay()
        }
    }
    var placeHolderTextColor: UIColor? {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    
    //MARK:  Text view overrides
    override var text: String! {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    override var attributedText: NSAttributedString! {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    override var contentInset: UIEdgeInsets {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    override var font: UIFont? {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    override var textAlignment: NSTextAlignment {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    override func insertText(_ text: String) {
        super.insertText(text)
        self.setNeedsDisplay()
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setup() {
        placeHolderTextColor = UIColor.lightGray
        
        self.enablesReturnKeyAutomatically = true
        self.keyboardType = .default;
        self.autoresizingMask = .flexibleWidth;
        self.scrollIndicatorInsets = UIEdgeInsetsMake(10.0, 0.0, 10.0, 8.0)
        self.contentInset = UIEdgeInsets.zero;
        self.isScrollEnabled = true;
        self.scrollsToTop = false;
        self.isUserInteractionEnabled = true;
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        self.font = UIFont.systemFont(ofSize: 16.0)
        self.textColor = UIColor.black
        self.backgroundColor = UIColor.white
        self.keyboardAppearance = .default;
        self.returnKeyType = .send;
        self.textAlignment = .left;
    }
    
    
    deinit {
        placeHolder = nil
        placeHolderTextColor = nil
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: Drawing
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if self.text.characters.count == 0 && (placeHolder != nil) {
            let placeHolderRect = CGRect(x: 10.0,
                                         y: 7.0,
                                         width: rect.size.width,
                                         height: rect.size.height);
            self.placeHolderTextColor?.set()
            let string = self.placeHolder! as NSString
            string.draw(in: placeHolderRect, withAttributes: [NSAttributedStringKey.font:self.font!])
        }
        
    }
    
    //最大行数
    func numberOfLinesOfText() -> Int {
        return CWInputTextView.numberOfLinesForMessage(self.text)
    }
    
    class func maxCharactersPerLine() -> Int {
        return 33
    }
    
    class func numberOfLinesForMessage(_ text:String) -> Int {
        return text.characters.count / CWInputTextView.maxCharactersPerLine() + 1
    }

}
