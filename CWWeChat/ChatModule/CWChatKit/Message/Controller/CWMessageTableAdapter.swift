//
//  CWMessageTableAdapter.swift
//  CWWeChat
//
//  Created by chenwei on 2017/6/26.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class CWMessageTableAdapter: NSObject {
    var messageList = Array<AnyObject>()
    
    
}

extension CWMessageTableAdapter: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = messageList[indexPath.row]
        guard let messageModel = message as? CWChatMessageModel else {
            let timeCell = tableView.dequeueReusableCell(withIdentifier: CWTimeMessageCell.identifier) as! CWTimeMessageCell
            timeCell.timeLabel.text = message as? String
            return timeCell
        }
        let identifier = messageModel.message.messageType.identifier()
        
        // 时间和tip消息 是例外的种类 以后判断
        let messageCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! CWMessageCell
//        messageCell.delegate = self
        messageCell.updateMessage(messageModel)
        messageCell.updateState()
        messageCell.updateProgress()
        
        return messageCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let message = messageList[indexPath.row]
           
        var cellHeight: CGFloat = 0
        if let messageModel = message as? CWChatMessageModel  {
            cellHeight = messageModel.messageFrame.heightOfCell
        } else if message is String {
            cellHeight = 30.0
        }
        
        return cellHeight
    }
}
    
extension CWMessageTableAdapter: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        UIMenuController.shared.setMenuVisible(false, animated: true)
    }
    
}
