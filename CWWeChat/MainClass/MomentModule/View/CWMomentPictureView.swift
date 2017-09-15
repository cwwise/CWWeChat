//
//  CWMomentPictureView.swift
//  CWWeChat
//
//  Created by chenwei on 2017/6/24.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class CWMomentPictureView: UIView {
    
    var pictureViews: [UIImageView] = [UIImageView]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // 布置图片部分
        for i in 0..<9 {
            
            let imageView = UIImageView()
            imageView.isHighlighted = true
            imageView.clipsToBounds = true
            imageView.backgroundColor = UIColor.gray
            imageView.isUserInteractionEnabled = true
            imageView.tag = 100+i
            imageView.contentMode = .scaleAspectFill
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction(_:)))
            imageView.addGestureRecognizer(tap)
            
            pictureViews.append(imageView)
            self.addSubview(imageView)
        }
    }
    // 待优化
    func setupView(with frame: CGRect, imageArray: [CWMomentPhoto], pictureSize: CGSize) {
        self.frame = frame
                
        let picSize = pictureSize
        let pics = imageArray
        let picsCount = imageArray.count
        
        for i in 0..<9 {
            let imageView = pictureViews[i]
            if i >= picsCount {
                imageView.kf.cancelDownloadTask()
                imageView.isHidden = true
            } else {
                var origin = CGPoint.zero
                switch picsCount {
                case 1:
                    origin.x = 0
                    origin.y = 0
                case 4:
                    origin.x = CGFloat(i%2) * (picSize.width + CWMomentUI.kCellPaddingPic)
                    origin.y = CGFloat(i/2) * (picSize.height + CWMomentUI.kCellPaddingPic)
                default:
                    origin.x = CGFloat(i%3) * (picSize.width + CWMomentUI.kCellPaddingPic)
                    origin.y = CGFloat(i/3) * (picSize.height + CWMomentUI.kCellPaddingPic)
                }
                imageView.isHidden = false
                imageView.frame = CGRect(origin: origin, size: picSize)
                
                let imageModel = pics[i]                
                imageView.kf.setImage(with: imageModel.thumbnailURL, placeholder: nil)
                
            }
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tapAction(_ tap: UITapGestureRecognizer) {
        if let tag = tap.view?.tag, tap.state == .ended {
//            self.delegate?.shareCell(self, didClickImageAtIndex: tag-100)
        }
    }

}
