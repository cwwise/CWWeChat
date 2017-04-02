//
//  UIImage+Extension.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/28.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

extension UIImage {
    
    class func imageWithColor(_ color: UIColor) -> UIImage {
        
        let rect = CGRect(x: 0, y: 0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    
    func resizableImage() -> UIImage {
        let edge = UIEdgeInsets(top: size.height*0.45, left: size.width*0.45, bottom: size.height*0.45, right: size.width*0.45)
        let image = self.resizableImage(withCapInsets: edge, resizingMode: .stretch)
        return image
    }
    
}
