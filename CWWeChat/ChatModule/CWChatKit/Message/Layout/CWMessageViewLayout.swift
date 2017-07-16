//
//  CWMessageViewLayout.swift
//  CWWeChat
//
//  Created by chenwei on 2017/7/14.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import YYText

protocol CWMessageViewLayoutDelegate: NSObjectProtocol {
    func collectionView(_ collectionView: UICollectionView, itemAt indexPath: IndexPath) -> CWMessageModel
}

class CWMessageViewLayout: UICollectionViewLayout {
    
    weak var delegate: CWMessageViewLayoutDelegate?
    
    
    var setting = CWMessageLayoutSettings()
    
    var needLayout: Bool = true
    
    var contentHeight = CGFloat()
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
    
    func prepareCache() {
        cache.removeAll(keepingCapacity: true)
    }
    
    override func prepare() {
        
        guard let collectionView = collectionView,
            let delegate = self.delegate,
           needLayout == true else {
                return
        }
        prepareCache()
        
        needLayout = false
        contentHeight = 0
        // 计算布局
        let section = 0
        for item in 0 ..< collectionView.numberOfItems(inSection: section) {

            let cellIndexPath = IndexPath(item: item, section: section)
            let attributes = CWMessageLayoutAttributes(forCellWith: cellIndexPath)
            let message = delegate.collectionView(collectionView, itemAt: cellIndexPath)
            attributes.message = message
            
            setupCommonViewFrame(with: message, attributes: attributes)
            
            var contentSize: CGSize = CGSize.zero
            // 根据消息不同类型 计算
            if message.messageType == .text {
                
                let content = (message.messageBody as! CWTextMessageBody).text
                let size = CGSize(width: kChatTextMaxWidth, height: CGFloat.greatestFiniteMagnitude)
                var edge: UIEdgeInsets
                if message.isSend {
                    edge = ChatCellUI.right_edge_insets
                } else {
                    edge = ChatCellUI.left_edge_insets
                }
                
                let modifier = CWTextLinePositionModifier(font: UIFont.fontTextMessageText())
                // YYTextContainer
                let textContainer = YYTextContainer(size: size)
                textContainer.linePositionModifier = modifier
                textContainer.maximumNumberOfRows = 0
                
                let textAttri = CWChatTextParser.parseText(content)!
                let textLayout = YYTextLayout(container: textContainer, text: textAttri)!
                
                contentSize = CGSize(width: textLayout.textBoundingSize.width+edge.left+edge.right,
                                     height: textLayout.textBoundingSize.height+edge.top+edge.bottom)
            }
            
            // cell 高度
            let heightOfCell = contentSize.height + kMessageCellBottomMargin + kMessageCellTopMargin

            attributes.frame = CGRect(x: 0, y: contentHeight, width: kScreenWidth, height: heightOfCell)
            
            contentHeight = attributes.frame.maxY

            
            cache[cellIndexPath] = attributes
            
            
        }
        
    }
    
    func setupCommonViewFrame(with message: CWMessageModel, attributes: CWMessageLayoutAttributes) {
        
        var size: CGSize = CGSize.zero
        var point: CGPoint = CGPoint.zero
        
        size = CGSize(width: 40, height: 40)
        if message.isSend {
            
        } else {
            
        }
        
        point = CGPoint(x: kAvaterImageViewMargin, y: kMessageCellTopMargin)

        attributes.avatarFrame = CGRect(origin: point, size: size)
        
    }
    
    // 所有cell 布局
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath]
    }
    
    //3
    override public func layoutAttributesForElements(
        in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        visibleLayoutAttributes.removeAll(keepingCapacity: true)
        for (_, attributes) in cache where attributes.frame.intersects(rect) {
            visibleLayoutAttributes.append(attributes)
        }
        return visibleLayoutAttributes
    }
    
    open override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

    
    override func invalidateLayout(with context: UICollectionViewLayoutInvalidationContext) {
        super.invalidateLayout(with: context)
    
        if context.invalidateDataSourceCounts {
            needLayout = true
        }
    }
}

