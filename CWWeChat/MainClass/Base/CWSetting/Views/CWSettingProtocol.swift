//
//  CWSettingProtocol.swift
//  CWWeChat
//
//  Created by chenwei on 16/5/31.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import Foundation
import UIKit

protocol CWSettingSwitchCellDelegate: class {
    func settingSwitchCellForItem(item: CWSettingItem, didChangeStatus status: Bool)
}

protocol CWSettingDataProtocol: class {
    var settingItem: CWSettingItem! {set get}
}

protocol CWTableViewCellIdentifierProtocol {
    static var reuseIdentifier: String {get}
}

extension CWTableViewCellIdentifierProtocol where Self: UITableViewCell {
    static var reuseIdentifier: String {
        return NSStringFromClass(self).componentsSeparatedByString(".").last! as String
    }
}

extension CWTableViewCellIdentifierProtocol where Self: UITableViewHeaderFooterView {
    static var reuseIdentifier: String {
        return NSStringFromClass(self).componentsSeparatedByString(".").last! as String
    }
}

extension UITableViewCell: CWTableViewCellIdentifierProtocol  {
    class var identifier: String {
        return self.reuseIdentifier
    }
}

extension UITableViewHeaderFooterView: CWTableViewCellIdentifierProtocol  {
    class var identifier: String {
        return self.reuseIdentifier
    }
}
