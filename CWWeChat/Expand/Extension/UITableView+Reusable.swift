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

