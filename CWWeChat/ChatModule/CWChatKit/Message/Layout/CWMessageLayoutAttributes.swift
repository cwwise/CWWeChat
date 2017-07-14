//
//  CWMessageLayoutAttributes.swift
//  CWWeChat
//
//  Created by chenwei on 2017/7/14.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class CWMessageLayoutAttributes: UICollectionViewLayoutAttributes {

    var headerFrame: CGRect = .zero
    
    public override init() {
        super.init()
    }
    
    override func copy(with zone: NSZone? = nil) -> Any {
        guard let copiedAttributes = super.copy(with: zone) as? CWMessageLayoutAttributes else {
            return super.copy(with: zone)
        }
        
        return copiedAttributes
    }
    
    
    
}
