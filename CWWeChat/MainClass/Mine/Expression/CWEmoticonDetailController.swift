//
//  CWEmoticonDetailController.swift
//  CWWeChat
//
//  Created by wei chen on 2017/8/23.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class CWEmoticonDetailController: UIViewController {

    var collectionView: UICollectionView!
    
    var emoticonPackage: EmoticonPackage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 判断是否需要刷新
        if emoticonPackage.emoticonList.count == 0 {
            EmoticonService.shared.fetchPackageDetail(with: emoticonPackage.id,
                                                      complete: { (package, success) in
                
                                    
                                                        
                
                
            })

        }
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
