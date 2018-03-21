//
//  BoolCell.swift
//  EFTableViewManager
//
//  Created by chenwei on 2017/10/2.
//

import UIKit

class BoolCell: BaseCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryView = cellSwitch
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func cellWillAppear() {
        super.cellWillAppear()
        
        guard let booItem = self.item as? BoolItem else {
            self.cellSwitch.isOn = false
            return
        }
        self.cellSwitch.isOn = booItem.value
    }
    
    
    @objc func switchChangeStatus(_ cellSwitch: UISwitch) {
       
        guard let booItem = self.item as? BoolItem,
        let handele = booItem.switchChangeHandler else {
            return
        }
        booItem.value = cellSwitch.isOn
        handele(booItem)
    }
    
    private lazy var cellSwitch: UISwitch = {
        let cellSwitch = UISwitch()
        cellSwitch.addTarget(self, action: #selector(switchChangeStatus(_:)), for: .valueChanged)
        return cellSwitch
    }()  

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
