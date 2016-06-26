//
//  CWMessageTextView.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/26.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWMessageTextView: UITextView {
    
    //MARK: 属性
    var placeHolder:String? {
        
        didSet {
            let maxChars = CWMessageTextView.maxCharactersPerLine()
            if placeHolder?.characters.count > maxChars {
                let index = placeHolder!.startIndex.advancedBy(-8)
                placeHolder = placeHolder?.substringToIndex(index)
                placeHolder = placeHolder!.trimWhitespace().stringByAppendingString("...")
            }
            self.setNeedsDisplay()
        }
    }
    var placeHolderTextColor:UIColor? {
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
    
    override func insertText(text: String) {
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
        placeHolderTextColor = UIColor.lightGrayColor()
        
        self.autoresizingMask = .FlexibleWidth;
        self.scrollIndicatorInsets = UIEdgeInsetsMake(10.0, 0.0, 10.0, 8.0)
        self.contentInset = UIEdgeInsetsZero;
        self.scrollEnabled = true;
        self.scrollsToTop = false;
        self.userInteractionEnabled = true;
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.grayColor().CGColor
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
        self.font = UIFont.systemFontOfSize(16.0)
        self.textColor = UIColor.blackColor()
        self.backgroundColor = UIColor.whiteColor()
        self.keyboardAppearance = .Default;
        self.keyboardType = .Default;
        self.returnKeyType = .Send;
        self.textAlignment = .Left;
    }
    
    
    deinit {
        placeHolder = nil
        placeHolderTextColor = nil
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    //MARK: Drawing
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        if self.text.characters.count == 0 && (placeHolder != nil) {
            let placeHolderRect = CGRectMake(10.0,
                                             7.0,
                                             rect.size.width,
                                             rect.size.height);
            self.placeHolderTextColor?.set()
            let string = self.placeHolder! as NSString
            string.drawInRect(placeHolderRect, withAttributes: [NSFontAttributeName:self.font!])
        }
        
    }
    
    //最大行数
    func numberOfLinesOfText() -> Int {
        return CWMessageTextView.numberOfLinesForMessage(self.text)
    }
    
    class func maxCharactersPerLine() -> Int {
        return 33
    }
    
    class func numberOfLinesForMessage(text:String) -> Int {
        return text.characters.count / CWMessageTextView.maxCharactersPerLine() + 1
    }
    
}