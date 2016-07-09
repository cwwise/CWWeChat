//
//  CWChatViewController+ActionBar.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/29.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

// MARK: - ActionBar
extension CWChatViewController: CWInputToolBarDelegate {
    
    func chatInputView(inputView: CWInputToolBar, sendText text: String) {
        CWLogDebug("发送文字:\(text)")
        
        let messageContent = CWTextMessageContent(content: text)
        let message = CWMessageModel(targetId: contactId, content: messageContent)
        message.content = text
        sendMessage(message)
    }
    
    func chatInputView(inputView: CWInputToolBar, sendImage imageName: String ,extentInfo:Dictionary<String,String>) {
        
        let messageContent = CWImageMessageContent(imagePath: imageName)
        let sizeString = extentInfo["size"]! as String
        messageContent.imageSize = CGSizeFromString(sizeString)
        
        let message = CWMessageModel(targetId: contactId, content: messageContent)
        message.content = imageName
        sendMessage(message)
        
    }
    
    /**
     发送消息体
     
     发送消息 先保存数据库 保存成功后天就到数据库，并且发送到服务器
     - parameter message: 消息体
     */
    func sendMessage(message: CWMessageModel)  {
        
        message.messageSendId = CWUserAccount.sharedUserAccount().userID
        //        message.showTime = messageNeedShowTime(message.messageSendDate)
        dbMessageStore.appendMessage(message) { (isSuccess) in
            self.dispatchMessage(message)
            self.messageList.append(message)
            self.tableView.reloadData()
            //            let indexPath = NSIndexPath(forRow: self.messageList.count-1, inSection: 0)
            //            self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .None)
            self.updateMessageAndScrollBottom(false)
        }
    }
    
    
    /**
     发送消息到服务器
     
     - parameter message: 消息体
     */
    func dispatchMessage(message: CWMessageModel) {
        messageDispatchQueue.sendMessage(message)
    }
    
    
    ///滚动到底部
    func updateMessageAndScrollBottom(animated:Bool = true) {
        if messageList.count == 0 {
            return
        }
        let indexPath = NSIndexPath(forRow: messageList.count-1, inSection: 0)
        self.tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Bottom, animated: animated)
    }
    
    
}
