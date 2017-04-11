//
//  CWAboutController.swift
//  CWWeChat
//
//  Created by wei chen on 2017/4/12.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import YYText

class CWAboutController: CWBaseTableViewController {
    
    lazy var tableViewManager: CWTableViewManager = {
        return CWTableViewManager(tableView: self.tableView)
    }()
    
    //github链接
    var lienseLabel: YYLabel = {
        let lienseLabel = YYLabel()
        
        let textAttri = NSMutableAttributedString()
        
        let githubLink: NSString = "https://github.com/wei18810109052/CWWeChat"
        let content: NSString = "高仿微信 仅供学习\nhttps://github.com/wei18810109052/CWWeChat"
        
        textAttri.append(NSAttributedString(string: content as String))
        textAttri.yy_lineSpacing = 4.0
        textAttri.yy_alignment = .center
        
        let highlight = YYTextHighlight()
        highlight.setColor(UIColor.chatSystemColor())
        highlight.tapAction = ({containerView, text, range, rect in
            
            let url = URL(string: githubLink as String)!
            UIApplication.shared.openURL(url)
            
        })
        
        let range = content.range(of: githubLink as String)
        textAttri.yy_setTextHighlight(highlight, range: range)
        
        
        lienseLabel.attributedText = textAttri
        lienseLabel.textColor = UIColor.gray
        lienseLabel.font = UIFont.systemFont(ofSize: 12)
        lienseLabel.numberOfLines = 2
        return lienseLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "关于微信"
        
        setupItemData()
        p_addSnap()
        // Do any additional setup after loading the view.
    }
    
    func setupItemData() {
        let item1 = CWTableViewItem(title: "去评分")
        let item2 = CWTableViewItem(title: "功能介绍")
        let item3 = CWTableViewItem(title: "系统通知")
        let item4 = CWTableViewItem(title: "投诉")
 
        let section1 = CWTableViewSection(items: [item1, item2, item3, item4])
        tableViewManager.addSection(contentsOf: [section1])
    }
    
    func p_addSnap() {
        

        
    }
    
    

}
