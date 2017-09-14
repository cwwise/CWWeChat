//
//  CWEmoticonPreviewer.swift
//  CWWeChat
//
//  Created by wei chen on 2017/7/19.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import Kingfisher

private let magnifierSize = CGSize(width: 60, height: 100)
private let magnifierBigSize = CGSize(width: 140, height: 155)

/// 表情长按之后效果
class EmoticonPreviewer: UIView {

    // magnifier是长按 之后展示表情的部分
    var magnifier: UIImageView = {
        let magnifier = UIImageView(image: UIImage(named: "EmoticonTips"))
        magnifier.frame = CGRect(origin: CGPoint.zero, size: magnifierSize)
        return magnifier
    }()
    
    var magnifierLabel: UILabel = {
        let magnifierLabel = UILabel()
        magnifierLabel.textAlignment = .center
        magnifierLabel.font = UIFont.systemFont(ofSize: 12)
        magnifierLabel.textColor = UIColor.gray
        magnifierLabel.size = CGSize(width: 40, height: 15)
        return magnifierLabel
    }()
    
    var emoticonType: EmoticonType = .normal {
        didSet {
            setupMagnifierContent()
        }
    }
    
    // 内容部分
    var magnifierContent: AnimatedImageView = {
        let magnifierContent = AnimatedImageView()
        magnifierContent.size = CGSize(width: 35, height: 35)
        magnifierContent.contentMode = .scaleAspectFit
        return magnifierContent
    }()
    
    convenience init() {
        let frame = CGRect(origin: CGPoint.zero, size: magnifierSize)
        self.init(frame: frame)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(magnifier)
        
        magnifierContent.centerX = magnifier.width/2
        magnifierContent.top = 5;
        
        magnifierLabel.centerX = magnifier.width/2
        magnifierLabel.top = magnifierContent.bottom + 2
        
        magnifier.addSubview(magnifierContent)
        magnifier.addSubview(magnifierLabel)
    }
    
    func setupMagnifierContent() {
        
        if emoticonType == .normal {
            
            magnifierLabel.centerX = magnifier.width/2
            magnifierLabel.top = magnifierContent.bottom + 2

        } else {
            
            self.size = magnifierBigSize
            self.magnifierContent.frame = CGRect(x: 10, y: 10, width: self.width-2*10, height: self.height-10-25)
            self.magnifier.frame = CGRect(origin: CGPoint.zero, size: magnifierBigSize)
        }
        
    }
    
    
    func preview(from rect: CGRect, emoticon: Emoticon) {
       
        self.centerX = rect.midX
        self.isHidden = false

        if emoticon.type == .normal {
            
            self.bottom = rect.maxY
            // 普通表情 和 大图表情 处理不一样
            magnifierLabel.text = emoticon.title
            magnifierContent.layer.removeAllAnimations()
            
            let duration = 0.1
            UIView.animate(withDuration: duration, delay: 0, options: .curveEaseIn, animations: {
                self.magnifierContent.top = 3
            }) { (finished) in
                UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
                    self.magnifierContent.top = 6
                }) { (finished) in
                    UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
                        self.magnifierContent.top = 5
                    }) { (finished) in
                    }
                }
            }
        } else {
            self.bottom = rect.minY + 10
            self.magnifier.image = self.backgroundImage()
        }
        magnifierContent.kf.setImage(with: emoticon.originalUrl)

    }
    
    func backgroundImage() -> UIImage? {
        
        // 合成背景图
        let leftImage = UIImage(named: "EmoticonBigTipsLeft")?.resizableImage()
        let midImage = UIImage(named: "EmoticonBigTipsMiddle")
        let rightImage = UIImage(named: "EmoticonBigTipsRight")?.resizableImage()
        
        let height: CGFloat = 155
        let width: CGFloat = 140
        
        let size = CGSize(width: width, height: height)
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        
        let leftWidth: CGFloat = (width - 30)/2
        
        leftImage?.draw(in: CGRect(x: 0, y: 0, width: leftWidth, height: height))
        midImage?.draw(in: CGRect(x: leftWidth, y: 0, width: 30, height: height))
        rightImage?.draw(in: CGRect(x: leftWidth+30, y: 0, width: leftWidth, height: height))
        
        let resultImg = UIGraphicsGetImageFromCurrentImageContext()
        
        return resultImg
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

