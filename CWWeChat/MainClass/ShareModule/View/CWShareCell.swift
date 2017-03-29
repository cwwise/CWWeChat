//
//  CWShareCell.swift
//  CWWeChat
//
//  Created by wei chen on 2017/3/30.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import YYText
import YYWebImage

class CWShareCell: UITableViewCell {

    var avatarView: UIImageView = {
        let avatarView = UIImageView()
        avatarView.size = CGSize(width: 10, height: 10)
        return avatarView
    }()
    var nameLabel: YYLabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
