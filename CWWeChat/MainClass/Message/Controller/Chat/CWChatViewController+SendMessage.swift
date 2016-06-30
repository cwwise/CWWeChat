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
    
    
    
    /**
     加载本地消息
     */
    func refreshLocalMessage(action:CWCompleteAction)  {
        
        let userid = CWUserAccount.sharedUserAccount().userID
        //先将此条对话的未读条数设置0
        
        dbRecordStore.updateUnReadCountToZeroWithUserId(userid, fid: friendUser!.userId)
        //获取数据
        dbMessageStore.messagesByUserID(userid, partnerID: friendUser!.userId, fromDate: currentDate, count: 15) { (array:[CWMessageProtocol], date:NSDate,needMore:Bool) in
            
            guard array.count > 0 else {
                return
            }
            //循环来判断是否需要显示时间
            var tempTime:Double = 0
            var messageCount = 0
            //如果消息条数达到上限，或者消息时间间隔大于30秒就显示时间
            for message in array {
                if (messageCount+1 > MAX_SHOWTIME_MESSAGE_COUNT ||
                    tempTime == 0 ||
                    message.messageSendDate.timeIntervalSince1970 - tempTime > MAX_SHOWTIME_MESSAGE_SECOND) {
                    
                    tempTime = message.messageSendDate.timeIntervalSince1970
                    messageCount = 0
                    
                }
            }
            self.messageList.insertContentsOf(array, at: 0)
            action()
        }
    }
    
    
    
}