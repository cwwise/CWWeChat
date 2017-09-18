//
//  EmoticonInputView.swift
//  CWWeChat
//
//  Created by wei chen on 2017/7/19.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

struct EmoticonGroupInfo {
    /// 行
    let row: Int     
    /// 列
    let column: Int  
    /// 页数
    let page: Int    
    /// 当前页数
    var currentIndex: Int = 0
    /// 每页表情的数量
    var onePageCount: Int {
        return row*column
    }
}

private let kEmoticonHeight: CGFloat = 50
private let kToolViewHeight: CGFloat = 37

public protocol EmoticonInputViewDelegate: class {
    
    func emoticonInputView(_ inputView: EmoticonInputView, didSelect emoticon: Emoticon)
   
    func didPressDelete(_ inputView: EmoticonInputView)

    func didPressSend(_ inputView: EmoticonInputView)
}

public class EmoticonInputView: UIView {

    weak var delegate: EmoticonInputViewDelegate?
    
    fileprivate var groupList = [EmoticonGroup]()
    fileprivate var groupInfoList = [EmoticonGroupInfo]()
    
    var collectionView: UICollectionView!
    var pageControl: UIPageControl!
    var toolView: EmoticonToolView!
    
    var selectIndex: Int = 0
    
    convenience init() {
        let frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kMoreInputViewHeight)
        self.init(frame: frame)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    func setupUI() {
        self.backgroundColor = UIColor(hex: "#E4EBF0")
        setupCollectionView()
        setupPageControl()
        setupToolView()
    }
        
    func setupCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.bounds.width, height: 160)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        
        let frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: 160)
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(EmoticonPageCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self;
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        self.addSubview(collectionView)
    }
    
    func setupPageControl() {
        let frame = CGRect(x: 0, y: collectionView.bottom, width: self.bounds.width, height: 15)
        pageControl = UIPageControl(frame: frame)
        pageControl.currentPageIndicatorTintColor = UIColor(hex: "#8B8B8B")
        pageControl.pageIndicatorTintColor = UIColor(hex: "#D6D6D6")
        self.addSubview(pageControl)
    }
    
    func setupToolView() {
        let frame = CGRect(x: 0, y: self.height - kToolViewHeight, width: self.bounds.width, height: kToolViewHeight)
        toolView = EmoticonToolView(frame: frame)
        toolView.delegate = self
        self.addSubview(toolView)
    }
    
    func loadData(_ data: [EmoticonGroup]) {
        
        if data == groupList {
            return
        }
        groupList = data
        
        // 计算数据
        for group in groupList {
            
            var row: Int = 0
            var column: Int = 0
            var page: Int = 0

            if group.type == .normal {
                row = 3
                column = 8
                page = Int(ceil(Float(group.count) / Float(row*column-1)))
            } else {
                row = 2
                column = 4
                // 不需要删除按钮
                page = Int(ceil(Float(group.count) / Float(row*column)))
            }
            let info = EmoticonGroupInfo(row: row, column: column, page: page, currentIndex: 0)
            groupInfoList.append(info)
        }
        selectIndex = 0
        pageControl.numberOfPages = groupInfoList[selectIndex].page
        pageControl.currentPage = 0
        collectionView.reloadData()
        toolView.loadData(groupList)
    }
    
    func reload() {
        
        pageControl.numberOfPages = groupInfoList[selectIndex].page
        pageControl.currentPage = groupInfoList[selectIndex].currentIndex
        
        let indexPath = IndexPath(row: selectIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension EmoticonInputView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groupList.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! EmoticonPageCell
       
        cell.group = groupList[indexPath.row]
        cell.groupInfo = groupInfoList[indexPath.row]
        cell.delegate = self
        
        return cell
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension EmoticonInputView: UIScrollViewDelegate {
    
    // 切换表情组
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let currentIndex = Int(scrollView.contentOffset.x / scrollView.width)
        if selectIndex == currentIndex {
            return
        }
        selectIndex = currentIndex
        
        var currentInfo = groupInfoList[selectIndex]
        // 从右向左 滚动
        if scrollView.panGestureRecognizer.translation(in: self).x > 0 {
            currentInfo.currentIndex = currentInfo.page - 1
        } else {
            currentInfo.currentIndex = 0
        }
        // 设置 pageControl
        pageControl.numberOfPages = currentInfo.page
        pageControl.currentPage = currentInfo.currentIndex

        // 切换toolView
        toolView.updateEmoticonGroup(selectIndex)
        
        // 需要刷新 cell
        
    }
}

//MARK: EmoticonToolViewDelegate
extension EmoticonInputView: EmoticonToolViewDelegate {
    
    // 这个是否需要直接把button事件添加到 EmoticonInputView
    func didPressSend() {
        self.delegate?.didPressSend(self)
    }
    
    func didChangeEmoticonGroup(_ index: Int) {
        selectIndex = index
        reload()
    }
    
}

extension EmoticonInputView: EmoticonPageCellDelegate {

    func emoticonPageCell(_ cell: EmoticonPageCell, didSelect emoticon: Emoticon?) {
        if let emoticon = emoticon {
            self.delegate?.emoticonInputView(self, didSelect: emoticon)
        } else {
            //删除按钮
            self.delegate?.didPressDelete(self)
        }
    }
    
    func emoticonPageCell(_ cell: EmoticonPageCell, didScroll index: Int) {
        pageControl.currentPage = index
        groupInfoList[selectIndex].currentIndex = index
    }
}

