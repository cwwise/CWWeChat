//
//  CWPhotoBrowserController.swift
//  CWWeChat
//
//  Created by chenwei on 16/7/9.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWPhotoBrowserController: UIViewController {

    lazy private var collectionView:UICollectionView = {
        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: CWPhotoLayout())
        collectionView.pagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.registerClass(CWPhotoCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
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
        self.edgesForExtendedLayout = .All
        self.automaticallyAdjustsScrollViewInsets = false
        self.extendedLayoutIncludesOpaqueBars = true
        self.view.backgroundColor = UIColor.blackColor()
        
        self.view.addSubview(self.collectionView)
        collectionView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(0, 0, 0, -photoPadding))
        }

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(test))
        self.collectionView.addGestureRecognizer(tapGesture)
    }
    
    func test() {
        let state = self.navigationController?.navigationBarHidden
        self.navigationController?.setNavigationBarHidden(!state!, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension CWPhotoBrowserController:UICollectionViewDelegate {
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
}

extension CWPhotoBrowserController:UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoList.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CWPhotoCollectionViewCell
        cell.photoURL = photoList[indexPath.row]
        return cell
    }
    
}
