//
//  CWGameController.swift
//  CWWeChat
//
//  Created by chenwei on 16/7/3.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWGameController: CWWebViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let rightBarButton = UIBarButtonItem(image: CWAsset.Nav_setting.image,
                                             style: .plain,
                                             target: self,
                                             action: #selector(rightBarButtonAction(_:)))
        self.navigationItem.rightBarButtonItem = rightBarButton
        // Do any additional setup after loading the view.
    }
    
    @objc func rightBarButtonAction(_ sender: UIBarButtonItem) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
