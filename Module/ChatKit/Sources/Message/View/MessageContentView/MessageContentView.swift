//
//  MessageContentView.swift
//  ChatKit
//
//  Created by chenwei on 2017/10/4.
//

import UIKit

/* 
 文字，语音，图片，位置，链接
 
 */
/// ChatMessage ContentView
public class MessageContentView: UIView {
    
    var message: MessageModel?
    
    var menuItems: [UIMenuItem] = []
    
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
    
    func refresh(message: MessageModel) {
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

    public override func layoutSubviews() {
        super.layoutSubviews()
        bubbleImageView.frame = self.bounds
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
