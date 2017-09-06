//
//  CWMoreKeyBoard.swift
//  CWWeChat
//
//  Created by wei chen on 2017/4/11.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import YYText

public protocol CWMoreInputViewDelegate: NSObjectProtocol {
    func moreInputView(_ inputView: CWMoreInputView, didSelect item: MoreItem)
}

private let kOneLines: Int = 2
private let kOneLineItem: Int = 4
private let kOneItemHeight: CGFloat = 280/3

public class CWMoreInputView: UIView {
    
    fileprivate var items = [MoreItem]()
    // 总共页数
    var totalPageCount: Int = 0
    var pageItemCount: Int = 0
    
    private convenience init() {
        let size = CGSize(width: kScreenWidth, height: kMoreInputViewHeight)
        let origin = CGPoint(x: 0, y: kScreenHeight-size.height)
        let frame = CGRect(origin: origin, size: size)
        self.init(frame: frame)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(hex: "#E7EFF5")
        self.addSubview(collectionView)
        self.addSubview(pageControl)
        pageControl.top = collectionView.bottom
    }
    
    weak var deleagte: CWMoreInputViewDelegate?
    
    // 加载items
    func loadMoreItems(_ items: [MoreItem]) {
        self.items = items
        
        pageItemCount = kOneLines * kOneLineItem
        totalPageCount = Int(ceil(CGFloat(items.count)/CGFloat(pageItemCount)))
        pageControl.numberOfPages = totalPageCount
        collectionView.reloadData()
    }
    
    lazy var collectionView: UICollectionView = {
        // 间距
        var itemWidth = (kScreenWidth - 10*2)/CGFloat(kOneLineItem)
        itemWidth = YYTextCGFloatPixelRound(itemWidth)
        
        let padding = (kScreenWidth - CGFloat(kOneLineItem) * itemWidth) / 2.0
        let paddingLeft = YYTextCGFloatPixelRound(padding)
        let paddingRight = kScreenWidth - paddingLeft - itemWidth * CGFloat(kOneLineItem)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: itemWidth, height: kOneItemHeight)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsetsMake(0, paddingLeft, 0, paddingRight)
        
        let frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kOneItemHeight*CGFloat(kOneLines))
        var collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(MoreItemCell.self, forCellWithReuseIdentifier: MoreItemCell.identifier)
        collectionView.top = 10
        return collectionView
    }()
    
    var pageControl: UIPageControl!
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CWMoreInputView: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pageItemCount
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return totalPageCount
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoreItemCell.identifier, for: indexPath) as! MoreItemCell
        cell.item = moreItemForIndexPath(indexPath)
        return cell
    }
    
    func moreItemForIndexPath(_ indexPath: IndexPath) -> MoreItem? {
        var index = indexPath.section * self.pageItemCount + indexPath.row
//
        let page = index / self.pageItemCount
        index = index % self.pageItemCount
        
        let x = index / kOneLines
        let y = index % kOneLines

        let resultIndex = self.pageItemCount / kOneLines * y + x + page * self.pageItemCount
        if resultIndex > items.count - 1 {
            return nil
        }
        return items[resultIndex]
    }
    
}

