//
//  CWMyExpressionCell.swift
//  CWWeChat
//
//  Created by chenwei on 16/7/11.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

protocol CWMyExpressionCellDelegate: class{
    func expressionCellDeleteButtonDown()
}

class CWMyExpressionCell: UITableViewCell {

    var group: CWEmoticonGroup? {
        didSet {
            setupInfo()
        }
    }
    
    var delegate: CWMyExpressionCellDelegate?
    
    var deleteButton: UIButton = {
        let deleteButton = UIButton(type: .custom)
        deleteButton.frame = CGRect(x: 0, y: 0, width: 50, height: 30)
        deleteButton.setTitle("移除", for: UIControlState())
        deleteButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        return deleteButton
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryView = self.deleteButton
    }
    
    func setupInfo() {
        guard let group = group else {
            return
        }
        self.textLabel?.text = group.groupName
        self.imageView?.image = UIImage(named: group.groupIcon)

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
