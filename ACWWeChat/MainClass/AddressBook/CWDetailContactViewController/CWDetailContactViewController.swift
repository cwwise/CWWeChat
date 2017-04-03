//
//  CWDetailContactViewController.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/28.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWDetailContactViewController: CWInformationViewController {

    let height_User_Cell: CGFloat = 90
    let height_Album_Cell: CGFloat = 90

    var contactModel: CWContactUser? {
        didSet {
            self.dataSource = CWContactManager.shareContactManager.contactDetailArrayByUserInfo(contactModel!)
            self.tableView.reloadData()
        }
    }
    
    var contactID: String? {
        didSet {
            let user = CWContactManager.findContact(contactID!)
            self.contactModel = user
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "详细资料"
        registerCellClass()
        // Do any additional setup after loading the view.
    }
    
    func registerCellClass() {
        self.tableView.register(CWContactDetailUserCell.self, forCellReuseIdentifier: CWContactDetailUserCell.reuseIdentifier)
        self.tableView.register(CWContactDetailAlbumCell.self, forCellReuseIdentifier: CWContactDetailAlbumCell.reuseIdentifier)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CWDetailContactViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let menuItem = dataSource[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row]
        if menuItem.type == .other {
            if (indexPath as NSIndexPath).section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: CWContactDetailUserCell.reuseIdentifier) as! CWContactDetailUserCell
                cell.userModel = self.contactModel
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: CWContactDetailAlbumCell.reuseIdentifier) as! CWContactDetailAlbumCell
                cell.infoModel = menuItem
                return cell
            }
        }
        
        return super.tableView(tableView, cellForRowAt: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let menuItem = dataSource[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row]
        if menuItem.type == .other {
            if (indexPath as NSIndexPath).section == 0 {
                return height_User_Cell
            }
            return height_Album_Cell
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    
    override func informationButtonCellClicked(_ info: CWInformationModel) {
        
        if info.title == "发消息" {
            let chatVC = CWChatViewController()
            chatVC.contactId = self.contactModel?.userId
            self.navigationController?.pushViewController(chatVC, animated: true)
        }
        
    }
    
}
