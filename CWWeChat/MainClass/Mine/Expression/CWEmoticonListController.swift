//
//  CWExpressionController.swift
//  CWWeChat
//
//  Created by chenwei on 16/7/11.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CWEmoticonListController: UIViewController {

    var segmentedControl: UISegmentedControl!
        
    var rightBarButtonItem: UIBarButtonItem!
    
    var featuredEmoticonController: CWFeaturedEmoticonController!
    var moreEmoticonController: CWMoreEmoticonController!
    
    var currentIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.setupUI()
        
        self.automaticallyAdjustsScrollViewInsets = false

        featuredEmoticonController = CWFeaturedEmoticonController()
        moreEmoticonController = CWMoreEmoticonController()
        
        self.addChildViewController(featuredEmoticonController)
        featuredEmoticonController.view.frame = self.view.bounds
        self.view.addSubview(featuredEmoticonController.view)
    }
    
    func setupUI() {
    
        segmentedControl = UISegmentedControl(items: ["精选表情", "投稿表情"])
        segmentedControl.width = kScreenWidth * 0.55
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedControlChanged(_:)), for: .valueChanged)
        self.navigationItem.titleView = self.segmentedControl
        
        rightBarButtonItem = UIBarButtonItem(image: CWAsset.Nav_setting.image, style: .plain,target: self, action: #selector(rightBarButtonDown))        
        self.navigationItem.rightBarButtonItem = self.rightBarButtonItem

        //模态视图需要添加取消
        if self.navigationController?.viewControllers.first == self {
            let cancleItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(cancelBarButtonDown))
            self.navigationItem.leftBarButtonItem = cancleItem
        }
        
        
        
    }
    
    // MARK: Action
    @objc func cancelBarButtonDown() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func rightBarButtonDown() {
        let myExpression = CWMyEmoticonListController()
        self.navigationController?.pushViewController(myExpression, animated: true)
    }
    
    @objc func segmentedControlChanged(_ segmentedControl: UISegmentedControl)  {
        
        if segmentedControl.selectedSegmentIndex == currentIndex {
            return
        }
        currentIndex = segmentedControl.selectedSegmentIndex
        var oldController: UIViewController
        var newController: UIViewController
        if currentIndex == 0 {
            oldController = moreEmoticonController
            newController = featuredEmoticonController
        } else {
            oldController = featuredEmoticonController
            newController = moreEmoticonController
        }
        
        self.addChildViewController(newController)
        self.transition(from: oldController, to: newController, duration: 0.25, options: .curveEaseInOut, animations: { 
            
        }) { (_) in
             
            newController.didMove(toParentViewController: self)
            oldController.willMove(toParentViewController: self)
            oldController.removeFromParentViewController() 

        }
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}




