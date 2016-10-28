//
//  CWVoiceMessageCell.swift
//  CWWeChat
//
//  Created by chenwei on 16/7/12.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

let redtip_width: CGFloat = 8


class CWVoiceMessageCell: CWBaseMessageCell {

    /// voice图标的imageView
    lazy var contentImageView:UIImageView = {
        let contentImageView = UIImageView()
        contentImageView.contentMode = .scaleAspectFit
        contentImageView.isUserInteractionEnabled = true
        return contentImageView
    }()
    
    ///手势操作
    fileprivate(set) lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(bubbleTapped(_:)))
        return tapGestureRecognizer
    }()
    
    lazy var redTipImageView:UIImageView = {
        let redTipImageView = UIImageView()
        redTipImageView.frame.size = CGSize(width: redtip_width,height: redtip_width)
        redTipImageView.clipsToBounds = true
        redTipImageView.backgroundColor = UIColor.redTipColor()
        redTipImageView.layer.cornerRadius = redtip_width/2
        return redTipImageView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.messageBackgroundView.addSubview(contentImageView)
        self.messageBackgroundView.addSubview(redTipImageView)
        messageBackgroundView.addGestureRecognizer(self.tapGestureRecognizer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///重写setMessage方法
    override func updateMessage(_ message: CWMessageModel) {
        super.updateMessage(message)
        
        let size = message.messageFrame.contentSize
        
        //如果是自己发送，在右边
        if message.messageOwnerType == .myself {
            
            setUpVoicePlayIndicatorImageView(true)
            
            let sendImage = CWAsset.Message_sender_bg.image.resizableImage()
            let sendImageHL = CWAsset.Message_sender_bgHL.image.resizableImage()
            
            self.messageBackgroundView.image = sendImage
            self.messageBackgroundView.highlightedImage = sendImageHL
                   
        } else {
        
            setUpVoicePlayIndicatorImageView(false)

            let sendImage = CWAsset.Message_receiver_bg.image.resizableImage()
            let sendImageHL = CWAsset.Message_receiver_bgHL.image.resizableImage()
            
            self.messageBackgroundView.image = sendImage
            self.messageBackgroundView.highlightedImage = sendImageHL
            
        }
        print(size)
        self.messageBackgroundView.snp.updateConstraints({ (make) in
            make.size.equalTo(size)
        })

        updateMessageCellState()
    }
    
    /**
     根据发送方的不同 设置不同的位置
     
     - parameter send: 消息的发送方
     */
    func setUpVoicePlayIndicatorImageView(_ send: Bool) {
        var images = NSArray()
        if send {
            images = NSArray(objects: UIImage(named: "SenderVoiceNodePlaying001")!, UIImage(named: "SenderVoiceNodePlaying002")!, UIImage(named: "SenderVoiceNodePlaying003")!)
            contentImageView.image = UIImage(named: "SenderVoiceNodePlaying")
        } else {
            images = NSArray(objects: UIImage(named: "ReceiverVoiceNodePlaying001")!, UIImage(named: "ReceiverVoiceNodePlaying002")!, UIImage(named: "ReceiverVoiceNodePlaying003")!)
            contentImageView.image = UIImage(named: "ReceiverVoiceNodePlaying")
        }
        contentImageView.animationDuration = 1
        contentImageView.animationImages = (images as! [UIImage])
    }
    
    override func updateMessageCellState() {
        super.updateMessageCellState()
    }
    
    /**
     开始播放动画
     */
    func startAnimating() {
        contentImageView.startAnimating()
    }
    
    /**
     停止播放动画
     */
    func stopAnimating() {
        contentImageView.stopAnimating()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
