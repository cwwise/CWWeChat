//
//  CWContactDetailAlbumCell.swift
//  CWWeChat
//
//  Created by wei chen on 2017/4/3.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class CWContactDetailAlbumCell: UITableViewCell {

    var imageViewArray = [UIImageView]()
    
    lazy var titleLabel:UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "个人相册"
        titleLabel.font = kCWItemTitleFont
        return titleLabel
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.accessoryType = .disclosureIndicator
        
        self.contentView.addSubview(titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.contentView)
            make.left.equalTo(self.contentView).offset(kCWCellLeftMargin)
        }
        setupUI()
    }
    
    func setupUI() {
        
        let leftMargin: CGFloat = 90.0
        let spaceX: CGFloat = 7
        let spaceY:CGFloat = 15.0

        let imageViewSize = CGSize(width: 57, height: 57)
        let maxCount = 4
        
        for i in 0..<maxCount {
            let imageView = UIImageView()
            let point = CGPoint(x: leftMargin + (spaceX+imageViewSize.width)*CGFloat(i),
                                y: spaceY)
            imageView.size = imageViewSize
            imageView.origin = point
            
            imageView.isHidden = true
            imageViewArray.append(imageView)
            self.contentView.addSubview(imageView)
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupInformation()
    }
    
    func setupInformation() {
        
        let imageURLArray = [
            "http://qiniu.cwwise.com/cwwechat008.jpg",
            "http://qiniu.cwwise.com/cwwechat009.jpg",
            "http://qiniu.cwwise.com/cwwechat010.jpg",]

        for i in 0..<imageViewArray.count {
            
            let imageView = imageViewArray[i]
            if i < imageURLArray.count {
                let imageUri = imageURLArray[i]
                imageView.kf.setImage(with: URL(string: imageUri), placeholder: nil)
                imageView.isHidden = false
            } else {
                imageView.isHidden = true
            }
            
        }
        
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
