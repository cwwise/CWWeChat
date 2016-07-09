//
//  CWPhotoBrowserController.swift
//  CWWeChat
//
//  Created by chenwei on 16/7/9.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWPhotoBrowserController: UIViewController {

    private var collectionView:UICollectionView!
    private var pageControl:UIPageControl!
    var photoList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func addData() {
        for i in 1...20 {
            photoList.append(String(format: "http://7xsmd8.com2.z0.glb.clouddn.com/chatmessage_%03d.jpg", arguments: [i]))
        }
        collectionView.reloadData()
        
    }
    
    func setupUI() {
        
        self.title = "图片浏览"
        self.edgesForExtendedLayout = .All
        self.automaticallyAdjustsScrollViewInsets = false
        self.extendedLayoutIncludesOpaqueBars = true
        self.view.backgroundColor = UIColor.blackColor()
        
        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: CWPhotoLayout())
        self.view.addSubview(collectionView)
        
        collectionView.pagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(0, 0, 0, -photoPadding))
        }
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.registerClass(CWPhotoCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        setupPageControl()
        //        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ChatPhotoBrowserController.test))
        //        self.collectionView.addGestureRecognizer(tapGesture)
    }
    
    
    func test() {
        let state = self.navigationController?.navigationBarHidden
        self.navigationController?.setNavigationBarHidden(!state!, animated: true)
    }
    
    
    func setupPageControl() {
        pageControl = UIPageControl()
        pageControl.frame = CGRect(x: 0, y: Screen_Height-80, width: Screen_Width, height: 40)
        pageControl.numberOfPages = photoList.count
        pageControl.currentPageIndicatorTintColor = UIColor.whiteColor()
        pageControl.pageIndicatorTintColor = UIColor.grayColor()
        self.view.addSubview(pageControl)
        if photoList.count == 1 {
            pageControl.hidden = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CWPhotoBrowserController:UICollectionViewDelegate {
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5)
        pageControl.currentPage = page
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
