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
    static var reuseIdentifier: String { return String(describing: self) }
}

extension UITableView {

    func registerReusableCell<T: UITableViewCell>(_: T.Type) where T: Reusable {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func registerHeaderFooterReusableCell<T: UITableViewHeaderFooterView>(_: T.Type) where T: Reusable {
        register(T.self, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath) -> T where T: Reusable {
        return self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
    
    func insertRowsAtBottom(_ rows: [IndexPath]) {
        //保证 insert row 不闪屏
        UIView.setAnimationsEnabled(false)
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        self.beginUpdates()
        self.insertRows(at: rows, with: .none)
        self.endUpdates()
        self.scrollToRow(at: rows[0], at: .bottom, animated: false)
        CATransaction.commit()
        UIView.setAnimationsEnabled(true)
    }
}
