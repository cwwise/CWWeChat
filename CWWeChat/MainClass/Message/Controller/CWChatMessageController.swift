//
//  CWChatMessageController.swift
//  CWWeChat
//
//  Created by wei chen on 2017/4/10.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

public class CWChatMessageController: CWBaseMessageController {
        
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = rightBarItem
        //背景图
        if let path = Bundle.main.path(forResource: "chat_background", ofType: "png") {
            let imageView = UIImageView(frame: self.view.bounds)
            imageView.contentMode = .scaleAspectFill
            imageView.image = UIImage(contentsOfFile: path)
            self.collectionView.backgroundView = imageView
        }
    }
    
    @objc func rightBarItemDown(_ barItem: UIBarButtonItem) {
        let chatDetailVC = CWChatDetailViewController()
        self.navigationController?.pushViewController(chatDetailVC, animated: true)
    }
    
    lazy var rightBarItem: UIBarButtonItem = {
        let image = self.conversation.type == .single ? CWAsset.Nav_chat_single.image : CWAsset.Nav_chat_single.image
        let rightBarItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(rightBarItemDown(_:)))
        return rightBarItem
    }()
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

