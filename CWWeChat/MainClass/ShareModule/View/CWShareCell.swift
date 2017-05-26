//
//  CWMomentCell.swift
//  CWWeChat
//
//  Created by wei chen on 2017/3/30.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import YYText
import YYWebImage
import RxSwift

protocol CWMomentCellDelegate: NSObjectProtocol {
    
    func shareCell(_ cell:CWMomentCell, didClickImageAtIndex index:Int)
    
    func shareCell(_ cell:CWMomentCell, didClickInText text:NSAttributedString, textRange: NSRange)
}


class CWMomentCell: UITableViewCell {
    
    weak var delegate: CWMomentCellDelegate?
    var cellLayout: CWMomentLayout?

    // 头像
    lazy var avatarImageView: UIImageView = {
        let avatarView = UIImageView()
        avatarView.origin = CGPoint(x: CWMomentUI.kTopMargin, y: CWMomentUI.kLeftMargin)
        avatarView.size = CWMomentUI.kAvatarSize
        return avatarView
    }()
    // 用户名
    lazy var nameLabel: YYLabel = {
        let nameLabel = YYLabel()
        nameLabel.origin = CGPoint(x: self.avatarImageView.right+CWMomentUI.kPaddingText, y: CWMomentUI.kTopMargin)
        nameLabel.size = CWMomentUI.kUsernameSize
        return nameLabel
    }()
    // 内容
    lazy var contentLabel: YYLabel = {
        let contentLabel = YYLabel()
        contentLabel.left = self.nameLabel.left
        contentLabel.width = CWMomentUI.kContentWidth
        return contentLabel
    }()
    
    // 图片
    var pictureViews: [UIImageView] = [UIImageView]()
    
    lazy var timeLabel: YYLabel = {
        let timeLabel = YYLabel()
        timeLabel.left = self.nameLabel.left
        timeLabel.size = CGSize(width: 120, height: 17)
        return timeLabel
    }()
    
    lazy var toolButton: UIButton = {
        let toolButton = UIButton(type: .custom)
        toolButton.size = CGSize(width: 20, height: 17)
        toolButton.setImage(UIImage(named: "share_action"), for: .normal)
        return toolButton
    }()
    
    // 评论部分
    lazy var commnetView: CWMomentCommentView = {
        let commnetView = CWMomentCommentView()
        return commnetView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupUI()
    }

    func setupUI() {
        // 头像 姓名
        self.contentView.addSubview(avatarImageView)
        self.contentView.addSubview(nameLabel)
        // 文字
        self.contentView.addSubview(contentLabel)
        // 布置图片部分
        for i in 0..<9 {
            
            let imageView = UIImageView()
            imageView.isHighlighted = true
            imageView.clipsToBounds = true
            imageView.backgroundColor = UIColor.gray
            imageView.isUserInteractionEnabled = true
            imageView.tag = 100+i
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction(_:)))
            imageView.addGestureRecognizer(tap)
            
            pictureViews.append(imageView)
            self.contentView.addSubview(imageView)
        }
        self.contentView.addSubview(timeLabel)
        self.contentView.addSubview(toolButton)
        self.contentView.addSubview(commnetView)
        
    }
    
    func tapAction(_ tap: UITapGestureRecognizer) {
        if let tag = tap.view?.tag, tap.state == .ended {
            self.delegate?.shareCell(self, didClickImageAtIndex: tag-100)
        }
    }
    
    func setLayout(_ layout: CWMomentLayout) {
    
        if layout === cellLayout {
            return
        }
        
        self.cellLayout = layout
        let share = layout.shareModel
        // 头像
        
        let avatarURL = URL(string: "\(kImageBaseURLString)\(share.userId).jpg")
        self.avatarImageView.yy_setImage(with: avatarURL, placeholder: defaultHeadeImage)
        // 姓名
        self.nameLabel.textLayout = layout.nameTextLayout
        
        var top: CGFloat = 0
        top += layout.marginTop
        top += layout.profileHeight
        
        // 文字
        top += layout.textMargin
        self.contentLabel.textLayout = layout.textLayout
        self.contentLabel.height = layout.textHeight
        self.contentLabel.top = top
        top += layout.textHeight

        // 图片
        top += layout.pictureMargin
        self.setImageViewsWithTop(top)
        top += layout.pictureHeight
        
        // 时间和操作
        self.toolButton.top = top + 8
        self.toolButton.right = kScreenWidth - CWMomentUI.kLeftMargin

        self.timeLabel.textLayout = layout.timeTextLayout
        self.timeLabel.top = top + 8
        
        top += layout.timeHeight
        // 点赞和评论列表
        let frame = CGRect(x: contentLabel.left, y: top,
                           width: CWMomentUI.kContentWidth, height: layout.commentHeight)
        self.commnetView.frame = frame
        
    }
    
    func setImageViewsWithTop(_ imageTop: CGFloat) {
        guard let layout = cellLayout else {
            return
        }
        
        
        let leftMarigin = self.contentLabel.left
        
        let picSize = layout.pictureSize
        let pics = layout.shareModel.imageArray
        let picsCount = layout.shareModel.imageArray.count
        
        for i in 0..<9 {
            let imageView = pictureViews[i]
            if i >= picsCount {
                imageView.yy_cancelCurrentImageRequest()
                imageView.isHidden = true
            } else {
                var origin = CGPoint.zero
                switch picsCount {
                case 1:
                    origin.x = leftMarigin
                    origin.y = imageTop
                case 4:
                    origin.x = leftMarigin + CGFloat(i%2) * (picSize.width + CWMomentUI.kCellPaddingPic)
                    origin.y = imageTop + CGFloat(i/2) * (picSize.height + CWMomentUI.kCellPaddingPic)
                default:
                    origin.x = leftMarigin + CGFloat(i%3) * (picSize.width + CWMomentUI.kCellPaddingPic)
                    origin.y = imageTop + CGFloat(i/3) * (picSize.height + CWMomentUI.kCellPaddingPic)
                }
                imageView.isHidden = false
                imageView.frame = CGRect(origin: origin, size: picSize)
                imageView.layer.removeAnimation(forKey: "contents")
                
                let imageModel = pics[i]
                
                imageView.yy_setImage(with: imageModel.thumbnailURL, placeholder: nil)
                
            }
            
        }
        
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
