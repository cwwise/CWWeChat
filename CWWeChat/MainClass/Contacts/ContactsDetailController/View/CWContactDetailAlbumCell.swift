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

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.accessoryType = .disclosureIndicator
        self.textLabel?.font = UIFont.systemFont(ofSize: 15)
    }
    
    func setupUI() {
        
        let leftMargin: CGFloat = 90.0
        let spaceX: CGFloat = 10.0
        let spaceY:CGFloat = 10.0

        let imageViewSize = CGSize.zero
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
    
    func setupInfomation() {
        
        let imageURLArray = [
            "http://a.hiphotos.baidu.com/zhidao/pic/item/3ac79f3df8dcdu10002f7c850748b4710b9122f53.jpg",
            "http://img4.duitang.com/uploads/item/201511/17/20151117130657_j3T4s.png",
            "http://img4.duitang.com/uploads/item/201510/16/20151016113134_TZye4.thumb.224_0.jpeg",
            ]

        for i in 0..<imageViewArray.count {
            
            let imageView = imageViewArray[i]
            if i > imageURLArray.count {
                let imageUri = imageURLArray[i]
                let imageURL = URL(string: imageUri)
                imageView.yy_setImage(with: imageURL, placeholder: nil)
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
