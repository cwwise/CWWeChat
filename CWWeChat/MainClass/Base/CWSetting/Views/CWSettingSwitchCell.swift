//
//  CWSettingSwitchCell.swift
//  CWWeChat
//
//  Created by chenwei on 16/5/31.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit



class CWSettingSwitchCell: UITableViewCell, CWSettingDataProtocol {

    weak var delegate: CWSettingSwitchCellDelegate?
    
    var settingItem: CWSettingItem! {
        didSet {
            setupItem()
        }
    }
    
    private lazy var cellSwitch:UISwitch = {
        let cellSwitch = UISwitch()
        cellSwitch.addTarget(self, action: #selector(switchChangeStatus(_:)), forControlEvents: .ValueChanged)
        return cellSwitch
    }()
    
    private lazy var titleLabel:UILabel = {
        let titleLabel = UILabel()
        return titleLabel
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(titleLabel)
        self.accessoryView = cellSwitch
        
        p_addSnap()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: 添加约束
    func p_addSnap() {
        
        self.titleLabel.snp_makeConstraints { (make) in
            make.centerY.equalTo(self.contentView)
            make.left.equalTo(self.contentView).offset(settingCellLeftMargin)
            make.right.lessThanOrEqualTo(self.contentView).offset(-settingCellLeftMargin)
        }
        
    }
    
    func setupItem() {
        self.titleLabel.text = settingItem.title
    }
    
    func switchChangeStatus(cellSwitch: UISwitch) {
        if let delegate = self.delegate {
            delegate.settingSwitchCellForItem(settingItem,didChangeStatus: cellSwitch.on)
        }
    }
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
