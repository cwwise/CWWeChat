//
//  VoiceMessageContentView.swift
//  CWWeChat
//
//  Created by chenwei on 2017/9/15.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import UIKit

private let kReddotWidth: CGFloat = 6

class VoiceMessageContentView: MessageContentView {

    /// voice图标的imageView
    lazy var voiceImageView:UIImageView = {
        let voiceImageView = UIImageView()
        voiceImageView.size = CGSize(width: 12.5, height: 17)
        voiceImageView.contentMode = .scaleAspectFit
        return voiceImageView
    }()
    
    lazy var redTipImageView:UIImageView = {
        let redTipImageView = UIImageView()
        redTipImageView.clipsToBounds = true
        redTipImageView.backgroundColor = UIColor.redTipColor()
        redTipImageView.layer.cornerRadius = kReddotWidth/2
        return redTipImageView
    }()
    
    lazy var voiceLengthLable: UILabel = {
        let voiceLengthLable = UILabel()
        return voiceLengthLable
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(voiceImageView)
    }
    
    override func refresh(message: CWMessageModel) {
        super.refresh(message: message)
       
        if message.isSend {
            setupVoicePlayIndicatorImageView(true)
        } else {
            setupVoicePlayIndicatorImageView(false)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let message = message else {
            voiceImageView.frame = self.bounds
            return
        }
        
        if message.isSend {
            let edge = ChatCellUI.right_edge_insets
            let size = CGSize(width: 13, height: 17)
            let origin = CGPoint(x: self.bounds.maxX-edge.right-size.width, y: edge.top)
            voiceImageView.frame = CGRect(origin: origin, size: size)
        } else {
            let edge = ChatCellUI.left_edge_insets
            let size = CGSize(width: 13, height: 17)
            let origin = CGPoint(x: edge.left, y: edge.top)
            voiceImageView.frame = CGRect(origin: origin, size: size)
        }
        
    }
    
    /// 设置播放
    func setupVoicePlayIndicatorImageView(_ send: Bool) {
        
        let images: [UIImage]
        if send {
            images = [UIImage(named: "SenderVoiceNodePlaying001")!,
                      UIImage(named: "SenderVoiceNodePlaying002")!,
                      UIImage(named: "SenderVoiceNodePlaying003")!]
            voiceImageView.image = images.last
        } else {
            images = [UIImage(named: "ReceiverVoiceNodePlaying001")!,
                      UIImage(named: "ReceiverVoiceNodePlaying002")!,
                      UIImage(named: "ReceiverVoiceNodePlaying003")!]
            voiceImageView.image = images.last
        }
        voiceImageView.animationDuration = 1
        voiceImageView.animationImages = images
    }
    
    func updateState() {
    
        // 如果正在播放 播放动画
        if message?.playStatus == .playing {
            startAnimating()
            redTipImageView.isHidden = true
        }
        else if message?.playStatus == .none
            && message?.isSend == false {
            redTipImageView.isHidden = false
            stopAnimating()
        }
        else {
            redTipImageView.isHidden = true
            stopAnimating()
        }
    }
    
    /// 结束动画
    func startAnimating() {
        voiceImageView.startAnimating()
    }
    
    /// 开始动画
    func stopAnimating() {
        voiceImageView.stopAnimating()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
