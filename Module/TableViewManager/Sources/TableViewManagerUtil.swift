//
//  TableViewManagerUtil.swift
//  EFTableViewManager
//
//  Created by chenwei on 2017/10/2.
//

import UIKit

protocol Reusable: class {
    static var identifier: String { get }
}

extension UITableViewCell: Reusable {
    static var identifier: String { return String(describing: self) }
}

extension UITableViewHeaderFooterView: Reusable {
    static var identifier: String { return String(describing: self) }
}
