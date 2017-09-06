//
//  CWMomentCollectionCell.swift
//  CWWeChat
//
//  Created by wei chen on 2017/9/5.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import UIKit
import YYText

class CWMomentCollectionCell: UICollectionViewCell {
    
    // 头像
    lazy var avatarImageView: UIImageView = {
        let avatarView = UIImageView()
        return avatarView
    }()
    
    // 用户名
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        return nameLabel
    }()
    
    // 内容
    lazy var contentLabel: YYLabel = {
        let contentLabel = YYLabel()
        return contentLabel
    }()

    /// 图片
    lazy var pictureView: CWMomentPictureView = {
        let  pictureView = CWMomentPictureView()
        return pictureView
    }()
    
    lazy var multimediaView: CWMomentMultimediaView = {
        let frame = CGRect(x: 0, y: 0, width: CWMomentUI.kContentWidth, height: 50)
        let multimediaView = CWMomentMultimediaView(frame: frame)
        return multimediaView
    }()
    
    lazy var timeLabel: UILabel = {
        let timeLabel = UILabel()
        return timeLabel
    }()
    
    lazy var toolButton: UIButton = {
        let toolButton = UIButton(type: .custom)
        toolButton.setImage(UIImage(named: "share_action"), for: .normal)
        return toolButton
    }()
    
    // 评论部分
    lazy var commmetView: CWMomentCommentView = {
        let commmetView = CWMomentCommentView()
        return commmetView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    func setupUI() {
        // 头像 姓名
        self.contentView.addSubview(avatarImageView)
        self.contentView.addSubview(nameLabel)
        // 文字
        self.contentView.addSubview(contentLabel)
        self.contentView.addSubview(pictureView)
        self.contentView.addSubview(multimediaView)
        
        self.contentView.addSubview(timeLabel)
        self.contentView.addSubview(toolButton)
        self.contentView.addSubview(commmetView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension CWMomentCollectionCell {
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        
        let layoutAttributes = layoutAttributes as! CWMomentAttributes
        
        
        
        
    }
    
    
}

