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
    
    func chatmessageSendState(message: CWMessageModel, sendState state: Bool) {
        
    }
    
    func uploadDataProgress(message: CWMessageModel, progress: CGFloat, result: Bool) {
        
        CWLogDebug("上传进度: \(progress)")
        //找到消息 修改消息状态 保存数据库
        let index = self.messageList.indexOf({$0.messageID == message.messageID})
//        message.messageUploadState = CWMessageUploadState(rawValue:Int(result))!
//        self.dbMessageStore.updateMessageStateByMessage(message)
        
        guard let localIndex = index else {
            return
        }
        //防止cell 不在显示区域崩溃的问题
        let indexPath = NSIndexPath(forRow: localIndex, inSection: 0)
        guard let cell = self.tableView.cellForRowAtIndexPath(indexPath) as? CWBaseMessageCell else {
            return
        }
        
        dispatch_async(dispatch_get_main_queue(), {
            cell.updateProgressView(CGFloat(progress), result: CWMessageUploadState(rawValue:Int(result))!)
        })
        
        
    }
    

    
    ///收到消息
    override func receiveNewMessage(message: CWMessageModel) {
        
        messageList.append(message)
//        self.tableView.reloadData()
        let indexPath = NSIndexPath(forRow: messageList.count-1, inSection: 0)
        self.tableView.insertRowsAtBottom([indexPath])
//        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .None)
//        updateMessageAndScrollBottom(false)
    }
    
    
    
    /**
     加载本地消息
     */
    func refreshLocalMessage(action:CWCompleteAction)  {
        
        let userid = CWUserAccount.sharedUserAccount().userID
        //先将此条对话的未读条数设置0
        dbRecordStore.updateUnReadCountToZeroWithUserId(userid, fid: friendUser!.userId)
        //获取数据
        dbMessageStore.messagesByUserID(userid, partnerID: friendUser!.userId, fromDate: currentDate, count: 15) { (array:[CWMessageModel], date:NSDate,needMore:Bool) in
            
            guard array.count > 0 else {
                return
            }
            //循环来判断是否需要显示时间
            var tempTime:Double = 0
            var messageCount = 0
            //如果消息条数达到上限，或者消息时间间隔大于30秒就显示时间
            for message in array {
                if (messageCount+1 > Max_Showtime_Message_Count ||
                    tempTime == 0 ||
                    message.messageSendDate.timeIntervalSince1970 - tempTime > Max_Showtime_Message_Second) {
                    
                    tempTime = message.messageSendDate.timeIntervalSince1970
                    messageCount = 0
                    
                }
            }
            self.messageList.insertContentsOf(array, at: 0)
            action()
        }
    }
    
    
    
}