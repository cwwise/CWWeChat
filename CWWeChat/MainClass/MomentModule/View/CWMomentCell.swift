//
//  CWMomentCell.swift
//  CWWeChat
//
//  Created by wei chen on 2017/3/30.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import YYText
import Kingfisher
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
        return avatarView
    }()
    // 用户名
    lazy var nameLabel: YYLabel = {
        let nameLabel = YYLabel()
        return nameLabel
    }()
    // 内容
    lazy var contentLabel: YYLabel = {
        let contentLabel = YYLabel()
        return contentLabel
    }()
        
    lazy var pictureView: CWMomentPictureView = {
        let  pictureView = CWMomentPictureView()
        return pictureView
    }()
    
    lazy var multimediaView: CWMomentMultimediaView = {
        let frame = CGRect(x: 0, y: 0, width: CWMomentUI.kContentWidth, height: 50)
        let multimediaView = CWMomentMultimediaView(frame: frame)
        return multimediaView
    }()
    
    lazy var timeLabel: YYLabel = {
        let timeLabel = YYLabel()
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
        self.contentView.addSubview(pictureView)
        self.contentView.addSubview(multimediaView)

        self.contentView.addSubview(timeLabel)
        self.contentView.addSubview(toolButton)
        self.contentView.addSubview(commmetView)
    }
    
    func setLayout(_ layout: CWMomentLayout) {
    
        if layout === cellLayout {
            return
        }
        
        self.cellLayout = layout
        let moment = layout.moment
        // 头像
        let avatarURL = URL(string: "\(kImageBaseURLString)\(moment.userId).jpg")
        self.avatarImageView.kf.setImage(with: avatarURL, placeholder: defaultHeadeImage)
        self.avatarImageView.frame = layout.avatarFrame
        // 姓名
        self.nameLabel.textLayout = layout.usernameTextLayout
        self.nameLabel.frame = layout.usernameFrame
        // 文字
        self.contentLabel.textLayout = layout.contentTextLayout
        self.contentLabel.frame = layout.contentFrame
        
        // 先隐藏
        self.pictureView.isHidden = true
        self.multimediaView.isHidden = true
        // 
        switch moment.type {
        case .normal: 
            self.pictureView.isHidden = false
            self.pictureView.setupView(with: layout.multimediaFrame, 
                                       imageArray: moment.imageArray,
                                       pictureSize: layout.pictureSize)
            break
        case .url,.music: 
            self.multimediaView.isHidden = false
            self.multimediaView.frame = layout.multimediaFrame

            if let multimedia = moment.multimedia {
                self.multimediaView.contentLabel.text = multimedia.title
                self.multimediaView.imageView.kf.setImage(with: multimedia.imageURL, placeholder: nil)
            }
            
            break
        default: break
            
        }
        
        // 时间和操作
        self.toolButton.frame = layout.toolButtonFrame

        self.timeLabel.textLayout = layout.timeTextLayout
        self.timeLabel.frame = layout.timeFrame
        
        let top: CGFloat = layout.timeFrame.maxY
        // 点赞和评论列表
        let frame = CGRect(x: contentLabel.left, y: top,
                           width: CWMomentUI.kContentWidth, height: layout.commentHeight)
        self.commmetView.frame = frame
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
