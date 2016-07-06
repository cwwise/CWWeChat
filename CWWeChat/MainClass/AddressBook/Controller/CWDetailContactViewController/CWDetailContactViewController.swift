//
//  CWDetailContactViewController.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/28.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWDetailContactViewController: CWInformationViewController {

    var contactModel: CWContactUser? {
        didSet {
            self.dataSource = CWContactManager.shareContactManager.contactDetailArrayByUserInfo(contactModel!)
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "详细资料"
        registerCellClass()
        // Do any additional setup after loading the view.
    }
    
    func registerCellClass() {
        self.tableView.registerReusableCell(CWContactDetailUserCell)
        self.tableView.registerReusableCell(CWContactDetailAlbumCell)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CWDetailContactViewController {
    
    override func informationButtonCellClicked(info: CWInformationModel) {
        
        if info.title == "发消息" {
            let chatVC = CWChatViewController()
            chatVC.contactId = self.contactModel?.userId
            self.navigationController?.pushViewController(chatVC, animated: true)
        }
        
    }
    
}
