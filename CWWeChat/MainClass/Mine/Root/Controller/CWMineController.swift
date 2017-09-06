//
//  CWMineController.swift
//  CWWeChat
//
//  Created by chenwei on 2017/3/26.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class CWMineController: CWMenuViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mineHelper = CWMineHelper()
        self.dataSource = mineHelper.mineMenuData
        
        self.tableView.register(CWMineUserCell.self, forCellReuseIdentifier: "cell")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension CWMineController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 87
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CWMineUserCell
            let model = CWUserModel(userId: "chenwei", username: "chenwei")
            model.nickname = "陈威"
            model.avatarURL = URL(string: "\(kImageBaseURLString)\(model.userId).jpg")
            
            cell.userModel = model
            return cell
        }
        return super.tableView(tableView, cellForRowAt: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        
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

