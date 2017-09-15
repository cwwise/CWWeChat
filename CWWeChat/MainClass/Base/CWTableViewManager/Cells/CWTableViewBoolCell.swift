//
//  CWTableViewBoolCell.swift
//  CWWeChat
//
//  Created by wei chen on 2017/2/11.
//  Copyright © 2017年 chenwei. All rights reserved.
//

import UIKit

// switch cell
class CWTableViewBoolCell: CWTableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.accessoryView = cellSwitch
        self.selectionStyle = .none
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func cellWillAppear() {
        super.cellWillAppear()
        
        guard let booItem = self.item as? CWBoolItem else {
            self.cellSwitch.isOn = false
            return
        }
        self.cellSwitch.isOn = booItem.value
    }
    
    
    @objc func switchChangeStatus(_ cellSwitch: UISwitch) {
        if let _ = self.delegate {

        }
    }
    
    
    fileprivate lazy var cellSwitch:UISwitch = {
        let cellSwitch = UISwitch()
        cellSwitch.addTarget(self, action: #selector(switchChangeStatus(_:)), for: .valueChanged)
        return cellSwitch
    }()    
    
    
}
