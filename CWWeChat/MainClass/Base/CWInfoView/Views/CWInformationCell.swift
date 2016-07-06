//
//  CWInformationCell.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/28.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

let left_infocell_subTitle_space = Screen_Width * 0.28

class CWInformationCell: UITableViewCell {

    var informationModel: CWInformationModel? {
        didSet {
            self.setupInfo()
        }
    }
    
    private lazy var subTitleLabel:UILabel = {
        let subTitleLabel = UILabel()
        subTitleLabel.font = UIFont.systemFontOfSize(15)
        return subTitleLabel
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.textLabel?.font = UIFont.systemFontOfSize(15)
        self.contentView.addSubview(subTitleLabel)
        
        p_addSnap()
    }
    
    func p_addSnap() {
        self.subTitleLabel.snp_makeConstraints { (make) in
            make.centerY.equalTo(self.contentView)
            make.right.equalTo(self.contentView)
            make.left.equalTo(self.contentView).offset(left_infocell_subTitle_space)
        }
    }
    
    func setupInfo() {
        guard let informationModel = informationModel else {
            return
        }
        
        self.textLabel?.text = informationModel.title
        self.subTitleLabel.text = informationModel.subTitle
        
        self.accessoryType = informationModel.showDisclosureIndicator ? .DisclosureIndicator : .None
        self.selectionStyle = informationModel.disableHighlight ? .None : .Default
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
