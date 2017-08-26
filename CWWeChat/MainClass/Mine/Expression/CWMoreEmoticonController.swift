//
//  CWMoreEmoticonController.swift
//  CWWeChat
//
//  Created by chenwei on 2017/8/24.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

/// 更多表情Controller
class CWMoreEmoticonController: UIViewController {

    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

extension CWMoreEmoticonController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        return cell
    }
    
}

