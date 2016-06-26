//
//  CWChatViewController.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/22.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWChatViewController: CWBaseMessageViewController {

    var toId: String?
    
    /// 消息数据数组
    var messageList = Array<CWMessageModel>()
    
    /// TableView
    lazy var tableView: UITableView = {
        let frame = CGRect(x: 0, y: 0,
                           width: Screen_Width, height: Screen_Height-45)
        let tableView = UITableView(frame: frame, style: .Plain)
        tableView.autoresizingMask = [.FlexibleHeight,.FlexibleWidth]
        tableView.backgroundColor = UIColor(hexString: "#EBEBEB")
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.separatorStyle = .None
        tableView.dataSource = self
        return tableView
    }()
    
    /// 下面的toolBar
    lazy var chatToolBar:CWInputToolBar = {
        let frame = CGRect(x: 0, y: Screen_Height-45,
                           width: Screen_Width, height: 45)
        let chatToolBar = CWInputToolBar(frame:frame)
//        chatToolBar.delegate = self
        return chatToolBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()

        setupUI()
    }
    
    /**
     设置UI布局
     */
    func setupUI() {
        self.edgesForExtendedLayout = .None
        self.view.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.chatToolBar)
    }
    
    /**
     注册cell class
     */
    func registerCell() {
        
        tableView.registerClass(CWBaseMessageCell.self, forCellReuseIdentifier: CWMessageType.None.reuseIdentifier())
        tableView.registerClass(CWTextMessageCell.self, forCellReuseIdentifier: CWMessageType.Text.reuseIdentifier())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


// MARK: - UITableViewDelegate
extension CWChatViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
}

// MARK: - UITableViewDataSource
extension CWChatViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageList.count
    }
    
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        let message = messageList[indexPath.row]
//        return message.messageFrame.heightOfCell
//    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let message = messageList[indexPath.row]
        
        let chatMessageCell = tableView.dequeueReusableCellWithIdentifier(message.messageType.reuseIdentifier(), forIndexPath: indexPath) as! CWBaseMessageCell
        chatMessageCell.updateMessage(message)
        return chatMessageCell
    }
}

