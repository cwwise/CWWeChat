//
//  CWPhotoBrowserController.swift
//  CWWeChat
//
//  Created by chenwei on 16/7/9.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWPhotoBrowserController: UIViewController {

    lazy fileprivate var collectionView:UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: CWPhotoLayout())
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CWPhotoCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()

    var photoList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addData()
        setupUI()
    }
    
    func addData() {
        for i in 1...20 {
            photoList.append(String(format: "http://7xsmd8.com2.z0.glb.clouddn.com/chatmessage_%03d.jpg", arguments: [i]))
        }
        self.collectionView.reloadData()
        
    }
    
    func setupUI() {
        
        self.title = "图片浏览"
        self.edgesForExtendedLayout = .all
        self.automaticallyAdjustsScrollViewInsets = false
        self.extendedLayoutIncludesOpaqueBars = true
        self.view.backgroundColor = UIColor.black
        
        self.view.addSubview(self.collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(0, 0, 0, -photoPadding))
        }

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(test))
        self.collectionView.addGestureRecognizer(tapGesture)
    }
    
    func test() {
        let state = self.navigationController?.isNavigationBarHidden
        self.navigationController?.setNavigationBarHidden(!state!, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension CWPhotoBrowserController:UICollectionViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
}

extension CWPhotoBrowserController:UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CWPhotoCollectionViewCell
        cell.photoURL = photoList[(indexPath as NSIndexPath).row]
        return cell
    }
    
}
