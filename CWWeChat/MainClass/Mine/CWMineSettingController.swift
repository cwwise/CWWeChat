//
//  CWMineSettingController.swift
//  CWWeChat
//
//  Created by chenwei on 2017/4/11.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import CWActionSheet

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
        item1.selectionAction = {  (item: CWTableViewItem) in
            let controller = CWAccountSafetyController()
            self.navigationController?.pushViewController(controller, animated: true)
        }
        let section1 = CWTableViewSection(items: [item1])

        let item2 = CWTableViewItem(title: "新消息通知")
        item2.selectionAction = { (item) in
            let noticeVC = CWMessageNoticeController()
            self.navigationController?.pushViewController(noticeVC, animated: true)
        }
        
        let item3 = CWTableViewItem(title: "隐私")
        item3.selectionAction = { (item) in
            let privacyVC = CWPrivacySettingController()
            self.navigationController?.pushViewController(privacyVC, animated: true)
        }
        
        let item4 = CWTableViewItem(title: "通用")
        item4.selectionAction = { (item) in
            let commonVC = CWCommonSettingController()
            self.navigationController?.pushViewController(commonVC, animated: true)
        }
        let section2 = CWTableViewSection(items: [item2, item3, item4])

        let item5 = CWTableViewItem(title: "帮助与反馈")
        item5.selectionAction = { (item) in
            let url = URL(string: "https://kf.qq.com/touch/product/wechat_app.html")
            let feedbackVC = CWWebViewController(url: url)
            self.navigationController?.pushViewController(feedbackVC, animated: true)
        }
        
        let item6 = CWTableViewItem(title: "关于微信")
        item6.selectionAction = { (item) in
            let aboutVC = CWAboutController()
            self.navigationController?.pushViewController(aboutVC, animated: true)
        }
        let section3 = CWTableViewSection(items: [item5, item6])
        
        let item7 = CWButtonItem(title: "退出微信")
        item7.selectionAction = { (item) in
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
        let section4 = CWTableViewSection(items: [item7])
        tableViewManager.addSection(contentsOf: [section1, section2, section3, section4])        
    }
    
    func logout() {
        CWChatClient.share.loginManager.logout()
        if let appdelegate = UIApplication.shared.delegate as? AppDelegate {
            appdelegate.logoutSuccess()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
