//
//  CWMyEmoticonListController.swift
//  CWWeChat
//
//  Created by chenwei on 16/7/11.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

/// 我的表情
class CWMyEmoticonListController: UIViewController {

    lazy var rightBarButtonItem: UIBarButtonItem = {
        let rightBarButtonItem = UIBarButtonItem(title: "排序", style: .plain,target: self, action: #selector(rightBarButtonDown))
        return rightBarButtonItem
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "我的表情"
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
        self.navigationItem.rightBarButtonItem = self.rightBarButtonItem
        
        self.view.backgroundColor = UIColor.white
        //模态视图需要添加取消
        if self.navigationController?.viewControllers.first == self {
            let cancleItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(cancelBarButtonDown))
            self.navigationItem.leftBarButtonItem = cancleItem
        }
    }
    
    func cancelBarButtonDown() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func rightBarButtonDown() {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
