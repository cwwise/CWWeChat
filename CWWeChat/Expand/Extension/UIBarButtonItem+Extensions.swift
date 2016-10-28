//
//  UIBarButtonItem+Chat.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/23.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    class func fixBarItemSpaceWidth(_ spaceWidth: CGFloat) -> UIBarButtonItem {
        let fixspaceItem =  UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        fixspaceItem.width = spaceWidth
        return fixspaceItem
    }
    
    convenience init(backTitle: String, target: AnyObject, action: Selector) {
        let view = UIButton(type: .custom)
        view.addTarget(target, action: action, for: .touchUpInside)
        view.backgroundColor = UIColor.clear
        //添加返回按钮
        let imageView = UIImageView(image: CWAsset.Nav_back.image)
        imageView.frame = CGRect(x: 0, y: 0, width: 17, height: 34)
        view.addSubview(imageView)
        
        //返回
        let label = UILabel()
        label.text = backTitle
        label.textColor = UIColor.white
        let size = label.sizeThatFits(CGSize(width: CGFloat(MAXFLOAT), height: CGFloat(MAXFLOAT)))
        label.frame = CGRect(x: 17, y: 0, width: ceil(size.width)+1, height: 34)
        view.addSubview(label)
        
        self.init(customView: view)
        view.frame = CGRect(x: 0, y: 0, width: label.right, height: 34)
        
    }


}
