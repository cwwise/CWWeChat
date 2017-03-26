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
        let rightBarButtonItem = UIBarButtonItem(title: "排序", style: .plain,target: self, action: #selector(rightBarButtonDown))
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
            let cancleItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(CWExpressionViewController.cancelBarButtonDown))
            self.navigationItem.leftBarButtonItem = cancleItem
        }
        self.tableView.register(CWMyExpressionCell.self, forCellReuseIdentifier: CWMyExpressionCell.reuseIdentifier)
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

extension CWMyExpressionViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let group = self.settingDataSource[(indexPath as NSIndexPath).section];
        if let _ = group.headerTitle {
            let emojiGroup = group.itemObjectAtIndex((indexPath as NSIndexPath).row) as! CWEmojiGroup
            let cell = tableView.dequeueReusableCell(withIdentifier: CWMyExpressionCell.reuseIdentifier) as! CWMyExpressionCell
            cell.group = emojiGroup
            return cell
        }
        
        
        return super.tableView(tableView, cellForRowAt: indexPath)
    }
}
