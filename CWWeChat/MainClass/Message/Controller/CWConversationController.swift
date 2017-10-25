//
//  CWConversationController.swift
//  CWWeChat
//
//  Created by chenwei on 2017/3/26.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import ChatClient
import ChatKit

class CWConversationController: ConversationListController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(sendMessage))
        self.navigationItem.rightBarButtonItem = barButtonItem
         
        let result = self.chatManager.fetchAllConversations()
        for conversation in result {
            conversationList.append(ConversationModel(conversation: conversation))
        }
        
        // 添加群聊
        let conversation = Conversation(conversationId: "haohao@conference.cwwise.com", type: .group)
        conversationList.append(ConversationModel(conversation: conversation))

        if #available(iOS 9.0, *) {
            self.registerForPreviewing(with: self, sourceView: self.tableView)
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    @objc func sendMessage() {
        
        let conversationId = "chenwei"
        let chatVC = MessageController(conversationId: conversationId)
        chatVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(chatVC, animated: true)
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let conversation = conversationList[indexPath.row].conversation
        
        let chatVC = CWMessageController(conversation: conversation)
        chatVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(chatVC, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension CWConversationController: UIViewControllerPreviewingDelegate {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        show(viewControllerToCommit, sender: self)
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        // Obtain the index path and the cell that was pressed.
        guard let indexPath = tableView.indexPathForRow(at: location),
            let cell = tableView.cellForRow(at: indexPath) else { return nil }
        
        // Create a detail view controller and set its properties.        
        let conversationModel = self.conversationList[indexPath.row]

        let viewController = MessageController(conversation: conversationModel.conversation)
        viewController.conversation = conversationModel.conversation
        viewController.hidesBottomBarWhenPushed = true
        /*
         Set the height of the preview by setting the preferred content size of the detail view controller.
         Width should be zero, because it's not used in portrait.
         */
        viewController.preferredContentSize = CGSize(width: self.view.width, height: 400)
        
        // Set the source rect to the cell frame, so surrounding elements are blurred.
        if #available(iOS 9.0, *) {
            previewingContext.sourceRect = cell.frame
        } else {
            // Fallback on earlier versions
        }
        
        return viewController
    }
    
}

