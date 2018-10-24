//
//  CWDiscoverController.swift
//  CWWeChat
//
//  Created by chenwei on 2017/3/26.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import TableViewManager

class CWDiscoverController: CWBaseTableViewController {

    lazy var tableViewManager: TableViewManager = {
        let tableViewManager = TableViewManager(tableView: self.tableView)
        tableViewManager.delegate = self
        return tableViewManager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "发现"
        
        setupItem()
    }
    
    func setupItem() {
        
        let item1 = MenuItem(iconImageName: CWAsset.Discover_album.rawValue, title: "朋友圈")
        let rightIconURL = "http://img4.duitang.com/uploads/item/201510/16/20151016113134_TZye4.thumb.224_0.jpeg";
        item1.showRightRedPoint = true
        item1.rightIconURL = rightIconURL
        
        let item2 = MenuItem(iconImageName: CWAsset.Discover_QRcode.rawValue, title: "扫一扫")
        let item3 = MenuItem(iconImageName: CWAsset.Discover_shake.rawValue, title: "摇一摇")
        let item4 = MenuItem(iconImageName: CWAsset.Discover_location.rawValue, title: "附近的人")
        let item5 = MenuItem(iconImageName: CWAsset.Discover_bottle.rawValue, title: "漂流瓶")
        let item6 = MenuItem(iconImageName: CWAsset.Discover_shopping.rawValue, title: "购物")
        let item7 = MenuItem(iconImageName: CWAsset.Discover_game.rawValue, title: "游戏")
        
        tableViewManager.append(itemsOf: item1)
        tableViewManager.append(itemsOf: item2, item3)
        tableViewManager.append(itemsOf: item4, item5)
        tableViewManager.append(itemsOf: item6, item7)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension CWDiscoverController: TableViewManagerDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            let controller = CWMomentController()
            controller.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(controller, animated: true)
        } else {
            let url = URL(string: "https://cwwise.com")!
            let gameViewController = CWGameController(url: url)
            gameViewController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(gameViewController, animated: true)
        }

    }
    
}
