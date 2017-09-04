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

    lazy var searchController: CWSearchController = {
        let searchController = CWSearchController(searchResultsController: self.searchResultController)
        searchController.searchResultsUpdater = self.searchResultController
        searchController.searchBar.placeholder = "搜索"
        searchController.searchBar.delegate = self
        searchController.showVoiceButton = true
        return searchController
    }()
    
    //搜索结果
    var searchResultController: CWSearchResultController = {
        let searchResultController = CWSearchResultController()
        return searchResultController
    }()
    
    var collectionView: UICollectionView!
    
    var bannerList: [EmoticonPackage] = []
    var packageList: [EmoticonPackage] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        // banner
        EmoticonService.shared.fetchRecommendList { (list, success) in
            if success {
                self.bannerList = list
                self.collectionView.reloadData()
            }
        }
        
        let tag2 = "热门表情"
        EmoticonService.shared.fetchPackageList(tag: [tag2]) { (list, success) in
            if success {
                self.packageList.append(contentsOf: list)
                self.collectionView.reloadData()
            }
        }
        
    }
    
    func setupUI() {
        
        let layout = UICollectionViewFlowLayout()
        let width = ceil((kScreenWidth - 2*16 - 2*17)/3)
        layout.itemSize = CGSize(width: width, height: width+20+8)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 15
        layout.headerReferenceSize = CGSize(width: kScreenWidth, height: 150)
        
        let frame = CGRect(x: 0, y: kNavigationBarHeight, 
                           width: kScreenWidth, height: kScreenHeight-kNavigationBarHeight)
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        
        
        collectionView.register(MoreEmoticonBannerCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        collectionView.register(MoreEmoticonCell.self, forCellWithReuseIdentifier: "cell")
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
        return packageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MoreEmoticonCell
        
        let package = packageList[indexPath.row]
        cell.itemButton.kf.setImage(with: package.cover, for: .normal)
        cell.itemLabel.text = package.name
        
        cell.touchAction = { (cell) in
            
            let controller = CWEmoticonDetailController()
            controller.emoticonPackage = package
            self.navigationController?.pushViewController(controller, animated: true)
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as! MoreEmoticonBannerCell
        header.emoticonList = bannerList
        return header
    }
    
}

extension CWMoreEmoticonController: UISearchBarDelegate {
    
    
    
    
}

