//
//  CWChatMessageController.swift
//  CWWeChat
//
//  Created by wei chen on 2017/4/10.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class CWChatMessageController: CWBaseMessageController {
    
    init(targetId: String? = nil, conversation: CWChatConversation? = nil) {
        super.init(nibName: nil, bundle: nil)
        if let conversation = conversation {
            self.conversation = conversation
        }
        else if let targetId = targetId {
            let conversation = CWChatClient.share.chatManager.fecthConversation(chatType: .single, targetId: targetId)
            self.conversation = conversation
        } else {
            assert(true, "没有targetId或者conversation")
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = rightBarItem
        //背景图
        if let path = Bundle.main.path(forResource: "chat_background", ofType: "png") {
            let imageView = UIImageView(frame: self.view.bounds)
            imageView.image = UIImage(contentsOfFile: path)
            self.tableView.backgroundView = imageView
        }
    }
    
    func rightBarItemDown(_ barItem: UIBarButtonItem) {
        let chatDetailVC = CWChatDetailViewController()
        self.navigationController?.pushViewController(chatDetailVC, animated: true)
    }
    
    lazy var rightBarItem: UIBarButtonItem = {
        let image = self.conversation.type == .single ? CWAsset.Nav_chat_single.image : CWAsset.Nav_chat_single.image
        let rightBarItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(rightBarItemDown(_:)))
        return rightBarItem
    }()
    
    
    override func messageCellUserAvatarDidClick(_ userId: String) {
        let detailVC = CWContactDetailController(userId: userId)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
