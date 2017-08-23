//
//  EmoticonListCell.swift
//  CWWeChat
//
//  Created by chenwei on 2017/8/23.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class EmoticonListCell: UITableViewCell {

    var iconImageView: UIImageView!
    
    var titleLabel: UILabel!

    var subtitleLabel: UILabel!

    var downloadButton: UIButton!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
        addSnap()
    }
    
    func setupUI() {
        iconImageView = UIImageView()
        iconImageView.contentMode = .scaleAspectFill
        self.contentView.addSubview(iconImageView)
        
        titleLabel = UILabel()
        titleLabel.textColor = UIColor.black
        self.contentView.addSubview(titleLabel)
        
        subtitleLabel = UILabel()
        subtitleLabel.textColor = UIColor.gray
        self.contentView.addSubview(subtitleLabel)
        
        downloadButton = UIButton()
        downloadButton.addTarget(self, action: #selector(downloadAction), for: .touchUpInside)
        self.contentView.addSubview(downloadButton)
    }
    
    
    func addSnap() {
        
        iconImageView.snp.makeConstraints { (make) in
            
        }
        
        titleLabel.snp.makeConstraints { (make) in
            
        }
        
        subtitleLabel.snp.makeConstraints { (make) in
            
        }
        
        downloadButton.snp.makeConstraints { (make) in
            
        }
        
    }
    

    
    // MARK: Action
    func downloadAction() {
        
        
        
    } 
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
