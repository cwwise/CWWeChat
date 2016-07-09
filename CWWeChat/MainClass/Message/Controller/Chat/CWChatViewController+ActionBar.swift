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
        message.showTime = messageNeedShowTime(message.messageSendDate)
        if message.showTime {
            self.addTimeMeesage(message.messageSendDate)
        }
        dbMessageStore.appendMessage(message) { (isSuccess) in
            self.dispatchMessage(message)
            self.messageList.append(message)
            self.tableView.reloadData()
            //let indexPath = NSIndexPath(forRow: self.messageList.count-1, inSection: 0)
            //self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .None)
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
    
    
    /**
     是否需要显示消息的时间
     
     - parameter date: 当前消息的发送时间
     
     - returns: 是否需要显示
     */
    func messageNeedShowTime(date:NSDate) -> Bool {
        
        messageAccumulate += 1
        let messageInterval = date.timeIntervalSince1970 - lastDateInterval
        //消息间隔
        if messageAccumulate > MAX_SHOWTIME_MESSAGE_COUNT ||
            lastDateInterval == 0 ||
            messageInterval > MAX_SHOWTIME_MESSAGE_SECOND{
            lastDateInterval = date.timeIntervalSince1970
            messageAccumulate = 0
            return true
        }
        return false
    }
    
    func addTimeMeesage(date: NSDate) {
        let timeString = "  \(ChatTimeTool.timeStringFromSinceDate(date))  "
        let time = CWMessageModel()
        time.content = timeString
        time.messageType = .Time
        messageList.append(time)
    }
    
}
