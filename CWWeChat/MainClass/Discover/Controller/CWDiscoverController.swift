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
        
        if #available(iOS 9.0, *) {
            self.registerForPreviewing(with: self, sourceView: view)
        } else {
            // Fallback on earlier versions
        }
        
        let discoverHelper = CWDiscoverHelper()
        self.dataSource = discoverHelper.discoverMenuData
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension CWDiscoverController: UIViewControllerPreviewingDelegate {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        show(viewControllerToCommit, sender: self)
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {

        // Obtain the index path and the cell that was pressed.
        guard let indexPath = tableView.indexPathForRow(at: location),
            let cell = tableView.cellForRow(at: indexPath) else { return nil }
        
        // Create a detail view controller and set its properties.
        let viewController = UIViewController()
        
        
        /*
         Set the height of the preview by setting the preferred content size of the detail view controller.
         Width should be zero, because it's not used in portrait.
         */
        viewController.preferredContentSize = CGSize(width: 0.0, height: 120)
        
        // Set the source rect to the cell frame, so surrounding elements are blurred.
        if #available(iOS 9.0, *) {
            previewingContext.sourceRect = cell.frame
        } else {
            // Fallback on earlier versions
        }
        
        return viewController
    }
    
}


extension CWDiscoverController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = URL(string: "https://m.weibo.cn")!
        let gameViewController = CWGameController(url: url)
        gameViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(gameViewController, animated: true)
        
    }
    
}
