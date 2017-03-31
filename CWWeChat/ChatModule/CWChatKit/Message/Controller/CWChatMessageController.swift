//
//  CWChatMessageController.swift
//  CWWeChat
//
//  Created by chenwei on 2017/3/27.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class CWChatMessageController: UIViewController {

    /// 消息数据数组
    var messageList = Array<CWChatMessageModel>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
    }
    
    /**
     注册cell class
     */
    func registerCell() {
        
        tableView.register(CWChatMessageCell.self, forCellReuseIdentifier: CWMessageType.none.identifier())
        tableView.register(CWChatMessageCell.self, forCellReuseIdentifier: CWMessageType.text.identifier())

    }

    
    
    //MARK: UI属性
    /// TableView
    lazy var tableView: UITableView = {
        let frame = CGRect(x: 0, y: 0,
                           width: kScreenWidth, height: kScreenHeight-45)
        let tableView = UITableView(frame: frame, style: .plain)
        tableView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        tableView.backgroundColor = UIColor("#EBEBEB")
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 50
        tableView.dataSource = self
        return tableView
    }()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

// MARK: - UITableViewDelegate
extension CWChatMessageController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
}

// MARK: - UITableViewDataSource
extension CWChatMessageController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let message = messageList[indexPath.row]
        let identifier = ""
        
        // 时间和tip消息 是例外的种类 以后判断
        
        let messageCell = self.tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! CWChatMessageCell
        messageCell.messageModel = message
        
        return messageCell
    }
    
}
