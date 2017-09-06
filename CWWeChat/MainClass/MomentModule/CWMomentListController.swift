//
//  CWMomentListController.swift
//  CWWeChat
//
//  Created by wei chen on 2017/9/5.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import UIKit

class CWMomentListController: UIViewController {

    var momentList = [CWMoment]()
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "分享"
        setupCollectionView()
        // Do any additional setup after loading the view.
    }
    
    func setupCollectionView() {
        
        let layout = CWMomentFlowLayout()
        layout.sectionInset = UIEdgeInsets.zero
        
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(CWMomentCollectionCell.self, forCellWithReuseIdentifier: "cell")
        self.view.addSubview(collectionView)
        
        let dataService = CWMomentDataService()
        momentList = dataService.parseMomentData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension CWMomentListController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return momentList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CWMomentCollectionCell
        return cell
    }
    
}

