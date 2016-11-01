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
    
    func chatmessageSendState(_ message: CWMessageModel, sendState state: Bool) {
        
    }
    
    func uploadDataProgress(_ message: CWMessageModel, progress: CGFloat, result: Bool) {
        
        CWLogDebug("上传进度: \(progress)")
        //找到消息 修改消息状态 保存数据库
        let index = self.messageList.index(where: {$0.messageID == message.messageID})
//        message.messageUploadState = CWMessageUploadState(rawValue:Int(result))!
//        self.dbMessageStore.updateMessageStateByMessage(message)
        
        guard let localIndex = index else {
            return
        }
        //防止cell 不在显示区域崩溃的问题
        let indexPath = IndexPath(row: localIndex, section: 0)
        guard let cell = self.tableView.cellForRow(at: indexPath) as? CWBaseMessageCell else {
            return
        }
        
        DispatchQueue.main.async(execute: {
            
            var isSuccess = 0
            if result {
                isSuccess = 1
            }
            
            let type = CWMessageUploadState(rawValue: isSuccess)!
            cell.updateProgressView(CGFloat(progress), result: type)
        })
        
        
    }
    

    
    ///收到消息
    override func receiveNewMessage(_ message: CWMessageModel) {
        
        messageList.append(message)
//        self.tableView.reloadData()
        let indexPath = IndexPath(row: messageList.count-1, section: 0)
        self.tableView.insertRowsAtBottom([indexPath])
//        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .None)
//        updateMessageAndScrollBottom(false)
    }
    
    
    
    /**
     加载本地消息
     */
    func refreshLocalMessage(_ action:@escaping CWCompleteAction)  {
        
        let userid = CWUserAccount.sharedUserAccount().userID
        //先将此条对话的未读条数设置0
        dbRecordStore.updateUnReadCountToZeroWithUserId(userid, fid: friendUser!.userId)
        //获取数据
        dbMessageStore.messagesByUserID(userid, partnerID: friendUser!.userId, fromDate: currentDate, count: 15) { (array:[CWMessageModel], date:Date,needMore:Bool) in
            
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
            self.messageList.insert(contentsOf: array, at: 0)
            action()
        }
    }
    
    
    
}
