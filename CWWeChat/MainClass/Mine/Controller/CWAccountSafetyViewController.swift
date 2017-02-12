//
//  CWAccountSafetyViewController.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/23.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWAccountSafetyViewController: CWBaseTableViewController, CWTableViewManagerDelegate {

    var tableViewManager: CWTableViewManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "账号与安全"
        setupManagerData()
    }
    
    func setupManagerData() {
        
        //
        
        
        tableViewManager = CWTableViewManager(tableView: self.tableView)
        tableViewManager.delegate = self;
        
        let weixinName: Optional = "测试"
        
        var weixinItem: CWTableViewItem
        if weixinName != nil {
            weixinItem = CWTableViewItem(title: weixinName!)
            weixinItem.showDisclosureIndicator = false
        } else {
            weixinItem = CWTableViewItem(title: "")
        }
        
        let section1 = CWTableViewSection(items: [weixinItem])
        tableViewManager.addSection(section: section1)
        
        let qqItem = CWTableViewItem(title: "QQ号", subTitle: "1035264176")
        let phoneItem = CWTableViewItem(title: "手机号", subTitle: "18810109052")
        let emailItem = CWTableViewItem(title: "邮箱地址", subTitle: "wei18810109052@163.com")
        
        let section2 = CWTableViewSection(items: [qqItem, phoneItem, emailItem])
        tableViewManager.addSection(section: section2)
        
        
        let soundItem = CWTableViewItem(title: "声音锁")
        let passwordItem = CWTableViewItem(title: "微信密码")
        let safetyItem = CWTableViewItem(title: "账户保护")
        let weixinSaftItem = CWTableViewItem(title: "微信安全中心")
        let section3 = CWTableViewSection(items: [soundItem, passwordItem, safetyItem, weixinSaftItem])
        tableViewManager.addSection(section: section3)
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
