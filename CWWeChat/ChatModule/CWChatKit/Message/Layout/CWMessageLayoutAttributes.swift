//
//  CWMessageLayoutAttributes.swift
//  CWWeChat
//
//  Created by chenwei on 2017/7/14.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class CWMessageLayoutAttributes: UICollectionViewLayoutAttributes {

    var message: CWMessageModel?
    
    var avatarFrame: CGRect = .zero
    var usernameFrame: CGRect = .zero
    var contentViewFrame: CGRect = .zero
    
    public override init() {
        super.init()
    }
    
    override func copy(with zone: NSZone? = nil) -> Any {
        guard let copiedAttributes = super.copy(with: zone) as? CWMessageLayoutAttributes else {
            return super.copy(with: zone)
        }
        
        copiedAttributes.avatarFrame = avatarFrame
        copiedAttributes.usernameFrame = avatarFrame
        copiedAttributes.contentViewFrame = contentViewFrame

        copiedAttributes.message = message
        
        return copiedAttributes
    }
    
    
    
}
