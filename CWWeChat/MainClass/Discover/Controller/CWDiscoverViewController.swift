//
//  CWDiscoverViewController.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/22.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWDiscoverViewController: CWMenuViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "发现"
        
        let discoverHelper = CWDiscoverHelper()
        self.dataSource = discoverHelper.discoverMenuData
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension CWDiscoverViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let gameViewController = CWGameViewController()
        gameViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(gameViewController, animated: true)
        
    }
    
}
