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
    
    func chatInputView(_ inputView: CWInputToolBar, sendText text: String) {
        CWLogDebug("发送文字:\(text)")
        
        let messageContent = CWTextMessageContent(content: text)
        let message = CWMessageModel(targetId: contactId, content: messageContent)
        message.content = text
        sendMessage(message)
    }
    
    func chatInputView(_ inputView: CWInputToolBar, sendImage imageName: String ,extentInfo:Dictionary<String,String>) {
        let messageContent = CWImageMessageContent(imagePath: imageName)
        let sizeString = extentInfo["size"]! as String
        messageContent.imageSize = CGSizeFromString(sizeString)
        
        let message = CWMessageModel(targetId: contactId, content: messageContent)
        message.content = imageName
        sendMessage(message)
    }
    
    func chatInputView(_ inputView: CWInputToolBar, sendVoice voicePath: String, recordTime: Float) {
    
        let voiceContent = CWVoiceMessageContent(voicePath: voicePath)
        voiceContent.voiceLength = recordTime
        let message = CWMessageModel(targetId: contactId, content: voiceContent)
        message.content = voicePath
        sendMessage(message)
    }
    
    /**
     发送消息体
     
     发送消息 先保存数据库 保存成功后天就到数据库，并且发送到服务器
     - parameter message: 消息体
     */
    func sendMessage(_ message: CWMessageModel)  {
        let rand = arc4random() % 2
        if rand == 0 {
            message.messageOwnerType = .other
        } else {
            message.messageOwnerType = .myself
        }
        message.messageSendId = CWUserAccount.sharedUserAccount().userID
        message.showTime = messageNeedShowTime(message.messageSendDate as Date)
        if message.showTime {
            self.addTimeMeesage(message.messageSendDate as Date)
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
    func dispatchMessage(_ message: CWMessageModel) {
        messageDispatchQueue.sendMessage(message)
    }
    
    
    ///滚动到底部
    func updateMessageAndScrollBottom(_ animated:Bool = true) {
        if messageList.count == 0 {
            return
        }
        let indexPath = IndexPath(row: messageList.count-1, section: 0)
        self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: animated)
    }
    
    
    /**
     是否需要显示消息的时间
     
     - parameter date: 当前消息的发送时间
     
     - returns: 是否需要显示
     */
    func messageNeedShowTime(_ date:Date) -> Bool {
        
        messageAccumulate += 1
        let messageInterval = date.timeIntervalSince1970 - lastDateInterval
        //消息间隔
        if messageAccumulate > Max_Showtime_Message_Count ||
            lastDateInterval == 0 ||
            messageInterval > Max_Showtime_Message_Second{
            lastDateInterval = date.timeIntervalSince1970
            messageAccumulate = 0
            return true
        }
        return false
    }
    
    func addTimeMeesage(_ date: Date) {
        let timeString = "  \(ChatTimeTool.timeStringFromSinceDate(date))  "
        let time = CWMessageModel()
        time.content = timeString
        time.messageType = .time
        messageList.append(time)
    }
    
}
