//
//  CWInformationCell.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/28.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

let left_infocell_subTitle_space = kScreenWidth * 0.28

class CWInformationCell: UITableViewCell {

    var informationModel: CWInformationModel? {
        didSet {
            self.setupInfo()
        }
    }
    
    fileprivate lazy var subTitleLabel:UILabel = {
        let subTitleLabel = UILabel()
        subTitleLabel.font = UIFont.systemFont(ofSize: 15)
        return subTitleLabel
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.textLabel?.font = UIFont.systemFont(ofSize: 15)
        self.contentView.addSubview(subTitleLabel)
        
        p_addSnap()
    }
    
    func p_addSnap() {
        self.subTitleLabel.snp.makeConstraints { (make) in
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
        
        self.accessoryType = informationModel.showDisclosureIndicator ? .disclosureIndicator : .none
        self.selectionStyle = informationModel.disableHighlight ? .none : .default
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
