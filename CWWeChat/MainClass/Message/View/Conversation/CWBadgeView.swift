//
//  CWBadgeView.swift
//  CWWeChat
//
//  Created by chenwei on 16/5/28.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

let BadgeViewWidth:CGFloat = 18

class CWBadgeView: UIView {
    
    let textSideMargin: CGFloat = 8.0
    let badgeViewHeight: CGFloat = 16.0
    
    var badgeTextColor: UIColor = UIColor.whiteColor()
    var badgeStrokeWidth: CGFloat = 0
    var badgeStrokeColor: UIColor = UIColor.whiteColor()
    
    var cornerRadius: CGFloat = 10.0
    
    var badgeBackgroundColor: UIColor = UIColor.redColor()
    var badgeTextFont: UIFont = UIFont.systemFontOfSize(15)
    
    var badgeValue:Int = 0 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    var sizeOfTextForCurrentSettings: CGSize {
        let text = "\(badgeValue)" as NSString
        let size = CGSize(width: 100, height: 20)
        let attributes = [NSFontAttributeName: self.badgeTextFont]
        let textSize = text.boundingRectWithSize(size, options: [.UsesLineFragmentOrigin], attributes: attributes, context: nil).size
        return textSize
    }
    
    var marginToDrawInside: CGFloat {
        return self.badgeStrokeWidth * 2
    }
    
    override func layoutSubviews() {
        
        var newFrame = self.frame
        
        let superviewBounds = self.superview!.bounds
        
        let textWidth = self.sizeOfTextForCurrentSettings.width
        let marginToDrawInside = self.marginToDrawInside
        
        let viewWidth = textWidth + textSideMargin + (marginToDrawInside * 2)
        
        let viewHeight = badgeViewHeight + (marginToDrawInside * 2)
        
        let superviewWidth = superviewBounds.size.width
        
        newFrame.size.width = max(viewWidth, viewHeight)
        newFrame.size.height = viewHeight;
        
        
        newFrame.origin.x = superviewWidth - (viewWidth / 2.0);
        newFrame.origin.y = -viewHeight / 2.0;
        let x = ceil(CGRectGetMidX(newFrame))
        let y = ceil(CGRectGetMidY(newFrame))
        
        self.bounds = CGRectIntegral(CGRectMake(0, 0, CGRectGetWidth(newFrame), CGRectGetHeight(newFrame)));
        self.center = CGPointMake(x, y);
        
        self.setNeedsDisplay()
    }
    
    
    
    override func drawRect(rect: CGRect) {
        
        guard self.badgeValue > 0 else {
            return
        }
        
        let context = UIGraphicsGetCurrentContext()
        
        
        let rectToDraw = CGRectInset(rect, marginToDrawInside, marginToDrawInside);
        let borderPath = UIBezierPath(roundedRect: rectToDraw, byRoundingCorners: .AllCorners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        
        /* Background and shadow */
        CGContextSaveGState(context)
        CGContextAddPath(context, borderPath.CGPath);
        CGContextSetFillColorWithColor(context, self.badgeBackgroundColor.CGColor);
        CGContextDrawPath(context, .Fill);
        CGContextRestoreGState(context)
        
        
        /* Stroke */
        CGContextSaveGState(context);
        CGContextAddPath(context, borderPath.CGPath);
        CGContextSetLineWidth(context, self.badgeStrokeWidth);
        CGContextSetStrokeColorWithColor(context, self.badgeStrokeColor.CGColor);
        CGContextDrawPath(context, .Stroke);
        CGContextRestoreGState(context);
        
        
        /* Text */
        CGContextSaveGState(context)
        
        var textFrame = rectToDraw;
        let textSize = self.sizeOfTextForCurrentSettings;
        
        textFrame.size.height = textSize.height;
        textFrame.origin.y = rectToDraw.origin.y + CGFloat(floorf(Float(rectToDraw.size.height - textFrame.size.height)) / 2.0)
        
        var text = "\(badgeValue)" as NSString
        if self.badgeValue > 99 {
            text = "99+"
        }
        
        let style = NSMutableParagraphStyle()
        style.alignment = .Center
        let attributes = [NSFontAttributeName: self.badgeTextFont,
                          NSForegroundColorAttributeName: self.badgeTextColor,
                          NSParagraphStyleAttributeName: style]
        text.drawInRect(textFrame, withAttributes: attributes)
        
        CGContextRestoreGState(context)
        
        
    }
    
}

