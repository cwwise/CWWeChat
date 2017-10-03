//
//  CWMineController.swift
//  CWWeChat
//
//  Created by chenwei on 2017/3/26.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import TableViewManager

class CWMineController: CWBaseTableViewController {

    lazy var tableViewManager: TableViewManager = {
        let tableViewManager = TableViewManager(tableView: self.tableView)
        tableViewManager.dataSource = self
        tableViewManager.delegate = self
        return tableViewManager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(CWMineUserCell.self, forCellReuseIdentifier: "cell")
        setupItem()
    }
    
    func setupItem() {
        //占位
        let item1 = MenuItem(iconImageName: "", title: "")
        item1.cellHeight = 87
        
        let item2 = MenuItem(iconImageName: CWAsset.Mine_wallet.rawValue, title: "钱包")

        let item3 = MenuItem(iconImageName: CWAsset.Mine_favorites.rawValue, title: "收藏")
        let item4 = MenuItem(iconImageName: CWAsset.Mine_album.rawValue, title: "相册")
        let item5 = MenuItem(iconImageName: CWAsset.Mine_card.rawValue, title: "卡包")
        let item6 = MenuItem(iconImageName: CWAsset.Mine_expression.rawValue, title: "表情")
        
        let item7 = MenuItem(iconImageName: CWAsset.Mine_setting.rawValue, title: "设置")
        
        tableViewManager.append(itemsOf: item1)
        tableViewManager.append(itemsOf: item2)
        tableViewManager.append(itemsOf: item3,item4,item5,item6)
        tableViewManager.append(itemsOf: item7)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension CWMineController: TableViewManagerDataSource, TableViewManagerDelegate {
 
    func tableViewManager(_ tableViewManager: TableViewManager, cellForRowAt indexPath: IndexPath) -> UITableViewCell? {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CWMineUserCell
            let model = CWUserModel(userId: "chenwei", username: "chenwei")
            model.nickname = "陈威"
            model.avatarURL = URL(string: "\(kImageBaseURLString)\(model.userId).jpg")
            
            cell.userModel = model
            return cell
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            let personVC = CWPersonalInfoController()
            personVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(personVC, animated: true)
        }
        else if indexPath.section == 1 {
            
            return
        }
        else if indexPath.section == 2 {
            
            let expressionVC = CWEmoticonListController()
            expressionVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(expressionVC, animated: true)
        } else {
            let settingVC = CWMineSettingController()
            settingVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(settingVC, animated: true)
        }
        
    }
}

