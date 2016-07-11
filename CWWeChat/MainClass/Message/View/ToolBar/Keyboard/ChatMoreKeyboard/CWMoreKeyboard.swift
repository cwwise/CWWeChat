//
//  CWMoreKeyboard.swift
//  CWWeChat
//
//  Created by chenwei on 16/7/7.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit


let ITEM_COUNT_PAGE:Int = 8

class CWMoreKeyboard: UIView {
    
    var width_collection_cell: CGFloat = 60
    var height_top_margin: CGFloat = 15
    var height_collectionView: CGFloat {
        return (215*0.85 + height_top_margin)
    }
    
    lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Horizontal
        let height = self.height_collectionView / 2 * 0.93
        let spaceX = (Screen_Width-self.width_collection_cell*4)/5
        let spaceY = self.height_collectionView - 2*height
        layout.itemSize = CGSize(width: self.width_collection_cell, height: height)
        layout.minimumLineSpacing = spaceX
        layout.minimumInteritemSpacing = spaceY
        
        layout.headerReferenceSize = CGSize(width: spaceX, height: self.height_collectionView)
        layout.footerReferenceSize = CGSize(width: spaceX, height: self.height_collectionView)
        
        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clearColor()
        collectionView.pagingEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.scrollsToTop = false
        
        return collectionView
    }()
    
    
    var chatMoreKeyboardData:[CWMoreKeyboardItem]?
    
    init() {
        super.init(frame:CGRectZero)
        backgroundColor = UIColor(hexString: "#F4F4F6")
        addSubview(self.collectionView)
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, 0.5)
        CGContextSetStrokeColorWithColor(context, UIColor.grayColor().CGColor)
        
        CGContextBeginPath(context)
        CGContextMoveToPoint(context, 0, 0)
        CGContextAddLineToPoint(context, Screen_Width, 0)
        CGContextClosePath(context)
        CGContextStrokePath(context)
    }
    
    func addsnap() {
        collectionView.snp_makeConstraints { (make) in
            make.top.equalTo(self).offset(height_top_margin)
            make.left.right.equalTo(self)
            make.height.equalTo(height_collectionView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func registerCellClass()  {
        self.collectionView.registerClass(CWMoreKeyboardCell.self, forCellWithReuseIdentifier: "cell")
    }
    

}

//MARK: 协议
extension CWMoreKeyboard: UICollectionViewDelegate {
    
}


///UICollectionViewDataSource
extension CWMoreKeyboard: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        if let data = self.chatMoreKeyboardData {
            return data.count / ITEM_COUNT_PAGE + ((data.count%ITEM_COUNT_PAGE == 0) ? 0 : 1)
        } else {
            return 0
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ITEM_COUNT_PAGE
    }
    
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CWMoreKeyboardCell
        let index = indexPath.row + indexPath.section * ITEM_COUNT_PAGE
        let temp_index = transformIndex(index)
        
        if temp_index > self.chatMoreKeyboardData?.count {
            cell.item = nil
        } else {
            cell.item = self.chatMoreKeyboardData![temp_index]
        }
        
        return cell
    }
    
    func transformIndex(index: Int) -> Int {
        let page = index/ITEM_COUNT_PAGE
        let currentIndex = index % ITEM_COUNT_PAGE
        let x = currentIndex / 2
        let y = currentIndex % 2
        
        return 4 * y + x + page*ITEM_COUNT_PAGE
    }
    
}

