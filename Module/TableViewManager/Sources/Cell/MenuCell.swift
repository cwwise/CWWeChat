//
//  MenuCell.swift
//  TableViewManager
//
//  Created by wei chen on 2017/10/3.
//

import UIKit
import Kingfisher

private let kRedPointWidth: CGFloat = 8.0

class MenuCell: BaseCell {
    
    lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.contentMode = .scaleAspectFill
        iconImageView.clipsToBounds = true
        iconImageView.layer.cornerRadius = 5
        return iconImageView
    }()
    
    private lazy var rightImageView: UIImageView = {
        let rightImageView = UIImageView()
        return rightImageView
    }()
    
    private lazy var redPointView: UIView = {
        let redPointView = UIView()
        redPointView.backgroundColor = UIColor.red
        redPointView.layer.masksToBounds = true
        redPointView.layer.cornerRadius = kRedPointWidth/2
        return redPointView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.accessoryType = .disclosureIndicator
        self.contentView.addSubview(iconImageView)
        self.contentView.addSubview(rightImageView)
        self.contentView.addSubview(redPointView)
        
        p_addSnap()
    }
    
    //MARK: - 添加约束
    func p_addSnap() {
        
        let leftOffset: CGFloat = 15
        let iconImageView_Width: CGFloat = 25
        
        self.iconImageView.snp.makeConstraints { (make) in
            make.left.equalTo(leftOffset)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(iconImageView_Width)
        }
        
        self.titleLabel.snp.remakeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(self.iconImageView.snp.right).offset(leftOffset)
            make.right.lessThanOrEqualTo(-leftOffset)
        }
        
        self.rightImageView.snp.makeConstraints { (make) in
            make.right.equalTo(self.contentView).offset(1)
            make.centerY.equalTo(self.iconImageView)
            make.width.height.equalTo(31)
        }
        
        //红点
        self.redPointView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.rightImageView.snp.right).offset(1)
            make.centerY.equalTo(self.rightImageView.snp.top).offset(1)
            make.width.height.equalTo(kRedPointWidth)
        }
    }
    
    
    override func cellWillAppear() {
        guard let menuItem = item as? MenuItem else {
            return
        }
        
        self.iconImageView.image = UIImage(named: menuItem.iconImageName)
        self.titleLabel.text = menuItem.title
        
        if let rightIconURL = menuItem.rightIconURL {
            let url = URL(string: rightIconURL)
            self.rightImageView.kf.setImage(with: url, placeholder: nil)
            self.rightImageView.isHidden = false
        } else {
            self.rightImageView.isHidden = true
        }
        self.redPointView.isHidden = !menuItem.showRightRedPoint
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
        
    }
}
