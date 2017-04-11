//
//  CWShareLayout.swift
//  CWWeChat
//
//  Created by wei chen on 2017/3/30.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import YYText

class CWShareLayout: NSObject {
    
    var shareModel: CWShareModel
    /// 顶部留白
    var marginTop: CGFloat = 0
    /// 下边留白
    var marginBottom: CGFloat = 0
    /// 总高度
    var height: CGFloat = 0
    /// 姓名(包括留白)
    var profileHeight: CGFloat = 0
    /// 布局
    var nameTextLayout: YYTextLayout?
    
    /// 文本高度
    var textHeight: CGFloat = 0
    /// 文本布局
    var textLayout: YYTextLayout?
    /// 图片部分高度
    var pictureHeight: CGFloat = 0
    /// 图片大小
    var pictureSize: CGSize = .zero
    
    // 时间
    var timeTextLayout: YYTextLayout?
    // 点赞部分
    var praiseHeight: CGFloat = 0
    var praiseLayout: YYTextLayout?
    
    var commentHeight: CGFloat = 0
    var commentLayoutArray = [YYTextLayout]()

    init(shareModel: CWShareModel) {
        self.shareModel = shareModel
    }
    
    // 更新时间字符串
    func updateDate()  {
        
    }
    
    /// 文字布局
    
    
    
    /// 布局图片部分
    func _layoutPicture() {
       
        if shareModel.imageArray.count == 0 {
            return
        }
        
        var picSize = CGSize.zero
        var picHeight: CGFloat = 0
        
        let scale = kScreenWidth / 375.0
        let len1_3 = YYTextCGFloatPixelRound(CWShareUI.kImageWidth * scale)
        let maxLen = YYTextCGFloatPixelRound(CWShareUI.kImageMaxWidth * scale)
        
        switch shareModel.imageArray.count {
        case 1:
            // 待修改，如果一张照片按比较计算size
            picSize = CGSize(width: maxLen, height: maxLen)
            picHeight = maxLen
        case 2,3:
            picSize = CGSize(width: len1_3, height: len1_3)
            picHeight = len1_3
        case 4,5,6:
            picSize = CGSize(width: len1_3, height: len1_3)
            picHeight = len1_3*2 + CWShareUI.kCellPaddingPic
        default:
            picSize = CGSize(width: len1_3, height: len1_3)
            picHeight = len1_3*3 + CWShareUI.kCellPaddingPic*2
        }
        
        self.pictureSize = picSize
        self.pictureHeight = picHeight
    }
    
    func _layoutTime() {
        
        guard let _ = shareModel.createdAt else {
            timeTextLayout = nil
            return
        }
        
        let timeString = "2017年8月"
        let timeText = NSMutableAttributedString(string: timeString)
        timeText.yy_font = UIFont.systemFont(ofSize: 12)
        timeText.yy_color = CWShareUI.kGrayTextColor
        
        
        let container = YYTextContainer(size: CGSize(width: 100, height: 20))
        container.maximumNumberOfRows = 1
        timeTextLayout = YYTextLayout(container: container, text: timeText)
    }
    
    func _layoutPraiseText() {
        
        let praiseArray = shareModel.praiseArray
        if praiseArray.count == 0 {
            return
        }
        
        let highlightBorder = YYTextBorder()
        highlightBorder.insets = UIEdgeInsets(top: -2, left: 0, bottom: -2, right: 2)
        highlightBorder.fillColor = CWShareUI.kTextHighlightBackgroundColor
        
        var praiseAttri = NSMutableAttributedString()
        
        let praiseFont = UIFont.systemFont(ofSize: 14)
        let icon = UIImage(named: "")
        let iconSize = CGSize(width: 18, height: 18)
        let attach = NSMutableAttributedString.yy_attachmentString(withContent: icon, contentMode: .scaleAspectFit, attachmentSize: iconSize, alignTo: praiseFont, alignment: .center)
        
        praiseAttri.append(attach)
        
        let size = CGSize(width: <#T##CGFloat#>, height: <#T##CGFloat#>)

        
        
        
    }
    
}
