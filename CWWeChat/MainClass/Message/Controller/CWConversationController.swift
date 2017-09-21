//
//  CWConversationController.swift
//  CWWeChat
//
//  Created by chenwei on 2017/3/26.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class CWConversationController: CWBaseConversationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(sendMessage))
        self.navigationItem.rightBarButtonItem = barButtonItem
         
        let result = self.chatManager.fetchAllConversations()
        for conversation in result {
            conversationList.append(CWConversationModel(conversation: conversation))
        }
        
        if #available(iOS 9.0, *) {
            self.registerForPreviewing(with: self, sourceView: self.tableView)
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    @objc func sendMessage() {
        
        let chatVC = CWChatMessageController(targetId: "chenwei")
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

        let viewController = CWChatMessageController(conversation: conversationModel.conversation)
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

