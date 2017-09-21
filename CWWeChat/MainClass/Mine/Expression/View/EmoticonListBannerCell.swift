//
//  EmoticonListBannerCell.swift
//  CWWeChat
//
//  Created by chenwei on 2017/8/23.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import FSPagerView
import Kingfisher
import SnapKit

class EmoticonListBannerCell: UITableViewCell {

    var pagerView: FSPagerView!

    var emoticonList: [EmoticonPackage] = [] {
        didSet {
            pagerView.reloadData()
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        pagerView = FSPagerView()
        pagerView.isInfinite = true
        pagerView.dataSource = self
        pagerView.delegate = self
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        self.contentView.addSubview(pagerView)
        
        pagerView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.zero)
        }        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension EmoticonListBannerCell: FSPagerViewDelegate, FSPagerViewDataSource {
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

