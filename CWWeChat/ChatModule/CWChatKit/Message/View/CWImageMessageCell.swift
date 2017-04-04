//
//  CWImageMessageCell.swift
//  CWWeChat
//
//  Created by chenwei on 2017/4/4.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class CWImageMessageCell: CWChatMessageCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
        
    override func setup() {
        super.setup()
        addGeneralView()
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
