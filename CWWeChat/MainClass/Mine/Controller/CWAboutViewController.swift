//
//  CWAboutViewController.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/23.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit
import YYText

class CWAboutViewController: CWSettingViewController {
    
    //github链接
    var lienseLabel: UILabel = {
        let lienseLabel = UILabel()
        
        
        
        lienseLabel.text = "高仿微信 仅供学习\nhttps://github.com/wei18810109052/CWWeChat"
        lienseLabel.textAlignment = .center
        lienseLabel.textColor = UIColor.gray
        lienseLabel.font = UIFont.systemFont(ofSize: 12)
        lienseLabel.numberOfLines = 2
        return lienseLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "关于微信"
        
        let helper = CWAboutSettingHelper()
        self.settingDataSource = helper.aboutSettingData
        
        self.tableView.register(CWAboutHeaderView.self, forHeaderFooterViewReuseIdentifier: CWAboutHeaderView.reuseIdentifier)
        
        self.tableView.tableFooterView?.addSubview(self.lienseLabel)
        
        p_addSnap()
        // Do any additional setup after loading the view.
    }
    
    func p_addSnap() {
        
        self.lienseLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.tableView.tableFooterView!)
            make.bottom.equalTo(self.tableView.tableFooterView!).offset(-1)
        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //
        let height: CGFloat = kScreenHeight - self.tableView.contentSize.height - Screen_NavigationHeight - 15;
        self.tableView.tableFooterView?.height = height
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension CWAboutViewController {
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: CWAboutHeaderView.reuseIdentifier) as! CWAboutHeaderView
        headerView.iconPath = "Applogo"
        headerView.title = "微信 CWWeChat \(UIApplication.shared.appVersion)"
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 100
        }
        return 0
    }
}


