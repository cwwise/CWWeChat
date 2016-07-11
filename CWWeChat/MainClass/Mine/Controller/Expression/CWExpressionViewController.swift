//
//  CWExpressionViewController.swift
//  CWWeChat
//
//  Created by chenwei on 16/7/11.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWExpressionViewController: UIViewController {

    lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["精选表情", "投稿表情"])
        segmentedControl.width = Screen_Width * 0.55
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(CWExpressionViewController.segmentedControlChanged(_:)), forControlEvents: .EditingChanged)
        return segmentedControl
    }()
        
    lazy var rightBarButtonItem: UIBarButtonItem = {
        let rightBarButtonItem = UIBarButtonItem(image: CWAsset.Nav_setting.image, style: .Plain,target: self, action: #selector(CWExpressionViewController.rightBarButtonDown))
    return rightBarButtonItem
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        self.setupUI()

        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
        self.navigationItem.titleView = self.segmentedControl
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
        let myExpression = CWMyExpressionViewController()
        self.navigationController?.pushViewController(myExpression, animated: true)
    }
    
    func segmentedControlChanged(segmentedControl: UISegmentedControl)  {
        
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
