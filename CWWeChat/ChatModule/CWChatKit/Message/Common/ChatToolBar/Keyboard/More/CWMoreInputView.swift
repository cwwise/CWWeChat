//
//  CWMoreKeyBoard.swift
//  CWWeChat
//
//  Created by wei chen on 2017/4/11.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import CHIPageControl

public protocol CWMoreInputViewDelegate: NSObjectProtocol {
    func moreInputView(_ inputView: CWMoreInputView, didSelect item: CWMoreItem)
}

public class CWMoreInputView: UIView {
    
    fileprivate var items = [CWMoreItem]()
    
    private convenience init() {
        let size = CGSize(width: kScreenWidth, height: kMoreKeyBoardHeight)
        let origin = CGPoint(x: 0, y: kScreenHeight-size.height)
        let frame = CGRect(origin: origin, size: size)
        self.init(frame: frame)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(collectionView)
        self.addSubview(pageControl)
    }
    
    weak var deleagte: CWMoreInputViewDelegate?
    
    // 加载items
    func loadMoreItems(_ items: [CWMoreItem]) {
        self.items = items
        collectionView.reloadData()
    }
    
    lazy var collectionView: UICollectionView = {
        let frame = CGRect.zero
        let layout = UICollectionViewLayout()
        var collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.register(CWMoreItemCell.self, forCellWithReuseIdentifier: CWMoreItemCell.identifier)
        return collectionView
    }()
    
    var pageControl: CHIPageControlAleppo = {
        let pageControl = CHIPageControlAleppo(frame: CGRect(x: 0, y: 10, width: kScreenWidth, height: 25))
        pageControl.radius = 4
        pageControl.hidesForSinglePage = true
        pageControl.tintColor = UIColor.gray
        pageControl.currentPageTintColor = UIColor.white
        pageControl.progress = 0
        return pageControl
    }()
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CWMoreInputView: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CWMoreItemCell.identifier, for: indexPath)
        
        return cell
    }
    
}

