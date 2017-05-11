//
//  CWEmoticonInputView.swift
//  CWWeChat
//
//  Created by chenwei on 2017/4/20.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import YYText.YYTextUtilities

private let kOnePageCount = 23
private let kOneLineItem = 8
private let kViewHeight: CGFloat = 216
private let kOneEmoticonHeight: CGFloat = 50
private let kToolbarHeight: CGFloat = 37

protocol CWEmoticonInputViewDelegate: NSObjectProtocol {
    func emoticonInputDidTapComplete()
    func emoticonInputDidTapBackspace()
    func emoticonInputDidTapText(_ text: String)
}

class CWEmoticonInputView: UIView {
    
    static let shareView: CWEmoticonInputView = {
        let frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kViewHeight)
        return CWEmoticonInputView(frame: frame)
    }()
    
    weak var delegate: CWEmoticonInputViewDelegate?
    
    var collectionView: CWEmoticonScrollView!
    // 表情数组
    var emoticonGroups = [CWEmoticonGroup]()
    var emoticonGroupPageIndexs = [Int]()
    var emoticonGroupPageCounts = [Int]()
    // 当前页面数
    var currentPageIndex: Int = 0
    // 总共页码
    var emoticonGroupTotalPageCount: Int = 0
    
    var sendButton: UIButton = UIButton(type: .custom)

    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(hex: "#E7EFF5")

        setupTopLine()
        setupCollectionView()
        setupToolbar()
    }
    
    func setupTopLine() {
        let line = UIView()
        line.width = self.width
        line.height = YYTextCGFloatFromPixel(1)
        line.backgroundColor = UIColor(hex: "#e9e9e9")
        line.autoresizingMask = .flexibleWidth
        self.addSubview(line)
    }
    
    func setupGroup(_ emoticonGroups: [CWEmoticonGroup]) {
        self.emoticonGroups = emoticonGroups
        var indexs = [Int]()
        var index = 0
        for group in emoticonGroups {
            indexs.append(index)
            var count = ceil(Float(group.emoticons.count) / Float(kOnePageCount))
            if count == 0 {
                count = 1
            }
            index += Int(count)
        }
        emoticonGroupPageIndexs = indexs
        
        var pageCounts = [Int]()
        emoticonGroupTotalPageCount = 0
        
        for group in emoticonGroups {
            var pageCount = ceil(Float(group.emoticons.count) / Float(kOnePageCount))
            if (pageCount == 0) {
                pageCount = 1
            }
            pageCounts.append(Int(pageCount))
            emoticonGroupTotalPageCount += Int(pageCount)
        }
        emoticonGroupPageCounts = pageCounts
        self.collectionView.reloadData()
        
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
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(CWEmoticonCell.self, forCellWithReuseIdentifier: CWEmoticonCell.identifier)
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.top = 5;
        self.addSubview(collectionView)
    }
    
    func setupToolbar() {
        let toolbarFrame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kToolbarHeight)
        let toolbar = UIView(frame: toolbarFrame)
        toolbar.backgroundColor = UIColor(hex: "#EDEDED")
        
        // 按钮
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.alwaysBounceHorizontal = true
        scrollView.size = CGSize(width: toolbar.width-60, height: toolbar.height)
        
        toolbar.bottom = self.height;
        self.addSubview(toolbar)
        
        
        // 完成按钮
        sendButton.frame = CGRect(x: kScreenWidth-60, y: 0, width: 60, height: self.height)
        sendButton.backgroundColor = UIColor(hex: "#3099FA")
        sendButton.setTitle("完成", for: .normal)
        sendButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        sendButton.addTarget(self, action: #selector(sendButtonClick), for: .touchUpInside)
        
        toolbar.addSubview(sendButton)
    }
    
    func emoticonForIndexPath(_ indexPath: IndexPath) -> CWEmoticon? {
        let section = indexPath.section
    
        for i in (0...emoticonGroupPageIndexs.count-1).reversed() {
            
            let pageIndex = emoticonGroupPageIndexs[i]
            if section >= pageIndex {
                
                let group = emoticonGroups[i]
                let page = section - pageIndex
                var index = page * kOnePageCount+indexPath.row
                
                // transpose line/row
                let ip = index / kOnePageCount
                let ii = index % kOnePageCount
                let reIndex = (ii % 3) * kOnePageCount + (ii / 3)
                index = reIndex + ip * kOnePageCount
                
                if index < group.emoticons.count {
                    return group.emoticons[index]
                } else {
                    return nil
                }
            }
            
        }
        
        return nil
    }
    
    func sendButtonClick() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CWEmoticonInputView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return false
    }
}

extension CWEmoticonInputView: CWEmoticonScrollViewDelegate {
    func emoticonScrollViewDidTapCell(_ cell: CWEmoticonCell) {
        
        if cell.isDelete {
            self.delegate?.emoticonInputDidTapBackspace()
        } else if let emoticon = cell.emoticon {
            
            var text: String?
            switch emoticon.type {
            case .image:
                text = emoticon.chs
            default: break
                
            }
            
            if let text = text {
                self.delegate?.emoticonInputDidTapText(text)
            }
        }
    }
}

extension CWEmoticonInputView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return emoticonGroupTotalPageCount
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return kOnePageCount+1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CWEmoticonCell.identifier, for: indexPath) as! CWEmoticonCell
        if indexPath.row == kOnePageCount {
            cell.isDelete = true
            cell.emoticon = nil
        } else {
            cell.isDelete = false
            cell.emoticon = self.emoticonForIndexPath(indexPath)
        }
        
        return cell
    }
    
    
}

