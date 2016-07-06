//
//  CWBaseMessageViewController.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/22.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

/**
 会话类和消息类的基类
 
 设计这个基类，一方面是简化一些代码
 */
class CWBaseMessageViewController: UIViewController {
    
    var messageCracker:CWMessageCracker = {
        return CWMessageCracker.shareMessageCracker()
    }()
    
    //存储数据库
    lazy var dbMessageStore:CWChatDBMessageStore = {
        return CWChatDBDataManager.sharedInstance.dbMessageStore
    }()
    
    //存储数据库
    lazy var dbRecordStore:CWChatDBRecordStore = {
        return CWChatDBDataManager.sharedInstance.dbRecordStore
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMessageCracker()
        // Do any additional setup after loading the view.
    }
    
    ///设置消息接收
    func setupMessageCracker() {
        let xmppQueue = dispatch_get_main_queue()
        messageCracker.addDelegate(self, delegateQueue: xmppQueue)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        messageCracker.removeDelegate(self)
        CWLogDebug("\(self.classForCoder)销毁")
    }
}

// MARK: - CWMessageCrackerDelegate
extension CWBaseMessageViewController: CWMessageCrackerDelegate {
    //获取到消息
    func receiveNewMessage(message: CWMessageModel) {
        
    }
}
