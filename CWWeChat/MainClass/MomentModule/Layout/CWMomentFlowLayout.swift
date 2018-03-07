//
//  CWMomentFlowLayout.swift
//  CWWeChat
//
//  Created by wei chen on 2017/7/26.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import YYText

protocol CWMomentFlowLayoutDelegate: NSObjectProtocol {
    
}

class CWMomentFlowLayout: UICollectionViewFlowLayout {

    weak var delegate: CWMomentFlowLayoutDelegate?
    ///
    var cellHeight: CGFloat = 0
    
    fileprivate var itemWidth: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        return collectionView.frame.width - sectionInset.left - sectionInset.right
    }
    
    override class var layoutAttributesClass: Swift.AnyClass {
        return CWMomentAttributes.self
    }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension CWMomentFlowLayout {
    
    override open func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        guard let attributesArray = super.layoutAttributesForElements(in: rect) as? [CWMomentAttributes] else {
            return nil
        }
        
        attributesArray.forEach { attributes in
            if attributes.representedElementCategory == UICollectionElementCategory.cell {
                configure(attributes: attributes)
            }
        }
        
        return attributesArray
    }
    
    private func configure(attributes: CWMomentAttributes) {

        print(attributes.frame)
        
    }
    
    
    // MARK: - Invalidation Context
    override open func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        
        return collectionView?.bounds.width != newBounds.width || collectionView?.bounds.height != newBounds.height
        
    }
    
    open override func invalidationContext(forBoundsChange newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
        let context = super.invalidationContext(forBoundsChange: newBounds)
        guard let flowLayoutContext = context as? UICollectionViewFlowLayoutInvalidationContext else { return context }
        flowLayoutContext.invalidateFlowLayoutDelegateMetrics = shouldInvalidateLayout(forBoundsChange: newBounds)
        return flowLayoutContext
    }
    
}
