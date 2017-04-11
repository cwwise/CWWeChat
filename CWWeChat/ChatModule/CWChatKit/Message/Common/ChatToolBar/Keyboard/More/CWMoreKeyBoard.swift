//
//  CWMoreKeyBoard.swift
//  CWWeChat
//
//  Created by wei chen on 2017/4/11.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

public protocol CWMoreKeyBoardDelegate: NSObjectProtocol {
    func moreKeyBoard(_ keyboard: CWMoreKeyBoard, didSelect item: CWMoreKeyboardItem)
}

public class CWMoreKeyBoard: UIView {
    
    public static let share = CWMoreKeyBoard()
    
    private convenience init() {
        let size = CGSize(width: kScreenWidth, height: 216)
        let origin = CGPoint(x: 0, y: kScreenHeight-size.height)
        let frame = CGRect(origin: origin, size: size)
        self.init(frame: frame)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    weak var deleagte: CWMoreKeyBoardDelegate?
    
    // 加载items
    func loadMoreItems(_ items: [CWMoreKeyboardItem]) {
        
        
    }
    
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
