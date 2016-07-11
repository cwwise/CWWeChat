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
        
        let helper = CWMineExpressionHelper()
        self.settingDataSource = helper.expressionData
        
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
        self.navigationItem.rightBarButtonItem = self.rightBarButtonItem
        
        //模态视图需要添加取消
        if self.navigationController?.viewControllers.first == self {
            let cancleItem = UIBarButtonItem(title: "取消", style: .Plain, target: self, action: #selector(CWExpressionViewController.cancelBarButtonDown))
            self.navigationItem.leftBarButtonItem = cancleItem
        }
        self.tableView.registerClass(CWMyExpressionCell.self, forCellReuseIdentifier: CWMyExpressionCell.reuseIdentifier)
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

}

extension CWMyExpressionViewController {
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let group = self.settingDataSource[indexPath.section];
        if let _ = group.headerTitle {
            let emojiGroup = group.itemObjectAtIndex(indexPath.row) as! CWEmojiGroup
            let cell = tableView.dequeueReusableCellWithIdentifier(CWMyExpressionCell.reuseIdentifier) as! CWMyExpressionCell
            cell.group = emojiGroup
            return cell
        }
        
        
        return super.tableView(tableView, cellForRowAtIndexPath: indexPath)
    }
}
