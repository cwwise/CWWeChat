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
    /// 姓名(包括留白)
    var profileHeight: CGFloat = CWMomentUI.kUsernameSize.height
    /// 布局
    var nameTextLayout: YYTextLayout?
    
    /// 上边距
    var textMargin: CGFloat = 6
    /// 文本高度
    var textHeight: CGFloat = 0
    /// 文本布局
    var textLayout: YYTextLayout?
    /// 图片上边距
    var pictureMargin: CGFloat = 10
    /// 图片部分高度
    var pictureHeight: CGFloat = 0
    /// 图片大小
    var pictureSize: CGSize = .zero
    // 总高度
    var timeHeight: CGFloat = 33
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
      
        self.layoutProfile()
        self.layoutContent()
        self.layoutPicture()
        self.layoutTime()
        self.layoutPraiseText()

        height += marginTop
        height += profileHeight
        // 文本
        height += textMargin
        height += textHeight
        // 图片
        height += pictureMargin
        height += pictureHeight

        commentHeight = 40
        
        // 时间label中间的间隔
        height += timeHeight
        
        height += commentHeight
        
        height += marginBottom
    }
    
    // 更新时间字符串
    func updateDate()  {
        
    }
    
    func layoutProfile() {
        
        let username = NSMutableAttributedString(string: moment.username)
        username.yy_color = CWMomentUI.kNameTextColor
        username.yy_font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightMedium)
        
        let container = YYTextContainer(size: CWMomentUI.kUsernameSize)
        nameTextLayout = YYTextLayout(container: container, text: username)
    }
    
    /// 文字布局
    func layoutContent() {

        guard let content = moment.content else {
            return
        }
        
        let size = CGSize(width: CWMomentUI.kContentWidth, height: CGFloat.greatestFiniteMagnitude)

        let textFont = UIFont.systemFont(ofSize: 15)
        let attributes = [NSFontAttributeName: textFont,
                          NSForegroundColorAttributeName: UIColor.black]
        
        let modifier = CWTextLinePositionModifier(font: textFont)
        // YYTextContainer
        let textContainer = YYTextContainer(size: size)
        textContainer.linePositionModifier = modifier
        textContainer.maximumNumberOfRows = 0
        
        let textAttri = CWChatTextParser.parseText(content, attributes: attributes)!
        let textLayout = YYTextLayout(container: textContainer, text: textAttri)!
        
        self.textLayout = textLayout
        self.textHeight = modifier.heightForLineCount(Int(textLayout.rowCount))
    }
    
    /// 布局图片部分
    func layoutPicture() {
       
        if moment.imageArray.count == 0 {
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
            picSize = CGSize(width: maxLen, height: maxLen)
            picHeight = maxLen
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
        self.pictureHeight = picHeight
    }
    
    func layoutTime() {
        
        let timeString = "2017年8月"
        let timeText = NSMutableAttributedString(string: timeString)
        timeText.yy_font = UIFont.systemFont(ofSize: 12)
        timeText.yy_color = CWMomentUI.kGrayTextColor
        
        let container = YYTextContainer(size: CGSize(width: 100, height: 20))
        container.maximumNumberOfRows = 1
        timeTextLayout = YYTextLayout(container: container, text: timeText)
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
        
        let praiseFont = UIFont.systemFont(ofSize: 14, weight: UIFontWeightMedium)
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
