//
//  CWMyExpressionCell.swift
//  CWWeChat
//
//  Created by chenwei on 16/7/11.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit
import Kingfisher

protocol MyEmoticonCellDelegate: class{
    func emoticonCellDeleteButtonDown(cell: MyEmoticonCell)
}

class MyEmoticonCell: UITableViewCell {
    
    var delegate: MyEmoticonCellDelegate?

    var iconImageView: AnimatedImageView!
    
    var titleLabel: UILabel!
    
    var deleteButton: UIButton!
    
    var group: EmoticonPackage! {
        didSet {
            setupInfo()
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        addSnap()
    }
    
    func setupUI() {
        
        deleteButton = UIButton(type: .custom)
        deleteButton.backgroundColor = UIColor(hex: "#F8F8F8")
        deleteButton.setTitle("移除", for: .normal)
        deleteButton.setTitleColor(UIColor.black, for: .normal)
        deleteButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        deleteButton.addTarget(self, action: #selector(deleteButtonDown), for: .touchUpInside)
        self.contentView.addSubview(deleteButton)
        
        iconImageView = AnimatedImageView()
        iconImageView.autoPlayAnimatedImage = false
        iconImageView.contentMode = .scaleAspectFill
        self.addSubview(iconImageView)
        
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textColor = UIColor.black
        self.addSubview(titleLabel)
    }
    
    func addSnap() {
        iconImageView.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.left.equalTo(15)
            make.centerY.equalTo(self)
            make.height.equalTo(iconImageView.snp.width)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconImageView.snp.right).offset(15)
            make.centerY.equalTo(self)
            make.right.equalTo(-80)
        }
        
        deleteButton.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 60, height: 30))
            make.centerY.equalTo(self)
            make.right.equalTo(-15)
        }
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        if editing {
            self.deleteButton.isHidden = true
        } else {
            self.deleteButton.isHidden = false
        }
        
    }
    
    @objc func deleteButtonDown() {
        self.delegate?.emoticonCellDeleteButtonDown(cell: self)
    }
    
    func setupInfo() {
        iconImageView.kf.setImage(with: group)
        titleLabel.text = group.name
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
