//
//  CWAccountSafetyController.swift
//  CWWeChat
//
//  Created by chenwei on 2017/4/11.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class CWAccountSafetyController: CWBaseTableViewController {

    lazy var tableViewManager: CWTableViewManager = {
        let tableViewManager = CWTableViewManager(tableView: self.tableView)
        tableViewManager.delegate = self
        return tableViewManager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "账号与安全"
        
        setupItemData()
    }
    
    
    func setupItemData() {
        
        let weixinName: String? = "chenwei"
        
        var weixinItem: CWTableViewItem
        if weixinName != nil {
            weixinItem = CWTableViewItem(title: "微信号", subTitle: weixinName)
            weixinItem.showDisclosureIndicator = false
        } else {
            weixinItem = CWTableViewItem(title: "")
        }
        
        let section1 = CWTableViewSection(items: [weixinItem])
        tableViewManager.addSection(section1)
        
        let qqItem = CWTableViewItem(title: "QQ号", subTitle: "1035264176")
        let phoneItem = CWTableViewItem(title: "手机号", subTitle: "18810109052")
        let emailItem = CWTableViewItem(title: "邮箱地址", subTitle: "wei18810109052@163.com")
        
        let section2 = CWTableViewSection(items: [qqItem, phoneItem, emailItem])
        tableViewManager.addSection(section2)
        
        
        let soundItem = CWTableViewItem(title: "声音锁")
        let passwordItem = CWTableViewItem(title: "微信密码")
        let safetyItem = CWTableViewItem(title: "账户保护")
        let weixinSaftItem = CWTableViewItem(title: "微信安全中心")
        weixinItem.selectionAction = { (item: CWTableViewItem) in
            let url = URL(string: "https://weixin110.qq.com")!
            let webViewController = CWWebViewController(url: url)
            self.navigationController?.pushViewController(webViewController, animated: true)
        }
        
        let section3 = CWTableViewSection(items: [soundItem, passwordItem, safetyItem, weixinSaftItem])
        tableViewManager.addSection(section3)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


// MARK: - CWTableViewManagerDelegate
extension CWAccountSafetyController: CWTableViewManagerDelegate {
    
    
}
