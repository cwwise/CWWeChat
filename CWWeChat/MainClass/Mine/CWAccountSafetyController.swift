//
//  CWAccountSafetyController.swift
//  CWWeChat
//
//  Created by chenwei on 2017/4/11.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import TableViewManager

class CWAccountSafetyController: CWBaseTableViewController {

    lazy var tableViewManager: TableViewManager = {
        let tableViewManager = TableViewManager(tableView: self.tableView)
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
        
        var weixinItem: Item
        if weixinName != nil {
            weixinItem = Item(title: "微信号", subTitle: weixinName)
            weixinItem.showDisclosureIndicator = false
        } else {
            weixinItem = Item(title: "微信号")
        }
        let phoneItem = Item(title: "手机号", subTitle: "18810109052")

        tableViewManager.append(itemsOf: weixinItem, phoneItem)
        
        let passwordItem = Item(title: "微信密码", subTitle: "已设置")
        let soundItem = Item(title: "声音锁", subTitle: "已开启")
        
        tableViewManager.append(itemsOf: passwordItem, soundItem)
        
        let loginDeviceItem = Item(title: "登陆设备管理")
        let moreDeviceItem = Item(title: "更多安全设置")
        tableViewManager.append(itemsOf: loginDeviceItem, moreDeviceItem)

        let weixinSaftItem = Item(title: "微信安全中心")
        weixinSaftItem.selectionAction = { (item) in
            let url = URL(string: "https://weixin110.qq.com")!
            let webViewController = CWWebViewController(url: url)
            self.navigationController?.pushViewController(webViewController, animated: true)
        }
        
        let footerString = "如果遇到账户信息泄漏, 忘记密码，诈骗等账号安全问题，可前往微信安全中心"
        let section4 = Section(footerTitle: footerString, items: [weixinSaftItem])
        tableViewManager.append(section4)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - TableViewManagerDelegate
extension CWAccountSafetyController: TableViewManagerDelegate {
    
}
