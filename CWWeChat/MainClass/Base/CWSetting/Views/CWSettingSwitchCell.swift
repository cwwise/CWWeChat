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
    
    fileprivate lazy var cellSwitch:UISwitch = {
        let cellSwitch = UISwitch()
        cellSwitch.addTarget(self, action: #selector(switchChangeStatus(_:)), for: .valueChanged)
        return cellSwitch
    }()
    
    fileprivate lazy var titleLabel:UILabel = {
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
        self.selectionStyle = .none
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
    
    func switchChangeStatus(_ cellSwitch: UISwitch) {
        if let delegate = self.delegate {
            delegate.settingSwitchCellForItem(settingItem,didChangeStatus: cellSwitch.isOn)
        }
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
