//
//  MessageContentView.swift
//  CWWeChat
//
//  Created by wei chen on 2017/7/16.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

protocol MessageContentViewDelegate: NSObjectProtocol {
    
    // 点击
    
}

/* 
 文字，语音，图片，位置，链接
 
 */
/// ChatMessage ContentView
class MessageContentView: UIView {
    
    var message: CWMessageModel?
    
    weak var delegate: MessageContentViewDelegate?
    
    // 展示气泡
    lazy var bubbleImageView: UIImageView = {
        let bubbleImageView = UIImageView()
        bubbleImageView.isUserInteractionEnabled = true
        bubbleImageView.clipsToBounds = true
        return bubbleImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(bubbleImageView)
    }
    
    func refresh(message: CWMessageModel) {
        self.message = message
        
        if message.isSend {
            let image = #imageLiteral(resourceName: "sender_background_normal")
            let _ = #imageLiteral(resourceName: "sender_background_highlight")
            let cap = ChatCellUI.right_cap_insets
            bubbleImageView.image = image.resizableImage(withCapInsets: cap)
          //  bubbleImageView.highlightedImage = highlightedImage.resizableImage(withCapInsets: cap)
            
        } else {
            
            let image = #imageLiteral(resourceName: "receiver_background_normal")
            let _ = #imageLiteral(resourceName: "receiver_background_highlight")
            
            let cap = ChatCellUI.left_cap_insets
            bubbleImageView.image = image.resizableImage(withCapInsets: cap)
          //  bubbleImageView.highlightedImage = highlightedImage.resizableImage(withCapInsets: cap)
        }
    }
    
    
    func updateProgress() {
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bubbleImageView.frame = self.bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
