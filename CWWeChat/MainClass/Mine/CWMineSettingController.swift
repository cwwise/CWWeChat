//
//  CWMineSettingController.swift
//  CWWeChat
//
//  Created by chenwei on 2017/4/11.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import CWActionSheet
import ChatClient
import TableViewManager

class CWMineSettingController: CWBaseTableViewController {

    lazy var tableViewManager: TableViewManager = {
        let tableViewManager = TableViewManager(tableView: self.tableView)
        return tableViewManager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "设置"

        setupItemData()
        // Do any additional setup after loading the view.
    }
    
    func setupItemData() {

        let item1 = Item(title: "帐户与安全") { (item) in
            let controller = CWAccountSafetyController()
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
        let item2 = Item(title: "新消息通知") { (item) in
            let noticeVC = CWMessageNoticeController()
            self.navigationController?.pushViewController(noticeVC, animated: true)
        }
        let item3 = Item(title: "隐私") { (item) in
            let privacyVC = CWPrivacySettingController()
            self.navigationController?.pushViewController(privacyVC, animated: true)
        }
        let item4 = Item(title: "设备")
        let item5 = Item(title: "通用") { (item) in
            let commonVC = CWCommonSettingController()
            self.navigationController?.pushViewController(commonVC, animated: true)
        }

        let item6 = Item(title: "帮组与反馈") { (item) in
            let url = URL(string: "https://kf.qq.com/touch/product/wechat_app.html")
            let feedbackVC = CWWebViewController(url: url)
            self.navigationController?.pushViewController(feedbackVC, animated: true)
        }
        let item7 = Item(title: "关于微信") { (item) in
            let aboutVC = CWAboutController()
            self.navigationController?.pushViewController(aboutVC, animated: true)
        }
        
        let item8 = Item(title: "插件")

        let item9 = ButtonItem(title: "退出登录") { (item) in
            
            let title = "退出不会删除任何历史数据，下次登录依然可以使用本账户"
            let actionHandle: ActionSheetClickedHandler = { (actionSheet, index) in
                if index == 1 {
                    self.logout()
                }
            }
            let actionSheet = ActionSheetView(title: title,
                                              cancelButtonTitle: "取消",
                                              otherButtonTitles: ["退出登录"],
                                              clickedHandler: actionHandle)
            actionSheet.destructiveButtonIndex = 1
            actionSheet.show()
            
        }

        tableViewManager.append(itemsOf: item1)
        tableViewManager.append(itemsOf: item2,item3,item4,item5)
        tableViewManager.append(itemsOf: item6,item7)
        tableViewManager.append(itemsOf: item8)
        tableViewManager.append(itemsOf: item9)

    }
    
    func logout() {
        do {
            let account = try CWAccount.userAccount()
            account.isLogin = false
            try account.save()
        } catch {
        }
        let loginManager = ChatClient.share.loginManager
        loginManager.logout()
        if let appdelegate = UIApplication.shared.delegate as? AppDelegate {
            appdelegate.logoutSuccess()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CWMineSettingController: TableViewManagerDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        
    }
    
}


