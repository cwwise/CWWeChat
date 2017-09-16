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
        let phoneItem = CWTableViewItem(title: "手机号", subTitle: "18810109052")

        let section1 = CWTableViewSection(items: [weixinItem, phoneItem])
        tableViewManager.addSection(section1)
        
        let passwordItem = CWTableViewItem(title: "微信密码", subTitle: "已设置")
        let soundItem = CWTableViewItem(title: "声音锁", subTitle: "已开启")
        
        let section2 = CWTableViewSection(items: [passwordItem, soundItem])
        tableViewManager.addSection(section2)
        
        let loginDeviceItem = CWTableViewItem(title: "登陆设备管理")
        let moreDeviceItem = CWTableViewItem(title: "更多安全设置")
        let section3 = CWTableViewSection(items: [loginDeviceItem, moreDeviceItem])
        tableViewManager.addSection(section3)

        let weixinSaftItem = CWTableViewItem(title: "微信安全中心")
        weixinSaftItem.selectionAction = { (item: CWTableViewItem) in
            let url = URL(string: "https://weixin110.qq.com")!
            let webViewController = CWWebViewController(url: url)
            self.navigationController?.pushViewController(webViewController, animated: true)
        }
        
        let footerString = "如果遇到账户信息泄漏, 忘记密码，诈骗等账号安全问题，可前往微信安全中心"
        let section4 = CWTableViewSection(footerTitle: footerString, items: [weixinSaftItem])
        tableViewManager.addSection(section4)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


// MARK: - CWTableViewManagerDelegate
extension CWAccountSafetyController: CWTableViewManagerDelegate {
    
}
