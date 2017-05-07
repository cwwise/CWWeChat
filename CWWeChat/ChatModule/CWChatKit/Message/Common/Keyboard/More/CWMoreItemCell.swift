//
//  CWMoreKeyboardCell.swift
//  CWChat
//
//  Created by chenwei on 16/4/6.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit
import SnapKit

protocol CWMoreItemCellDelegate: NSObjectProtocol {
    func moreItemCell(_ cell: CWMoreItemCell, didSelectItem item: CWMoreItem)
}

class CWMoreItemCell: UICollectionViewCell {

    weak var delegate: CWMoreItemCellDelegate?
    
    var item: CWMoreItem? {
        didSet {
            updateInfo()
        }
    }
    
    lazy fileprivate var iconButton:UIButton = {
        let iconButton = UIButton(type: .custom)
        iconButton.backgroundColor = UIColor.white
        iconButton.doCircleRadius(5, borderColor: UIColor(hex: "#D8DBDD"))
        return iconButton
    }()
    
    lazy fileprivate var titleLabel:UILabel = {
       let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 13)
        titleLabel.textColor = UIColor(hex: "#888")
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(self.iconButton)
        addSubview(self.titleLabel)
        addsnap()
    }
    
    func addsnap()  {
        iconButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView)
            make.centerX.equalTo(self.contentView)
            make.size.equalTo(CGSize(width: 60, height: 60))
        }
        
        iconButton.addTarget(self, action: #selector(iconButtonClick), for: .touchUpInside)
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.contentView)
            make.top.equalTo(iconButton.snp.bottom).offset(6)
        }
    }
    
    func iconButtonClick() {
        if let item = self.item {
            self.delegate?.moreItemCell(self, didSelectItem: item)
        }
    }
    
    func updateInfo() {
        
        guard let cellitem = item else {
            iconButton.isHidden = true
            titleLabel.isHidden = true
            return
        }
        
        iconButton.isHidden = false
        titleLabel.isHidden = false
        
        titleLabel.text = cellitem.title
        iconButton.setImage(UIImage(named: cellitem.imagePath), for: UIControlState())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
