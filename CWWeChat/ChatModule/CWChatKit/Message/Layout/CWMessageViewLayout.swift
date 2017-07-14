//
//  CWMessageViewLayout.swift
//  CWWeChat
//
//  Created by chenwei on 2017/7/14.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class CWMessageViewLayout: UICollectionViewLayout {
    
    private var contentHeight = CGFloat()
    var cache = [IndexPath: CWMessageLayoutAttributes]()
    var visibleLayoutAttributes = [CWMessageLayoutAttributes]()
    
    override public class var layoutAttributesClass: AnyClass {
        return CWMessageLayoutAttributes.self
    }
    
    override public var collectionViewContentSize: CGSize {
        return CGSize(width: collectionViewWidth, height: contentHeight)
    }
    
    private var collectionViewHeight: CGFloat {
        return collectionView!.frame.height
    }
    
    private var collectionViewWidth: CGFloat {
        return collectionView!.frame.width
    }
    
    
    private var contentOffset: CGPoint {
        return collectionView!.contentOffset
    }
    
}


extension CWMessageViewLayout {
    
    override func prepare() {
        
        guard let collectionView = collectionView,
            cache.isEmpty else {
                return
        }
        
        
    }
    
    // 所有cell 布局
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        return cache[indexPath]
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        guard let collectionView = collectionView else {
            return nil
        }
        
        visibleLayoutAttributes.removeAll(keepingCapacity: true)
        
        
        
        return visibleLayoutAttributes
    }
    
}

