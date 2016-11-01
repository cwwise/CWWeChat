//
//  CWChatImageView.swift
//  CWWeChat
//
//  Created by chenwei on 16/4/6.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit
import YYWebImage

///下载展示imageView
class CWChatImageView: UIView {
    
    /// 放置内容
    var contentImageView: UIImageView = {
        let contentImageView = UIImageView()
        contentImageView.backgroundColor = UIColor.gray
        return contentImageView
    }()
    //引导
    let activityView = UIActivityIndicatorView(activityIndicatorStyle: .white)
    
    let indicatorbackgroundView:UIView = {
        let indicatorbackgroundView = UIView()
        indicatorbackgroundView.backgroundColor = UIColor("#80808008")
        return indicatorbackgroundView
    }()
    
    let indicatorLable:UILabel = {
        let indicatorLable = UILabel()
        indicatorLable.font = UIFont.systemFont(ofSize: 11)
        indicatorLable.textAlignment = .center
        indicatorLable.textColor = UIColor.white
        indicatorLable.text = "00%"
        return indicatorLable
    }()
    
    ///用来分割
    lazy var maskLayer: CAShapeLayer = {
       let maskLayer = CAShapeLayer()
        maskLayer.contentsCenter = CGRect(x: 0.5, y: 0.6, width: 0.1, height: 0.1)
        maskLayer.contentsScale = UIScreen.main.scale
        return maskLayer
    }()
    
    ///用来分割
    var backgroundImage: UIImage? {
        didSet {
            self.maskLayer.contents = backgroundImage?.cgImage
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.mask = self.maskLayer
        self.addSubview(contentImageView)
        self.addSubview(indicatorbackgroundView)
        self.addSubview(activityView)
        self.addSubview(indicatorLable)
        
        //设置frame
        activityView.startAnimating()
        
        //初始化状态
        self.indicatorbackgroundView.isHidden = true
        self.activityView.stopAnimating()
        self.indicatorLable.isHidden = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.maskLayer.frame = self.bounds
        self.contentImageView.frame = self.bounds
        
        
        self.indicatorbackgroundView.frame = self.bounds
        self.activityView.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY-10)
        
        self.indicatorLable.frame.size = CGSize(width: 100, height: 15)
        self.indicatorLable.frame.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY+8)
    }
    
    func setThumbnailPath(_ imagePath: String?) {
        contentImageView.image = nil
        guard let imagePath = imagePath else {
            return
        }
        self.contentImageView.yy_imageURL = URL(fileURLWithPath: imagePath)
    }
    
    func setThumbnailURL(_ imageURL: String?) {
        contentImageView.image = nil
        guard let imageURL = imageURL else {
            return
        }
        
        let httpHost = "http://7xsmd8.com1.z0.glb.clouddn.com/"
        let url = URL(string: httpHost+imageURL)
        contentImageView.yy_setImage(with: url, placeholder: nil, options: [.showNetworkActivity, .ignoreDiskCache]) { (image, url, type, stage, error) in
            
            if let image = image {
                self.contentImageView.image = image
                let path = CWUserAccount.sharedUserAccount().pathUserChatImage(imageURL)
                FileManager.saveContentImage(image, imagePath: path)
                self.updateProgressView(1, result: .success)
            } else {
                self.updateProgressView(0, result: .fail)
            }            
        }

    }
    
    /// 更新cell状态
    func updateProgressView(_ progress:CGFloat, result: CWMessageUploadState) {
        
        if result == .loading {
            self.indicatorbackgroundView.isHidden = false
            self.activityView.startAnimating()
            self.indicatorLable.isHidden = false
            self.indicatorLable.text = String(format: "%02d%%",Int(progress*100))
        } else {
            self.indicatorbackgroundView.isHidden = true
            self.activityView.stopAnimating()
            self.indicatorLable.isHidden = true
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
