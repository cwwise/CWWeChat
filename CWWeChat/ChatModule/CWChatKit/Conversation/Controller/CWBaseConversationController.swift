//
//  CWBaseConversationController.swift
//  CWWeChat
//
//  Created by chenwei on 2017/3/26.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

/// 会话
public class CWBaseConversationController: UIViewController {

    // 
    public var chatManager = CWChatClient.share.chatManager
    // 会话列表
    public var conversationList = [CWConversationModel]()

    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        chatManager.addChatDelegate(self, delegateQueue: DispatchQueue.main)        
        CWChatKit.share.userInfoDataSource = self
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
        self.view.addSubview(self.tableView)
        registerCellClass()
    }
    
    func registerCellClass() {
        tableView.register(CWConversationCell.self, forCellReuseIdentifier: CWConversationCell.identifier)
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: 属性Getter
    /// TableView
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.rowHeight = 64.0
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        tableView.separatorColor = UIColor.tableViewCellLineColor()
        
        tableView.tableHeaderView = self.searchController.searchBar
        return tableView
    }()
    
    lazy var searchController: CWSearchController = {
        let searchController = CWSearchController(searchResultsController: self.searchResultController)
        searchController.searchResultsUpdater = self.searchResultController
        searchController.searchBar.placeholder = "搜索"
        searchController.searchBar.delegate = self
        searchController.showVoiceButton = true
        return searchController
    }()
    
    //搜索结果
    var searchResultController: CWSearchResultController = {
        let searchResultController = CWSearchResultController()
        return searchResultController
    }()
}

// MARK: - CWChatUserInfoDataSource
extension CWBaseConversationController: CWChatUserInfoDataSource {
    public func loadUserInfo(userId: String, completion: @escaping ((CWUser?) -> Void)) {
       
        //TODO: 先从本地缓存获取，如果没有，则做网络请求来获取
        // test
        let model = CWUser(userId: "chenwei")
        model.nickname = userId
        model.avatarUrl = URL(string: "\(kImageBaseURLString)\(userId).jpg")
        completion(model)
    }
}


//MARK: UITableViewDelegate UITableViewDataSource
extension CWBaseConversationController: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteTitle = "删除"
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: deleteTitle) { (action:UITableViewRowAction, indexPath) in
            
            //获取当前model
            let conversationModel = self.conversationList[indexPath.row]
            //数组中删除
            self.conversationList.remove(at: indexPath.row)
            //从数据库中删除
            self.chatManager.deleteConversation(conversationModel.targetId, deleteMessages: true)
            //删除
            self.tableView.deleteRows(at: [indexPath], with: .none)
        }
        
        let actionTitle = "标记已读"
        let moreAction = UITableViewRowAction(style: UITableViewRowActionStyle.normal, title: actionTitle) { (action:UITableViewRowAction, indexPath) in
            
            tableView.setEditing(false, animated: true)
        }
        return [deleteAction,moreAction]
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let conversation = conversationList[indexPath.row].conversation

        let chatVC = CWChatMessageController(conversation: conversation)
        chatVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(chatVC, animated: true)
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.conversationList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CWConversationCell.identifier, for: indexPath) as! CWConversationCell
        cell.conversationModel = conversationList[indexPath.row]
        return cell
    }
}

// MARK: - UISearchBarDelegate
extension CWBaseConversationController: UISearchBarDelegate {
    
    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    public func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    public func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        let message = "语言搜索"
        let alertController = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        let alertAtion = UIAlertAction(title: "确定", style: .default) { (action) in
            
        }
        alertController.addAction(alertAtion)
        self.present(alertController, animated: true, completion: nil)
    }
}


// MARK: - CWChatManagerDelegate
extension CWBaseConversationController: CWChatManagerDelegate {
    // 收到会话变化
    public func conversationDidUpdate(_ conversation: CWConversation) {
        /// 遍历所有会话 找到对应的index
        var unread = 0
        var index = -1
        for i in 0..<conversationList.count {
            let model = conversationList[i].conversation
            if model == conversation {
                index = i
                model.appendMessage(conversation.lastMessage)
            }
            unread += model.unreadCount
        }
        
        // 如果会话不存在 则加入刷新
        if index == -1 {
            let model = CWConversationModel(conversation: conversation)
            conversationList.insert(model, at: 0)
        }
        // 如果是其他 则移动到第一个
        // TODO: isTop设置需要
        else if (index != 0) {
            let model = conversationList.remove(at: index)
            conversationList.insert(model, at: 0)
        }
        
        // 其他情况 如是第一个 直接刷新
        tableView.reloadData()
        if unread == 0 {
            self.tabBarItem.badgeValue = nil
        } else if (unread > 99) {
            self.tabBarItem.badgeValue = "99+"
        } else {
            self.tabBarItem.badgeValue = "\(unread)"
        }
    }
}


