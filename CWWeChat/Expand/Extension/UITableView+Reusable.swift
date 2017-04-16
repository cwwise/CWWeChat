//
//  UITableViewCell+Reusable.swift
//  CWWeChat
//
//  Created by chenwei on 2017/3/27.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

protocol Reusable: class {
    static var identifier: String { get }
}

extension Reusable  {
    static var identifier: String { return String(describing: self) }
}

extension UITableViewCell: Reusable {}
extension UICollectionViewCell: Reusable {}

extension UITableViewHeaderFooterView: Reusable {}

extension UITableView {

    final func register<T: UITableViewCell>(cellType: T.Type) where T: Reusable {
        self.register(cellType.self, forCellReuseIdentifier: cellType.identifier)
    }
    
    final func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T
        where T: Reusable {
            guard let cell = self.dequeueReusableCell(withIdentifier: cellType.identifier, for: indexPath) as? T else {
                fatalError(
                    "Failed to dequeue a cell with identifier \(cellType.identifier) matching type \(cellType.self). "
                )
            }
            return cell
    }
    
    
    final func register<T: UITableViewHeaderFooterView>(headerFooterViewType: T.Type)
        where T: Reusable {
            self.register(headerFooterViewType.self, forHeaderFooterViewReuseIdentifier: headerFooterViewType.identifier)
    }
    
    final func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_ viewType: T.Type = T.self) -> T?
        where T: Reusable {
            guard let view = self.dequeueReusableHeaderFooterView(withIdentifier: viewType.identifier) as? T? else {
                fatalError(
                    "Failed to dequeue a header/footer with identifier \(viewType.identifier) "
                        + "matching type \(viewType.self). "
                )
            }
            return view
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
