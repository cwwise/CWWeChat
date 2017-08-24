//
//  CWEmoticonDetailController.swift
//  CWWeChat
//
//  Created by wei chen on 2017/8/23.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

/// 表情包详情界面
class CWEmoticonDetailController: UIViewController {

    var collectionView: UICollectionView!
    
    var emoticonPackage: EmoticonPackage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        // 判断是否需要刷新
        if emoticonPackage.emoticonList.count == 0 {
            EmoticonService.shared.fetchPackageDetail(with: emoticonPackage.id,
                                                      complete: { (package, success) in
                
                                    
                                                        
                
                
            })

        }
        
    }
    
    func setupUI() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 220/3, height: 260/2)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        
        
        
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(EmoticonDetailCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(EmoticonDetailHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        collectionView.register(EmoticonDetailFooterView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer")
        self.view.addSubview(collectionView)
        
        let long = UILongPressGestureRecognizer(target: self, action: #selector(longPressAction(_:)))
        collectionView.addGestureRecognizer(long)
    }
    
    func longPressAction(_ gesture: UILongPressGestureRecognizer) {
        
        let position = gesture.location(in: self.collectionView)
        guard let indexPath = collectionView.indexPathForItem(at: position),
            let cell = collectionView.cellForItem(at: indexPath) as? EmoticonDetailCell else {
            return
        } 
    
        let _ = cell.imageView.image
        
        
        
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




