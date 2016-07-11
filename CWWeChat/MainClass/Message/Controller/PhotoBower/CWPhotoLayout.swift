//
//  CWPhotoLayout.swift
//  CWWeChat
//
//  Created by chenwei on 16/7/9.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWPhotoLayout: UICollectionViewFlowLayout {
    
    override init(){
        
        super.init()
        /**  配置  */
        layoutSetting()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    /**  配置  */
    func layoutSetting(){
        
        let size = UIScreen.mainScreen().bounds.size
        self.itemSize = CGSize(width: size.width+photoPadding, height: size.height)
        
        self.minimumInteritemSpacing = 0
        self.minimumLineSpacing = 0
        self.sectionInset = UIEdgeInsetsZero
        self.scrollDirection = UICollectionViewScrollDirection.Horizontal
    }
    
}
