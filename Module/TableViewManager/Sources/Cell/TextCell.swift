//
//  TextCell.swift
//  EFTableViewManager
//
//  Created by chenwei on 2017/10/2.
//

import UIKit

class TextCell: BaseCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(rightLabel)
    }
    
    override func setupSnap() {
        super.setupSnap()
        rightLabel.snp.makeConstraints { (make) in
            
        }
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
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
