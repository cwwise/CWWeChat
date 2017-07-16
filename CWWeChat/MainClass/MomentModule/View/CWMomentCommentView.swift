//
//  CWMomentCommentView.swift
//  CWWeChat
//
//  Created by wei chen on 2017/5/3.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

/// 评论和点赞的 view
class CWMomentCommentView: UIView {

    var backgroundView: UIImageView = {
        let image = UIImage(named: "share_comment")
        let cap = UIEdgeInsets(top: 12, left: 50, bottom: 12, right: 50)
        let imageView = UIImageView()
        imageView.image = image?.resizableImage(withCapInsets: cap)
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        self.addSubview(backgroundView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundView.frame = self.bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    

}
