//
//  CWConversationController.swift
//  CWWeChat
//
//  Created by chenwei on 2017/3/26.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class CWConversationController: CWChatSessionController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(sendMessage))
        self.navigationItem.rightBarButtonItem = barButtonItem
                
        // Do any additional setup after loading the view.
    }
    
    func sendMessage() {
        
        let textObject = CWTextMessageBody(text: "1234")
        let message = CWChatMessage(targetId: "chenwei", messageBody: textObject)
        
        let chatManager = CWChatClient.share.chatManager
        
        chatManager.sendMessage(message: message, progress: { (progress) in
            
            
            
        }) { (message, error) in
           
            
        }
        
        let imageBody = CWImageMessageBody(path: "https://ohtmnqk8a.qnssl.com/chatmessage_001.jpg")
        let message2 = CWChatMessage(targetId: "chenwei", messageBody: imageBody)
        chatManager.sendMessage(message: message2, progress: { (progress) in
            
        }) { (message, error) in
            
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
