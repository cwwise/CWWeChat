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
    
    var progress: UIProgressView!
    
    var emoticonInfo: EmoticonPackage! {
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
        iconImageView = UIImageView()
        iconImageView.contentMode = .scaleAspectFill
        self.contentView.addSubview(iconImageView)
        
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.textColor = UIColor.black
        self.contentView.addSubview(titleLabel)
        
        subtitleLabel = UILabel()
        subtitleLabel.textColor = UIColor(hex: "#888")
        subtitleLabel.font = UIFont.systemFont(ofSize: 13)
        self.contentView.addSubview(subtitleLabel)
        
        let textColor = UIColor(hex: "#1AAD19")
        let normalImage = UIImage.size(width: 10, height: 10)
            .border(color: textColor)
            .border(width: 1)
            .corner(radius: 5).image.resizableImage()

        downloadButton = UIButton(type: .custom)
        downloadButton.setBackgroundImage(normalImage, for: .normal)
        downloadButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        downloadButton.setTitle("下载", for: .normal)
        downloadButton.setTitleColor(textColor, for: .normal)
        downloadButton.addTarget(self, action: #selector(downloadAction), for: .touchUpInside)
        self.contentView.addSubview(downloadButton)
        
    }
    
    
    func addSnap() {
        
        iconImageView.snp.makeConstraints { (make) in
            make.left.top.equalTo(15)
            make.height.equalTo(iconImageView.snp.width)
            make.centerY.equalTo(self)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconImageView.snp.right).offset(15)
            make.top.equalTo(18)
            make.right.equalTo(-40)
        }
        
        subtitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.right.equalTo(-40)
        }
        

        
        downloadButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(-10)
            make.size.equalTo(CGSize(width: 60, height: 25))
        }
        
    }
    
    func setupInfo()  {
        
        iconImageView.kf.setImage(with: emoticonInfo)
        titleLabel.text = emoticonInfo.name
        subtitleLabel.text = emoticonInfo.subTitle
        
    }

    
    // MARK: Action
    @objc func downloadAction() {
        
        
        
    } 
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
