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
    
    var badgeTextColor: UIColor = UIColor.white
    var badgeStrokeWidth: CGFloat = 0
    var badgeStrokeColor: UIColor = UIColor.white
    
    var cornerRadius: CGFloat = 10.0
    
    var badgeBackgroundColor: UIColor = UIColor.red
    var badgeTextFont: UIFont = UIFont.systemFont(ofSize: 15)
    
    var badgeValue:Int = 0 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    var sizeOfTextForCurrentSettings: CGSize {
        let text = "\(badgeValue)" as NSString
        let size = CGSize(width: 100, height: 20)
        let attributes = [NSAttributedStringKey.font: self.badgeTextFont]
        let textSize = text.boundingRect(with: size, options: [.usesLineFragmentOrigin], attributes: attributes, context: nil).size
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
        
        
        newFrame.origin.x = superviewWidth - (viewWidth / 2.0) - 4;
        newFrame.origin.y = -viewHeight / 2.0;
        let x = ceil(newFrame.midX)
        let y = ceil(newFrame.midY)
        
        self.bounds = CGRect(x: 0, y: 0, width: newFrame.width, height: newFrame.height).integral;
        self.center = CGPoint(x: x, y: y);
        
        self.setNeedsDisplay()
    }
    
    
    
    override func draw(_ rect: CGRect) {
        
        guard self.badgeValue > 0 else {
            return
        }
        
        let context = UIGraphicsGetCurrentContext()
        
        
        let rectToDraw = rect.insetBy(dx: marginToDrawInside, dy: marginToDrawInside);
        let borderPath = UIBezierPath(roundedRect: rectToDraw, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        
        /* Background and shadow */
        context?.saveGState()
        context?.addPath(borderPath.cgPath);
        context?.setFillColor(self.badgeBackgroundColor.cgColor);
        context?.drawPath(using: .fill);
        context?.restoreGState()
        
        
        /* Stroke */
        context?.saveGState();
        context?.addPath(borderPath.cgPath);
        context?.setLineWidth(self.badgeStrokeWidth);
        context?.setStrokeColor(self.badgeStrokeColor.cgColor);
        context?.drawPath(using: .stroke);
        context?.restoreGState();
        
        
        /* Text */
        context?.saveGState()
        
        var textFrame = rectToDraw;
        let textSize = self.sizeOfTextForCurrentSettings;
        
        textFrame.size.height = textSize.height;
        textFrame.origin.y = rectToDraw.origin.y + CGFloat(floorf(Float(rectToDraw.size.height - textFrame.size.height)) / 2.0)
        
        var text = "\(badgeValue)" as NSString
        if self.badgeValue > 99 {
            text = "99+"
        }
        
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        let attributes = [NSAttributedStringKey.font: self.badgeTextFont,
                          NSAttributedStringKey.foregroundColor: self.badgeTextColor,
                          NSAttributedStringKey.paragraphStyle: style] as [NSAttributedStringKey : Any]
        text.draw(in: textFrame, withAttributes: attributes)
        
        context?.restoreGState()
        
        
    }
    
}

