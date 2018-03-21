//
//  CWEmoticonDetailController.swift
//  CWWeChat
//
//  Created by wei chen on 2017/8/23.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import Kingfisher

/// 表情包详情界面
class CWEmoticonDetailController: UIViewController {

    var collectionView: UICollectionView!
    
    var emoticonPackage: EmoticonPackage!
    
    var lastSelectCell: EmoticonDetailCell?
    // 长按预览表情
    var magnifierImageView: UIImageView!
    var magnifierContentView: AnimatedImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupMagnifier()
        // 判断是否需要刷新
        if emoticonPackage.emoticonList.count == 0 {
            EmoticonService.shared.fetchPackageDetail(with: emoticonPackage.id,
                                                      complete: { (package, success) in
                
                                                        if success {
                                                            self.emoticonPackage.emoticonList = package!.emoticonList
                                                            self.collectionView.reloadData()

                                                        }
                                    
                                                        
            })

        }
        
    }
    
    func setupUI() {
        self.title = emoticonPackage.name
        
        let layout = UICollectionViewFlowLayout()
        let width = ceil((kScreenWidth - 2*27 - 3*15)/4)
        layout.itemSize = CGSize(width: width, height: width)
        layout.sectionInset = UIEdgeInsets(top: 20, left: 27, bottom: 10, right: 27)
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 15
        layout.headerReferenceSize = CGSize(width: kScreenWidth, height: 340)
        layout.footerReferenceSize = CGSize(width: kScreenWidth, height: 200)

        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(EmoticonDetailCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(EmoticonDetailHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        collectionView.register(EmoticonDetailFooterView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer")
        self.view.addSubview(collectionView)
        
        let long = UILongPressGestureRecognizer(target: self, action: #selector(longPressAction(_:)))
        collectionView.addGestureRecognizer(long)
    }
    
    func setupMagnifier() {
        // 背景图
        magnifierImageView = UIImageView()
        magnifierImageView.isHidden = true
        magnifierImageView.frame = CGRect(x: 0, y: 0, width: 140, height: 155)
        magnifierImageView.image = backgroundImage()
        // 表情展示
        magnifierContentView = AnimatedImageView()
        magnifierContentView.contentMode = .scaleAspectFit
        magnifierImageView.addSubview(magnifierContentView)
        
        magnifierContentView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 10, left: 10, bottom: 25, right: 10))
        }
        self.view.addSubview(magnifierImageView)
    }
    
    func backgroundImage() -> UIImage? {
        
        // 合成背景图
        let leftImage = UIImage(named: "EmoticonBigTipsLeft")?.resizableImage()
        let midImage = UIImage(named: "EmoticonBigTipsMiddle")
        let rightImage = UIImage(named: "EmoticonBigTipsRight")?.resizableImage()
        
        let height: CGFloat = 155
        let width: CGFloat = 140

        let size = CGSize(width: width, height: height)
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        
        let leftWidth: CGFloat = (width - 30)/2
        
        leftImage?.draw(in: CGRect(x: 0, y: 0, width: leftWidth, height: height))
        midImage?.draw(in: CGRect(x: leftWidth, y: 0, width: 30, height: height))
        rightImage?.draw(in: CGRect(x: leftWidth+30, y: 0, width: leftWidth, height: height))

        let resultImg = UIGraphicsGetImageFromCurrentImageContext()

        return resultImg
    }
    
    @objc func longPressAction(_ gesture: UILongPressGestureRecognizer) {
        
        if gesture.state == .ended {
            magnifierImageView.isHidden = true
            lastSelectCell?.isSelected = false
            return
        }
        
        let position = gesture.location(in: self.collectionView)
        guard let indexPath = collectionView.indexPathForItem(at: position),
            let cell = collectionView.cellForItem(at: indexPath) as? EmoticonDetailCell else {
            return
        }
        
        magnifierImageView.isHidden = false
        cell.isSelected = true

        if cell == lastSelectCell {
            return
        }
        
        lastSelectCell?.isSelected = false
        // 取消之前cell选中状态
        lastSelectCell = cell
        
        let frame = cell.convert(cell.bounds, to: self.view)
        magnifierContentView.image = cell.imageView.image
        
        magnifierImageView.centerX = frame.midX
        magnifierImageView.bottom = frame.minY
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension CWEmoticonDetailController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emoticonPackage.emoticonList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! EmoticonDetailCell
        let emoticon = emoticonPackage.emoticonList[indexPath.row]
        
        cell.imageView.kf.setImage(with: emoticon)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionElementKindSectionHeader {
            
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as! EmoticonDetailHeaderView
            header.emoticonPackage = emoticonPackage
            return header
            
        } else {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer", for: indexPath) as! EmoticonDetailFooterView
            footer.emoticonPackage = emoticonPackage
            return footer
        }
    }
    
}




