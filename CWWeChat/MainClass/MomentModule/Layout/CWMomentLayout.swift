//
//  CWMomentLayout.swift
//  CWWeChat
//
//  Created by wei chen on 2017/3/30.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import YYText

class CWMomentLayout: NSObject {
    
    var moment: CWMoment
    /// 顶部留白
    var marginTop: CGFloat = CWMomentUI.kTopMargin
    /// 下边留白
    var marginBottom: CGFloat = CWMomentUI.kTopMargin
    /// 总高度
    var height: CGFloat = 0
    
    
    // 头像
    var avatarFrame: CGRect = .zero
    // 用户名
    var usernameFrame: CGRect = .zero
    /// 布局
    var usernameTextLayout: YYTextLayout?
    
    /// 文字和用户名的距离
    private var contentTopMargin: CGFloat = 6
    var contentFrame: CGRect = .zero
    /// 文本布局
    var contentTextLayout: YYTextLayout?

    // 图片或者新闻 音乐
    var multimediaFrame: CGRect = .zero
    /// 图片大小(待修改 如果图片只有一张需要根据比例算)
    var pictureSize: CGSize = .zero
    
    var toolButtonFrame: CGRect = .zero
    
    var timeFrame: CGRect = .zero
    // 时间
    var timeTextLayout: YYTextLayout?
    
    // 点赞部分
    var praiseHeight: CGFloat = 0
    var praiseLayout: YYTextLayout?
    
    var commentHeight: CGFloat = 0
    var commentLayoutArray = [YYTextLayout]()

    init(moment: CWMoment) {
        self.moment = moment
        super.init()
        self.layout()
    }
    
    func layout() {
      
        var origin = CGPoint(x: CWMomentUI.kTopMargin, y: CWMomentUI.kLeftMargin)
        var size = CWMomentUI.kAvatarSize
        avatarFrame = CGRect(origin: origin, size: size)
                
        self.layoutProfile()
        self.layoutContent()
        
        self.layoutPicture()
        self.layoutNews()
        self.layoutTime()
        
        size = CGSize(width: 20, height: 17)
        origin = CGPoint(x: kScreenWidth - CWMomentUI.kLeftMargin-size.width, y: multimediaFrame.maxY+8)
        toolButtonFrame = CGRect(origin: origin, size: size)

        self.layoutPraiseText()
    
        // 图片
        height += timeFrame.maxY
        
        commentHeight = 40
        height += commentHeight
    
        height += marginBottom
    }
    
    // 更新时间字符串
    func updateDate()  {
        
    }
    
    func layoutProfile() {
        
        let username = NSMutableAttributedString(string: moment.username)
        username.yy_color = CWMomentUI.kNameTextColor
        username.yy_font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        
        let container = YYTextContainer(size: CWMomentUI.kUsernameSize)
        usernameTextLayout = YYTextLayout(container: container, text: username)
        
        let origin = CGPoint(x: avatarFrame.maxX+CWMomentUI.kPaddingText, y: CWMomentUI.kTopMargin)
        let size = CWMomentUI.kUsernameSize
        usernameFrame = CGRect(origin: origin, size: size)
    }
    
    /// 文字布局
    func layoutContent() {

        guard let content = moment.content else {
            self.contentFrame = CGRect(x: usernameFrame.minX, y: usernameFrame.maxY+contentTopMargin,
                                       width: CWMomentUI.kContentWidth, height: 0)
            return
        }
        
        let size = CGSize(width: CWMomentUI.kContentWidth, height: CGFloat.greatestFiniteMagnitude)

        let textFont = UIFont.systemFont(ofSize: 15)
        let attributes = [NSAttributedStringKey.font: textFont,
                          NSAttributedStringKey.foregroundColor: UIColor.black]
        
        let modifier = CWTextLinePositionModifier(font: textFont)
        // YYTextContainer
        let textContainer = YYTextContainer(size: size)
        textContainer.linePositionModifier = modifier
        textContainer.maximumNumberOfRows = 0
        
        let textAttri = CWChatTextParser.parseText(content, attributes: attributes)!
        let textLayout = YYTextLayout(container: textContainer, text: textAttri)!
        
        self.contentTextLayout = textLayout
        
        // 计算高度
        let textHeight = modifier.heightForLineCount(Int(textLayout.rowCount))
        self.contentFrame = CGRect(x: usernameFrame.minX, y: usernameFrame.maxY+contentTopMargin,
                                   width: CWMomentUI.kContentWidth, height: textHeight)
    }
    
    /// 布局图片部分
    func layoutPicture() {
       
        if moment.imageArray.count == 0 {
            self.multimediaFrame = CGRect(x: usernameFrame.minX, y: contentFrame.maxY+10,
                                          width: CWMomentUI.kContentWidth, height: 0)
            return
        }
        
        var picSize = CGSize.zero
        var picHeight: CGFloat = 0
        
        let scale = kScreenWidth / 375.0
        let len1_3 = YYTextCGFloatPixelRound(CWMomentUI.kImageWidth * scale)
        let maxLen = YYTextCGFloatPixelRound(CWMomentUI.kImageMaxWidth * scale)
        
        switch moment.imageArray.count {
        case 1:
            // 待修改，如果一张照片按比较计算size
            if moment.imageArray.first?.size == CGSize.zero {
                picSize = CGSize(width: maxLen, height: maxLen)
            } else {
                let imageSize = moment.imageArray.first!.size
                // 判断图片是长图
                //根据图片的比例大小计算图片的frame
                if imageSize.width > imageSize.height {
                    var height = kChatImageMaxWidth * imageSize.height / imageSize.width
                    height = max(kChatImageMinWidth, height)
                    picSize = CGSize(width: ceil(kChatImageMaxWidth), height: ceil(height))
                } else {
                    var width = kChatImageMaxWidth * imageSize.width / imageSize.height
                    width = max(kChatImageMinWidth, width)
                    picSize = CGSize(width: ceil(width), height: ceil(kChatImageMaxWidth))
                }
            }
            
            picHeight = picSize.height
        case 2,3:
            picSize = CGSize(width: len1_3, height: len1_3)
            picHeight = len1_3
        case 4,5,6:
            picSize = CGSize(width: len1_3, height: len1_3)
            picHeight = len1_3*2 + CWMomentUI.kCellPaddingPic
        default:
            picSize = CGSize(width: len1_3, height: len1_3)
            picHeight = len1_3*3 + CWMomentUI.kCellPaddingPic*2
        }
        
        self.pictureSize = picSize
        self.multimediaFrame = CGRect(x: usernameFrame.minX, y: contentFrame.maxY+10,
                                      width: CWMomentUI.kContentWidth, height: picHeight)
    }
    
    func layoutNews() {
        if (moment.multimedia != nil) && moment.type == .url {
            self.multimediaFrame = CGRect(x: usernameFrame.minX, y: contentFrame.maxY+10,
                                          width: CWMomentUI.kContentWidth, height: 50)
        } 
        
    }
    
    func layoutTime() {
        
        var timeString = "2017年8月 "
        if let source = moment.multimedia?.source {
            timeString += source
        }
        let timeText = NSMutableAttributedString(string: timeString)
        timeText.yy_font = UIFont.systemFont(ofSize: 12)
        timeText.yy_color = CWMomentUI.kGrayTextColor
        
        let width: CGFloat = 200
        
        let container = YYTextContainer(size: CGSize(width: width, height: 20))
        container.maximumNumberOfRows = 1
        timeTextLayout = YYTextLayout(container: container, text: timeText)

        self.timeFrame = CGRect(x: usernameFrame.minX, y: multimediaFrame.maxY+8, 
                                width: width, height: 17)
    }
    
    func layoutPraiseText() {
        
        let praiseArray = moment.praiseArray
        if praiseArray.count == 0 {
            return
        }
        
        let highlightBorder = YYTextBorder()
        highlightBorder.insets = UIEdgeInsets(top: -2, left: 0, bottom: -2, right: 2)
        highlightBorder.fillColor = CWMomentUI.kTextHighlightBackgroundColor
        
        let praiseAttri = NSMutableAttributedString()
        
        let praiseFont = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        let icon = UIImage(named: "momentHeart")
        let iconSize = CGSize(width: 18, height: 16)
        let attach = NSMutableAttributedString.yy_attachmentString(withContent: icon, contentMode: .scaleAspectFit, attachmentSize: iconSize, alignTo: praiseFont, alignment: .center)
        
        praiseAttri.append(attach)
        
        for praise in praiseArray {
            
            let nameText = NSMutableAttributedString(string: praise.username)
            nameText.yy_color = CWMomentUI.kNameTextColor
            nameText.yy_font = praiseFont

            let hightLight = YYTextHighlight()
            hightLight.setBackgroundBorder(highlightBorder)
            hightLight.userInfo = ["userId": praise.userId]
            
            nameText.yy_setTextHighlight(hightLight, range: NSMakeRange(0, nameText.length))
            
            praiseAttri.append(nameText)
            // 最后不需要添加,
            if praise === praiseArray.last {
                let divisionText = NSMutableAttributedString(string: "，")
                divisionText.yy_font = praiseFont
                divisionText.yy_color = CWMomentUI.kNameTextColor
                praiseAttri.append(divisionText)
            }
            
        }
    
    }
    
    // 布局回复
    func layoutComment() {
        
        let commentArray = moment.commentArray
        if commentArray.count == 0 {
            return
        }
        
        let highlightBorder = YYTextBorder()
        highlightBorder.insets = UIEdgeInsets(top: -2, left: 0, bottom: -2, right: 2)
        highlightBorder.fillColor = CWMomentUI.kTextHighlightBackgroundColor
        
        let commentAttri = NSMutableAttributedString()

        
        
        
    }
    
}
