//
//  CWChatMessageController.swift
//  CWWeChat
//
//  Created by wei chen on 2017/4/10.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class CWChatMessageController: CWBaseMessageController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = rightBarItem
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
        let detailVC = CWContactDetailController()
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
