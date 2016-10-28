//
//  CWContactDetailAlbumCell.swift
//  CWWeChat
//
//  Created by chenwei on 16/7/6.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWContactDetailAlbumCell: UITableViewCell {

    var imageViewsArray = [UIImageView]()
    var infoModel: CWInformationModel? {
        didSet {
            self.setupInfomation()
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.accessoryType = .disclosureIndicator
        self.textLabel?.font = UIFont.systemFont(ofSize: 15)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupInfomation() {
        
        guard let infoModel = infoModel else {
            return
        }
        
        self.textLabel?.text = infoModel.title
        let array = [
            "http://a.hiphotos.baidu.com/zhidao/pic/item/3ac79f3df8dcdu10002f7c850748b4710b9122f53.jpg",
            "http://img4.duitang.com/uploads/item/201511/17/20151117130657_j3T4s.png",
            "http://img4.duitang.com/uploads/item/201510/16/20151016113134_TZye4.thumb.224_0.jpeg",
            ]
        
        let spaceY: CGFloat = 12
        var count = Int((Screen_Width - left_infocell_subTitle_space - 28) / (80 - spaceY * 2 + 3))
        count = array.count <= count ? array.count : count
       
        var spaceX = (Screen_Width - left_infocell_subTitle_space - 28 - CGFloat(count) * (80 - spaceY * 2)) / CGFloat(count)
        spaceX = spaceX > 7 ? 7 : spaceX

        for i in 0..<count {
            let imageString = array[i]
            var imageView: UIImageView?
            
            if imageViewsArray.count <= i {
                imageView = UIImageView()
                imageViewsArray.append(imageView!)
                self.contentView.addSubview(imageView!)
            } else {
                imageView = imageViewsArray[i]
            }
            
            let imageURL = URL(string: imageString)!
            imageView?.yy_setImageWithURL(imageURL, placeholder: nil)
            
            imageView?.snp.makeConstraints(closure: { (make) in
                make.top.equalTo(self.contentView).offset(spaceY);
                make.bottom.equalTo(self.contentView).offset(-spaceY);
                make.width.equalTo(imageView!.snp.height);
                if (i == 0) {
                    make.left.equalTo(left_infocell_subTitle_space);
                }
                else {
                    make.left.equalTo(self.imageViewsArray[i-1].snp.right).offset(spaceX)
                }
            })
            
        }
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
