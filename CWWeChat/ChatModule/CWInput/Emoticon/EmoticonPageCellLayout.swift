//
//  EmoticonPageCellLayout.swift
//  CWWeChat
//
//  Created by wei chen on 2017/7/19.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

protocol EmoticonPageCellLayoutDelegate: class {

    // 
    func emoticonGroupInfo() -> EmoticonGroupInfo
    
    func collectionView(_ collectionView: UICollectionView, layout: EmoticonPageCellLayout) -> UIEdgeInsets
}

extension EmoticonPageCellLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, layout: EmoticonPageCellLayout) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
    }
}


class EmoticonPageCellLayout: UICollectionViewLayout {

    weak var delegate: EmoticonPageCellLayoutDelegate?
    
    var cacheLayoutAttributes = [IndexPath: UICollectionViewLayoutAttributes]()
    // 
    var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
   
    var cacheContentSize: CGSize = CGSize.zero
        
    var edgeInset: UIEdgeInsets {
        if let edge = self.delegate?.collectionView(collectionView!, layout: self) {
            return edge
        }
        return UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
    }
    
    var collectionViewWidth: CGFloat {
        return collectionView!.frame.width
    }
    
    var collectionViewHeight: CGFloat {
        return collectionView!.frame.height
    }
        
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
    
}

extension EmoticonPageCellLayout {
    
    override func prepare() {
        super.prepare()
                
        guard let collectionView = collectionView,
        let groupInfo = self.delegate?.emoticonGroupInfo() else {
            return
        }
         
       let emoticonColumn = groupInfo.column
       let emoticonRow = groupInfo.row

        // 计算item 大小 
        var itemWidth = (collectionViewWidth - 2*edgeInset.left)/CGFloat(emoticonColumn)
        itemWidth = CGFloatPixelRound(itemWidth)
        
        let padding = (collectionViewWidth - CGFloat(emoticonColumn) * itemWidth) / 2.0
        let paddingLeft = CGFloatPixelRound(padding)
        let _ = collectionViewWidth - paddingLeft - itemWidth * CGFloat(emoticonColumn) 
        
        var itemHeight = (collectionViewHeight - edgeInset.top - edgeInset.bottom)/CGFloat(emoticonRow)
        itemHeight = CGFloatPixelRound(itemHeight)

        let itemSize = CGSize(width: itemWidth, height: itemHeight)
        
        let sections = collectionView.numberOfSections
        for section in 0..<sections {
            // 遍历每一个item
            var x: CGFloat = 0
            var y: CGFloat = 0
            for item in 0..<collectionView.numberOfItems(inSection: section) {
                
                let indexPath = IndexPath(item: item, section: section)
                let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)

                let index = section*(emoticonColumn*emoticonRow)+item
                
                let ii = index % (emoticonColumn*emoticonRow) % emoticonColumn
                let jj = index % (emoticonColumn*emoticonRow) / emoticonColumn
                                
                x = itemSize.width * CGFloat(ii) + collectionViewWidth*CGFloat(section) + paddingLeft
                y = itemSize.height * CGFloat(jj) + edgeInset.top
                
                attribute.frame = CGRect(x: x, y: y, width: itemSize.width, height: itemSize.height)
                cacheLayoutAttributes[indexPath] = attribute
            }
          
        }
        
        cacheContentSize = CGSize(width: CGFloat(sections) * collectionViewWidth, 
                                  height: edgeInset.top + CGFloat(emoticonRow)*itemSize.height + edgeInset.bottom)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        guard let _ = collectionView else {
            return nil
        }
        
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


func CGFloatPixelRound(_ value: CGFloat) -> CGFloat {
    let scale = UIScreen.main.scale
    return round(value * scale) / scale
}

