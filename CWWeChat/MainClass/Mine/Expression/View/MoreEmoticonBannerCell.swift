//
//  MoreEmoticonHeaderView.swift
//  CWWeChat
//
//  Created by chenwei on 2017/9/4.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import UIKit
import FSPagerView

class MoreEmoticonBannerCell: UICollectionReusableView {
    
    var pagerView: FSPagerView!
    
    var emoticonList: [EmoticonPackage] = [] {
        didSet {
            pagerView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        pagerView = FSPagerView()
        pagerView.isInfinite = true
        pagerView.dataSource = self
        pagerView.delegate = self
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        self.addSubview(pagerView)
        
        pagerView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MoreEmoticonBannerCell: FSPagerViewDelegate, FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return emoticonList.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.clipsToBounds = true
        let emoticon = emoticonList[index]
        cell.imageView?.kf.setImage(with: emoticon.banner)
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, shouldHighlightItemAt index: Int) -> Bool {
        return false
    }
    
}

