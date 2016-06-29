//
//  CWChatViewController+SendMessage.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/29.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

// MARK: - 发送消息部分
extension CWChatViewController: CWMessageDispatchQueueDelegate {
    
    func chatmessageSendState(message: CWMessageProtocol, sendState state: Bool) {
        
    }
    
    func uploadDataProgress(message: CWMessageProtocol, progress: CGFloat, result: Bool) {
        
    }
    

    
    ///收到消息
    override func receiveNewMessage(message: CWMessageModel) {
        CWLogInfo(message)
        
        messageList.append(message)
        let indexPath = NSIndexPath(forRow: messageList.count-1, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .None)
        updateMessageAndScrollBottom(false)
    }
    
}