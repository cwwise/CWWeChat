//
//  CWChatMessageDataSource.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/29.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

final class CWChatMessageDataSource: NSObject, UITableViewDataSource {
    
    var dataSource: [CWMessageModel] = [] {
        didSet { tableView.reloadData() }
    }
    
    private unowned var tableView: UITableView
    
    init(tableView: UITableView) {
        self.tableView = tableView
        tableView.registerReusableCell(CWBaseMessageCell)
        tableView.registerReusableCell(CWTextMessageCell)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let message = dataSource[indexPath.row]
        let chatMessageCell = tableView.dequeueReusableCellWithIdentifier(message.messageType.reuseIdentifier(), forIndexPath: indexPath) as! CWBaseMessageCell
        chatMessageCell.updateMessage(message)
        return chatMessageCell
    }
}
