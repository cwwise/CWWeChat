//
//  CWTableView+Dequeuing.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/29.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

protocol Reusable: class {
    static var reuseIdentifier: String { get }
}

extension Reusable  {
    static var reuseIdentifier: String { return String(Self) }
}

extension UITableView {
    
    func registerReusableCell<T: UITableViewCell where T: Reusable>(_: T.Type) {
        registerClass(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell where T: Reusable>(indexPath indexPath: NSIndexPath) -> T {
        return dequeueReusableCellWithIdentifier(T.reuseIdentifier, forIndexPath: indexPath) as! T
    }
    
    func insertRowsAtBottom(rows: [NSIndexPath]) {
        //保证 insert row 不闪屏
        UIView.setAnimationsEnabled(false)
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        self.beginUpdates()
        self.insertRowsAtIndexPaths(rows, withRowAnimation: .None)
        self.endUpdates()
        self.scrollToRowAtIndexPath(rows[0], atScrollPosition: .Bottom, animated: false)
        CATransaction.commit()
        UIView.setAnimationsEnabled(true)
    }
}