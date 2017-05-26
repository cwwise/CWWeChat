//
//  CWDiscoverController.swift
//  CWWeChat
//
//  Created by chenwei on 2017/3/26.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class CWDiscoverController: CWMenuViewController {

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



extension CWDiscoverController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            
            let controller = CWMomentController()
            controller.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(controller, animated: true)
            
        } else {
            let url = URL(string: "https://m.weibo.cn")!
            let gameViewController = CWGameController(url: url)
            gameViewController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(gameViewController, animated: true)
        }
    
        
    }
    
}
