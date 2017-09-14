//
//  CWTableViewCell.swift
//  CWWeChat
//
//  Created by wei chen on 2017/2/11.
//  Copyright © 2017年 chenwei. All rights reserved.
//

import UIKit
import SnapKit

public protocol CWTableViewCellDelegate: NSObjectProtocol {
    func cellDidSelect()
}

public enum CWCellLineStyle {
    case none
    case `default`
    case fill
}

public class CWTableViewCell: UITableViewCell {
    
    public weak var delegate: CWTableViewCellDelegate?
    public var item: CWTableViewItem!
    
    public var leftSeparatorSpace: CGFloat = 15 {
        didSet {
            self.setNeedsDisplay() 
        }
    }

    public var rightSeparatorSpace: CGFloat = 0 {
        didSet {
            self.setNeedsDisplay() 
        }
    }

    public var topLineStyle: CWCellLineStyle = .none {
        didSet {
            self.setNeedsDisplay()
        }
    }
    public var bottomLineStyle: CWCellLineStyle = .none {
        didSet {
            self.setNeedsDisplay()
        }
    }

    lazy var titleLabel:UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.black
        titleLabel.font = kCWItemTitleFont
        return titleLabel
    }()
        
    lazy var rightLabel:UILabel = {
        let rightLabel = UILabel()
        rightLabel.textColor = UIColor.gray
        rightLabel.font = kCWItemsubTitleFont
        return rightLabel
    }()
    
    lazy var rightImageView:UIImageView = {
        let rightImageView = UIImageView()
        rightImageView.contentMode = .scaleAspectFill
        rightImageView.clipsToBounds = true
        rightImageView.layer.cornerRadius = 5
        return rightImageView
    }()
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(titleLabel)
        
        self.contentView.addSubview(rightLabel)
        self.contentView.addSubview(rightImageView)
        
        _addSnap()
    }
    
    //MARK: 添加约束
    func _addSnap() {
        
        self.titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.contentView)
            make.left.equalTo(self.contentView).offset(kCWCellLeftMargin)
        }
        
        self.rightLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self.contentView)
            make.centerY.equalTo(self.contentView)
            make.left.greaterThanOrEqualTo(self.titleLabel.snp.right).offset(20)
        }
        
        self.rightImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.contentView)
            make.top.equalTo(10)
            make.width.equalTo(self.rightImageView.snp.height)
            make.right.equalTo(self.rightLabel.snp.left).offset(-2)
        }
        
    }
    
    ///设置item对象
    public func cellWillAppear() {

        titleLabel.text = item.title
        rightLabel.text = item.subTitle
        
        if item.showDisclosureIndicator == false {
            self.accessoryType = .none
            self.rightLabel.snp.updateConstraints({ (make) in
                make.right.equalTo(self.contentView).offset(-kCWCellLeftMargin)
            })
        } else {
            self.accessoryType = .disclosureIndicator
            self.rightLabel.snp.updateConstraints({ (make) in
                make.right.equalTo(self.contentView)
            })
        }
        
        rightImageView.kf.setImage(with: item.rightImageURL, placeholder: nil)
        if item.disableHighlight {
            self.selectionStyle = .none
        } else {
            self.selectionStyle = .default
        }
        
    }
    
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        context.setLineWidth(1)
        context.setStrokeColor(UIColor(hex: "#e9e9e9").cgColor)
        
        if self.topLineStyle != .none {
            context.beginPath()
            let startX = self.topLineStyle == .fill ? 0 : leftSeparatorSpace
            let endX = self.width - self.rightSeparatorSpace
            context.move(to: CGPoint(x: startX, y: 0))
            context.addLine(to: CGPoint(x: endX, y: 0))
            context.strokePath()
        }
        
        if self.bottomLineStyle != .none {
            context.beginPath()
            let startX = self.topLineStyle == .fill ? 0 : leftSeparatorSpace
            let endX = self.width - self.rightSeparatorSpace
            context.move(to: CGPoint(x: startX, y: self.height))
            context.addLine(to: CGPoint(x: endX, y: self.height))
            context.strokePath()
        }
        
    }
    
    
}
