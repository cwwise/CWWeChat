//
//  MoreCollectionLayout.swift
//  Keyboard
//
//  Created by chenwei on 2017/7/20.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import UIKit

class MoreInputViewLayout: UICollectionViewFlowLayout {
    
    
    var cacheLayoutAttributes = [IndexPath: UICollectionViewLayoutAttributes]()
    // 
    var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
    
    var cacheContentSize: CGSize = CGSize.zero
        
    var collectionViewWidth: CGFloat {
        return collectionView!.frame.width
    }
    
    var collectionViewHeight: CGFloat {
        return collectionView!.frame.height
    }
    
    // 水平item数量
    var horizontalItemsCount: Int = 4
    // 列数
    var verticalItemsCount: Int = 2
    
    // MARK: - 返回大小
    override public var collectionViewContentSize: CGSize {
        return cacheContentSize
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        if collectionView?.frame.width != newBounds.width {
            return true
        }
        return false
    }
    
    // MARK:- 重新布局
    override func prepare() {
        super.prepare()
        
        // 1
        guard let collectionView = collectionView else {
            return
        }
        
        // 计算item 大小 
        var itemWidth = (collectionViewWidth - 2*sectionInset.left - CGFloat(horizontalItemsCount-1)*minimumInteritemSpacing)/CGFloat(horizontalItemsCount)
        itemWidth = CGFloatPixelRound(itemWidth)
        self.itemSize = CGSize(width: itemWidth, height: itemWidth)
        
        let padding = (collectionViewWidth - CGFloat(horizontalItemsCount) * itemWidth - CGFloat(horizontalItemsCount-1)*minimumInteritemSpacing) / 2.0
        let paddingLeft = CGFloatPixelRound(padding)
        
        let onePageCount = horizontalItemsCount*verticalItemsCount
        for section in 0..<collectionView.numberOfSections {
            // 遍历每一个item
            var x: CGFloat = 0
            var y: CGFloat = 0
            for item in 0..<collectionView.numberOfItems(inSection: section) {
                
                let indexPath = IndexPath(item: item, section: section)
                let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                
                let index = section*onePageCount+item
                
                let ii = index % onePageCount % horizontalItemsCount
                let jj = index % onePageCount / horizontalItemsCount
                
                x = itemSize.width * CGFloat(ii) + collectionViewWidth*CGFloat(section) + paddingLeft + CGFloat(horizontalItemsCount-1)*minimumInteritemSpacing
                y = itemSize.height * CGFloat(jj) + sectionInset.top
                
                attribute.frame = CGRect(x: x, y: y, width: itemSize.width, height: itemSize.height)
                
                cacheLayoutAttributes[indexPath] = attribute
            }
            
        }
        

        cacheContentSize = CGSize(width: CGFloat(collectionView.numberOfSections) * collectionViewWidth, 
                                  height: collectionViewHeight)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        visibleLayoutAttributes.removeAll(keepingCapacity: true)
        for (_, attributes) in cacheLayoutAttributes where attributes.frame.intersects(rect) {
            visibleLayoutAttributes.append(attributes)
        }
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cacheLayoutAttributes[indexPath]
    }
    
}
