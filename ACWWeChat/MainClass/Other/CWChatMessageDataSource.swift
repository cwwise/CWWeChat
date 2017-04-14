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
    
    fileprivate unowned var tableView: UITableView
    
    init(tableView: UITableView) {
        self.tableView = tableView
        tableView.registerReusableCell(CWBaseMessageCell.self)
        tableView.registerReusableCell(CWTextMessageCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = dataSource[(indexPath as NSIndexPath).row]
        let chatMessageCell = tableView.dequeueReusableCell(withIdentifier: message.messageType.reuseIdentifier(), for: indexPath) as! CWBaseMessageCell
        chatMessageCell.updateMessage(message)
        return chatMessageCell
    }
}
