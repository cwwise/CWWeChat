//
//  CWChatImageView.swift
//  CWWeChat
//
//  Created by chenwei on 16/4/6.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

/// 图片发送部分进度view
class CWChatImageView: UIImageView {
    
    //引导
    let activityView = UIActivityIndicatorView(activityIndicatorStyle: .white)
    
    let indicatorbackgroundView:UIView = {
        let indicatorbackgroundView = UIView()
        indicatorbackgroundView.backgroundColor = UIColor(hex: "#808080").alpha(0.8)
        return indicatorbackgroundView
    }()
    
    let indicatorLabel:UILabel = {
        let indicatorLabel = UILabel()
        indicatorLabel.font = UIFont.systemFont(ofSize: 11)
        indicatorLabel.textAlignment = .center
        indicatorLabel.textColor = UIColor.white
        indicatorLabel.text = "00%"
        return indicatorLabel
    }()
    
    init() {
        super.init(frame: CGRect.zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    func setupUI() {
        self.addSubview(indicatorbackgroundView)
        self.addSubview(activityView)
        self.addSubview(indicatorLabel)
        
        hideProgressView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
                
        self.indicatorbackgroundView.frame = self.bounds
        self.activityView.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY-10)
        
        let size = CGSize(width: 100, height: 15)
        let origin = CGPoint(x: self.bounds.midX-50, y: self.bounds.midY)
        
        self.indicatorLabel.frame = CGRect(origin: origin, size: size)        
    }
    
    func hideProgressView()  {
        //初始化状态
        self.indicatorbackgroundView.isHidden = true
        self.activityView.stopAnimating()
        self.indicatorLabel.isHidden = true 
    }
    
    func showProgress(_ progress: Int) {
        self.indicatorbackgroundView.isHidden = false
        self.activityView.startAnimating()
        
        self.indicatorLabel.isHidden = false
        self.indicatorLabel.text = "\(progress)%"
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
