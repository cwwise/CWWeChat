//
//  CWMyExpressionViewController.swift
//  CWWeChat
//
//  Created by chenwei on 16/7/11.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

/// 我的表情
class CWMyExpressionViewController: CWSettingViewController {

    lazy var rightBarButtonItem: UIBarButtonItem = {
        let rightBarButtonItem = UIBarButtonItem(title: "排序", style: .Plain,target: self, action: #selector(rightBarButtonDown))
        return rightBarButtonItem
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "我的表情"
        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
        self.navigationItem.rightBarButtonItem = self.rightBarButtonItem
        
        //模态视图需要添加取消
        if self.navigationController?.viewControllers.first == self {
            let cancleItem = UIBarButtonItem(title: "取消", style: .Plain, target: self, action: #selector(CWExpressionViewController.cancelBarButtonDown))
            self.navigationItem.leftBarButtonItem = cancleItem
        }
    }
    
    func cancelBarButtonDown() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func rightBarButtonDown() {
        
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
