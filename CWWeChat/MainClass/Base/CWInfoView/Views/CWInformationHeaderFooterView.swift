//
//  CWInformationHeaderFooterView.swift
//  CWWeChat
//
//  Created by chenwei on 16/7/6.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWInformationHeaderFooterView: UITableViewHeaderFooterView {

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.tableViewBackgroundColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
