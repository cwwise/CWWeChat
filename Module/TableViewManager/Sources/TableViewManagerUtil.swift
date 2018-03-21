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

func textHeightOfText(_ text: String?, width: CGFloat, attributes: [NSAttributedStringKey:AnyObject] ) -> CGFloat {
    
    guard let text = text else {
        return 0
    }
    
    let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
    let contentSize = text.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil).size
    return ceil(contentSize.height)
}
