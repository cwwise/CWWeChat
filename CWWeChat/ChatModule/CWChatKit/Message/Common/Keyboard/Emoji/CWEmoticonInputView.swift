//
//  CWEmoticonInputView.swift
//  CWWeChat
//
//  Created by chenwei on 2017/4/20.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import YYText.YYTextUtilities

private let kOneLineItem = 8
private let kViewHeight: CGFloat = 8
private let kOneEmoticonHeight: CGFloat = 50

class CWEmoticonInputView: UIView {
    
    static let shareView: CWEmoticonInputView = {
        let frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kViewHeight)
        return CWEmoticonInputView(frame: frame)
    }()
    
    var collectionView: CWEmoticonScrollView!
    
    var emoticonGroupTotalPageCount: Int
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func setupCollectionView() {
        var itemWidth = (kScreenWidth - 10*2)/CGFloat(kOneLineItem)
        itemWidth = YYTextCGFloatPixelRound(itemWidth)
        
        let padding = (kScreenWidth - CGFloat(kOneLineItem) * itemWidth) / 2.0
        let paddingLeft = YYTextCGFloatPixelRound(padding)
        let paddingRight = kScreenWidth - paddingLeft - itemWidth * CGFloat(kOneLineItem)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: itemWidth, height: kOneEmoticonHeight)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsetsMake(0, paddingLeft, 0, paddingRight)
        
        let frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kOneEmoticonHeight*3)
        collectionView = CWEmoticonScrollView(frame: frame, collectionViewLayout: layout)
        collectionView.register(CWEmoticonCell.self, forCellWithReuseIdentifier: CWEmoticonCell.identifier)
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.top = 5;
        self.addSubview(collectionView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CWEmoticonInputView: UICollectionViewDelegate {
    
}

extension CWEmoticonInputView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
    }
}

