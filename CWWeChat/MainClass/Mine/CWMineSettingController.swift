//
//  CWMineSettingController.swift
//  CWWeChat
//
//  Created by chenwei on 2017/4/11.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class CWMineSettingController: CWBaseTableViewController {

    lazy var tableViewManager: CWTableViewManager = {
        return CWTableViewManager(tableView: self.tableView)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "设置"

        setupItemData()
        // Do any additional setup after loading the view.
    }
    
    func setupItemData() {
        
        let item1 = CWTableViewItem(title: "帐户与安全", subTitle: "已保护")
        let section1 = CWTableViewSection(items: [item1])

        let item2 = CWTableViewItem(title: "新消息通知")
        let item3 = CWTableViewItem(title: "隐私")
        let item4 = CWTableViewItem(title: "通用")
        let section2 = CWTableViewSection(items: [item2, item3, item4])

        let item5 = CWTableViewItem(title: "帮助与反馈")
        let item6 = CWTableViewItem(title: "关于微信")
        let section3 = CWTableViewSection(items: [item5, item6])
        
        let item7 = CWTableViewItem(title: "退出微信")
        let section4 = CWTableViewSection(items: [item7])

        tableViewManager.addSection(contentsOf: [section1, section2, section3, section4])

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
