//
//  CWEmoticonToolView.swift
//  CWWeChat
//
//  Created by wei chen on 2017/7/19.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

private let kItemWidth: CGFloat = 45
private let kDurationTime: TimeInterval = 0.15

protocol EmoticonToolViewDelegate {
    
    func didPressSend()
    // 切换表情数组
    func didChangeEmoticonGroup(_ index: Int)
}

/// 表情标签
class EmoticonToolView: UIView {

    var delegate: EmoticonToolViewDelegate?
    /// 数据源
    var groupList: [EmoticonGroup] = [EmoticonGroup]()
    
    var selectIndex: Int = 0
    
    lazy var collectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: kItemWidth, height: self.frame.height)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        collectionView.register(EmoticonToolItemCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = .white
        collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.scrollsToTop = false
        collectionView.alwaysBounceHorizontal = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()

    // 发送按钮
    let sendButton: UIButton = {
       let sendButton = UIButton(type: .custom)
        sendButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        sendButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        sendButton.setTitle("发送", for: .normal)
        sendButton.setTitleColor(.white, for: .normal)
        sendButton.setTitleColor(.lightGray, for: .highlighted)
        sendButton.setTitleColor(.gray, for: .disabled)
        
        sendButton.setBackgroundImage(UIImage(named: "EmotionsSendBtnBlue"), for: .normal)
        sendButton.setBackgroundImage(UIImage(named: "EmotionsSendBtnBlueHL"), for: .highlighted)
        sendButton.setBackgroundImage(UIImage(named: "EmotionsSendBtnGrey"), for: .disabled)
        
        sendButton.isEnabled = true
        sendButton.addTarget(self, action: #selector(sendButtonClick), for: .touchUpInside)
        return sendButton
    }()
    
    // 设置
    let settingButton: UIButton = {
        let settingButton = UIButton(type: .custom)
        
        settingButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        settingButton.setImage(UIImage(named: "EmotionsSetting"), for: .normal)
        settingButton.setBackgroundImage(UIImage(named: "EmotionsSendBtnGrey"), for: .normal)
        settingButton.setBackgroundImage(UIImage(named: "EmotionsSendBtnGrey"), for: .highlighted)
    
        return settingButton
    }()
    
    lazy var addButton: UIButton = {
        let addButton = UIButton(type: .custom)
        addButton.setImage(UIImage(named: "EmotionsBagAdd"), for: .normal)
        addButton.frame = CGRect(x: 0, y: 0, width: kItemWidth, height: self.height)

        // 添加一条线
        let line: CALayer = CALayer()
        line.backgroundColor = UIColor(white: 0.9, alpha: 1.0).cgColor
        line.frame = CGRect(x: kItemWidth-0.5, y: 8, width: 0.5, height: self.height - 2*8)
        addButton.layer.addSublayer(line)
        
        return addButton
    }()
    
    func loadData(_ groupList: [EmoticonGroup]) {
        if groupList == self.groupList {
            return
        }
        self.groupList = groupList
        self.collectionView.reloadData()
        
        let firstIndex = IndexPath(row: selectIndex, section: 0)
        self.collectionView.selectItem(at: firstIndex, animated: false, scrollPosition: .centeredHorizontally)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        self.addSubview(addButton)
        self.addSubview(collectionView)
        
        self.addSubview(sendButton)
        self.addSubview(settingButton)
        
        collectionView.frame = CGRect(x: addButton.right, y: 0, width: self.width-kItemWidth, height: self.height)
        
        let buttonWidth: CGFloat = 52
        sendButton.frame = CGRect(x: self.width-buttonWidth, y: 0, width: buttonWidth, height: self.height)
        settingButton.frame = CGRect(x: self.width, y: 0, width: buttonWidth, height: self.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateEmoticonGroup(_ index: Int) {
        selectIndex = index
        changeAnimate(index == 0)
        let indexPath = IndexPath(row: selectIndex, section: 0)
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
    
    
    @objc func sendButtonClick() {
        self.delegate?.didPressSend()
    }

}

extension EmoticonToolView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if indexPath.row == selectIndex {
            return
        }
        selectIndex = indexPath.row
        
        changeAnimate(indexPath.row == 0)
        // 通知代理
        self.delegate?.didChangeEmoticonGroup(indexPath.row)
    }
    
    func changeAnimate(_ showSendButton: Bool) {
                
        // 切换动画
        // 是一个 显示发送按钮
        if showSendButton {
            UIView.animate(withDuration: kDurationTime, delay: 0, options: .curveEaseInOut, animations: { 
                self.settingButton.left = self.width
            }, completion: { (finshed) in
                UIView.animate(withDuration: kDurationTime, delay: 0, options: .curveEaseInOut, animations: { 
                    self.sendButton.left = self.width-self.sendButton.width            
                }, completion: { (finshed) in
                    
                })
            })
        } else {
            UIView.animate(withDuration: kDurationTime, delay: 0, options: .curveEaseInOut, animations: { 
                self.sendButton.left = self.width            
            }, completion: { (finshed) in
                UIView.animate(withDuration: kDurationTime, delay: 0, options: .curveEaseInOut, animations: { 
                    self.settingButton.left = self.width-self.settingButton.width            
                }, completion: { (finshed) in
                    
                })
            })
        }  
        
    }
    
}

extension EmoticonToolView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groupList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! EmoticonToolItemCell
        
        cell.imageView.image = UIImage(contentsOfFile: groupList[indexPath.row].iconPath)

        return cell
    }
    
}

