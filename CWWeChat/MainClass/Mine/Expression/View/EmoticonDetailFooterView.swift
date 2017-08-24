//
//  EmoticonDetailFooterView.swift
//  CWWeChat
//
//  Created by wei chen on 2017/8/24.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import YYText
import Kingfisher
import SwiftyImage

class EmoticonDetailFooterView: UICollectionReusableView {
    
    var emoticonPackage: EmoticonPackage! {
        didSet {
            setupInfo()
        }
    }
    
    var userImageView: UIImageView!
    var userLabel: UILabel!
    
    
    var titleLabel: UILabel!
    // 赞赏
    var admireButton: UIButton!
    
    var admireLabel: YYLabel!
    
    var copyrightLabel: UILabel!
    // 服务声明
    var serveButton: UIButton!
    // 侵权投诉
    var tortButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        addSnap()
    }
    
    func setupUI() {
        
        titleLabel = UILabel()
        titleLabel.textColor = UIColor(hex: "#666")
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(titleLabel)

        
        admireButton = UIButton()
        let normalImage = UIImage.size(CGSize(width: 10, height: 10))
            .color(UIColor(hex: "#ff6a55")).corner(radius: 3).image.resizableImage()
        admireButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        admireButton.setBackgroundImage(normalImage.resizableImage(), for: .normal)
        admireButton.setTitle("赞赏", for: .normal)
        self.addSubview(admireButton)

        
        admireLabel = YYLabel()
        self.addSubview(admireLabel)
        
        copyrightLabel = UILabel()
        copyrightLabel.textColor = UIColor(hex: "#666")
        copyrightLabel.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(copyrightLabel)
        
        serveButton = UIButton(type: .custom)
        self.addSubview(serveButton)

        tortButton = UIButton(type: .custom)
        self.addSubview(tortButton)

    }
    
    func addSnap() {
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(30)
        }
        
        admireButton.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 75, height: 32))
            make.centerX.equalTo(self)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
        
        admireLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(admireButton.snp.bottom).offset(20)
        }
        
        copyrightLabel.snp.makeConstraints { (make) in
            make.top.equalTo(admireLabel.snp.bottom).offset(20)
            make.centerX.equalTo(self)
        }
        
    }
    
    func setupInfo() {
        
        guard let author = emoticonPackage.author else {
            return
        }
        titleLabel.text = "我用小心心换红包了啦"
        
        
        let highlightBorder = YYTextBorder()
        highlightBorder.insets = UIEdgeInsets(top: -2, left: 0, bottom: -2, right: 2)
        highlightBorder.fillColor = UIColor.clear
        
        let nameText = NSMutableAttributedString(string: "9175")
        nameText.yy_color = UIColor(hex: "#576b95")
        nameText.yy_font = UIFont.systemFont(ofSize: 13)
        
        let hightLight = YYTextHighlight()
        hightLight.setBackgroundBorder(highlightBorder)
        nameText.yy_setTextHighlight(hightLight, range: NSMakeRange(0, nameText.length))
        
        let admireAttri = NSMutableAttributedString()
        admireAttri.append(nameText)
        
        let textAttri = NSMutableAttributedString(string: "人已赞赏")
        textAttri.yy_color = UIColor(hex: "#666")
        textAttri.yy_font = UIFont.systemFont(ofSize: 13)
        admireAttri.append(textAttri)
        
        admireLabel.attributedText = admireAttri
        
        copyrightLabel.text = "Copyright © \(author.name)"
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
