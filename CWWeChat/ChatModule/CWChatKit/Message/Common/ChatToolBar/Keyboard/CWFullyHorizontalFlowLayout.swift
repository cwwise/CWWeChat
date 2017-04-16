//
//  CWFullyHorizontalFlowLayout.swift
//  CWWeChat
//
//  Created by chenwei on 16/7/10.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

/*
 参考
 https://github.com/philippeauriach/fullyhorizontalcollectionview
 */
class CWFullyHorizontalFlowLayout: UICollectionViewFlowLayout {
    
    /// 每行的元素个数
    fileprivate var kNumbersPerLine : Int = 0
    
    /// 每列的元素个数
    fileprivate var kNumbersPerCol : Int = 0
    
    //MARK: - 懒加载
    /// 计算所有Cell位置大小属性值
    lazy var layoutAttrs : [UICollectionViewLayoutAttributes] = {
        
        var arr = [UICollectionViewLayoutAttributes]()
        //计算UICollectionViewLayoutAttributes
        let sections = self.collectionView?.numberOfSections ?? 0
        for index in 0..<sections{
            let itemNum = self.collectionView?.numberOfItems(inSection: index) ?? 0
            for itemIndex in 0..<itemNum{
                let attr = UICollectionViewLayoutAttributes(forCellWith: IndexPath(item: itemIndex, section: index))
                arr.append(attr)
            }
        }
        let perPageCount = self.kNumbersPerLine * self.kNumbersPerCol
        for index in 0..<arr.count{
            let currentPage = index / perPageCount
            let countInSinglePage = index % perPageCount
            //列号
            let colNumber = countInSinglePage % self.kNumbersPerLine
            //行号
            let rowNumber = countInSinglePage / self.kNumbersPerLine
            
            //计算frame
            let x = CGFloat(currentPage) * (self.collectionView?.frame.width)! + self.itemSize.width * CGFloat(colNumber)
            let y = self.itemSize.height * CGFloat(rowNumber)
            
            arr[index].frame = CGRect(origin: CGPoint(x: x, y: y), size: self.itemSize)
        }
        
        return arr
    }()
    
    /// 计算ContentSize
    override var collectionViewContentSize: CGSize{
        get{
            var count = 0
            for index in 0..<(self.collectionView?.numberOfSections ?? 0){
                count += collectionView?.numberOfItems(inSection: index) ?? 0
            }
            let page = count / (kNumbersPerLine * kNumbersPerCol)
            return CGSize(width: self.collectionView!.frame.width * CGFloat(page), height: 0)
        }
    }
    
    
    /// 唯一初始化方法
    ///
    /// - parameter colNumber:  行数
    /// - parameter lineNumber: 列数
    ///
    /// - returns: HorizontalCrossFlowLayout
    init(colNumber : Int, lineNumber : Int) {
        self.kNumbersPerLine = colNumber
        self.kNumbersPerCol = lineNumber
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// 准备布局 设置一些属性
    override func prepare() {
        super.prepare()
        scrollDirection = .horizontal
    }
    
    
    /// 获取指定区域的布局
    ///
    /// - parameter rect: 指定区域
    ///
    /// - returns: 布局属性
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return layoutAttrs
    }
    
    
    /// 单个Item的属性
    ///
    /// - parameter indexPath: indexPath位置
    ///
    /// - returns: UICollectionViewLayoutAttributes属性值
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let count = indexPath.section * kNumbersPerCol * kNumbersPerLine + indexPath.item
        return layoutAttrs[count]
    }
    
    
    
}
