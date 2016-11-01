//
//  CWMoreKeyboard.swift
//  CWWeChat
//
//  Created by chenwei on 16/7/7.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}



let ITEM_COUNT_PAGE:Int = 8

class CWMoreKeyboard: UIView {
    
    var width_collection_cell: CGFloat = 60
    var height_top_margin: CGFloat = 15
    var height_collectionView: CGFloat {
        return (215*0.85 + height_top_margin)
    }
    
    lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let height = self.height_collectionView / 2 * 0.93
        let spaceX = (Screen_Width-self.width_collection_cell*4)/5
        let spaceY = self.height_collectionView - 2*height
        layout.itemSize = CGSize(width: self.width_collection_cell, height: height)
        layout.minimumLineSpacing = spaceX
        layout.minimumInteritemSpacing = spaceY
        
        layout.headerReferenceSize = CGSize(width: spaceX, height: self.height_collectionView)
        layout.footerReferenceSize = CGSize(width: spaceX, height: self.height_collectionView)
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.isPagingEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.scrollsToTop = false
        
        return collectionView
    }()
    
    
    var chatMoreKeyboardData:[CWMoreKeyboardItem]?
    
    init() {
        super.init(frame:CGRect.zero)
        backgroundColor = UIColor("#F4F4F6")
        addSubview(self.collectionView)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let ctx = UIGraphicsGetCurrentContext()
        guard let context = ctx else {
            return
        }
        context.setLineWidth(0.5)
        context.setStrokeColor(UIColor.gray.cgColor)
        
        context.beginPath()
        context.move(to: CGPoint(x: 0, y: 0))
        context.addLine(to: CGPoint(x: Screen_Width, y: 0))
        context.closePath()
        context.strokePath()
    }
    
    func addsnap() {
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(height_top_margin)
            make.left.right.equalTo(self)
            make.height.equalTo(height_collectionView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func registerCellClass()  {
        self.collectionView.register(CWMoreKeyboardCell.self, forCellWithReuseIdentifier: "cell")
    }
    

}

//MARK: 协议
extension CWMoreKeyboard: UICollectionViewDelegate {
    
}


///UICollectionViewDataSource
extension CWMoreKeyboard: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if let data = self.chatMoreKeyboardData {
            return data.count / ITEM_COUNT_PAGE + ((data.count%ITEM_COUNT_PAGE == 0) ? 0 : 1)
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ITEM_COUNT_PAGE
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CWMoreKeyboardCell
        let index = (indexPath as NSIndexPath).row + (indexPath as NSIndexPath).section * ITEM_COUNT_PAGE
        let temp_index = transformIndex(index)
        
        if temp_index > self.chatMoreKeyboardData?.count {
            cell.item = nil
        } else {
            cell.item = self.chatMoreKeyboardData![temp_index]
        }
        
        return cell
    }
    
    func transformIndex(_ index: Int) -> Int {
        let page = index/ITEM_COUNT_PAGE
        let currentIndex = index % ITEM_COUNT_PAGE
        let x = currentIndex / 2
        let y = currentIndex % 2
        
        return 4 * y + x + page*ITEM_COUNT_PAGE
    }
    
}

