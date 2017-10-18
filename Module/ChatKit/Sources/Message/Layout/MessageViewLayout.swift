//
//  MessageLayout.swift
//  ChatKit
//
//  Created by chenwei on 2017/10/13.
//

import UIKit

class MessageViewLayout: UICollectionViewFlowLayout {

    weak var delegate: MessageViewLayoutDelegate?
    
    var setting = MessageLayoutSettings.share
    
    private var itemWidth: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        return collectionView.frame.width - sectionInset.left - sectionInset.right
    }
    
    open override class var layoutAttributesClass: AnyClass {
        return MessageLayoutAttributes.self
    }
    
    
    override init() {
        super.init()
        sectionInset = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout Attributes
    open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        guard let attributesArray = super.layoutAttributesForElements(in: rect) as? [MessageLayoutAttributes] else { 
            return nil
        }
        
        attributesArray.forEach { attributes in
            if attributes.representedElementCategory == .cell {
               // configure(attributes: attributes)
            }
        }
        
        return attributesArray
    }
    
    open override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        guard let attributes = super.layoutAttributesForItem(at: indexPath) as? MessageLayoutAttributes else { return nil }
        
        if attributes.representedElementCategory == UICollectionElementCategory.cell {
            //configure(attributes: attributes)
        }
        
        return attributes
    }
    
    
    // MARK: - Invalidation Context
    open override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        
        return collectionView?.bounds.width != newBounds.width || collectionView?.bounds.height != newBounds.height
        
    }
    
    open override func invalidationContext(forBoundsChange newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
        let context = super.invalidationContext(forBoundsChange: newBounds)
        guard let flowLayoutContext = context as? UICollectionViewFlowLayoutInvalidationContext else { return context }
        flowLayoutContext.invalidateFlowLayoutDelegateMetrics = shouldInvalidateLayout(forBoundsChange: newBounds)
        return flowLayoutContext
    }
    
}
