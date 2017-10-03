//
//  BaseCell.swift
//  EFTableViewManager
//
//  Created by chenwei on 2017/10/2.
//

import UIKit
import SnapKit

public enum CellSeparatorStyle {
    case none
    case `default`
    case fill
}

public class BaseCell: UITableViewCell {

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
    
    public var topLineStyle: CellSeparatorStyle = .none {
        didSet {
            self.setNeedsDisplay()
        }
    }
    public var bottomLineStyle: CellSeparatorStyle = .none {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.black
        titleLabel.font = kItemTitleFont
        return titleLabel
    }()
    
    lazy var subTitleLabel: UILabel = {
        let subTitleLabel = UILabel()
        subTitleLabel.textColor = UIColor.gray
        subTitleLabel.font = kItemSubTitleFont
        return subTitleLabel
    }()
    

    
    // 靠右边
    lazy var rightLabel:UILabel = {
        let rightLabel = UILabel()
        rightLabel.textColor = UIColor.gray
        rightLabel.font = kItemSubTitleFont
        return rightLabel
    }()
    
    private lazy var rightImageView: UIImageView = {
        let rightImageView = UIImageView()
        return rightImageView
    }()
    
    var item: Item?
        
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(rightLabel)
        self.contentView.addSubview(rightImageView)
        setupSnap()
    }
    
    func cellWillAppear() {
        
        guard let item = item else {
            print("EFTableViewManager cellWillAppear error")
            return
        }
        
        if item.showDisclosureIndicator {
            self.accessoryType = .disclosureIndicator
        } else {
            self.accessoryType = .none
        }
        
        if item.disableHighlight {
            self.selectionStyle = .none
        } else {
            self.selectionStyle = .default
        }
        titleLabel.text = item.title
    }
    
    func setupSnap() {
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.contentView)
            make.left.equalTo(kCellLeftMargin)
            make.right.lessThanOrEqualTo(-kCellLeftMargin)
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    /*
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        let lineWidth = 1/UIScreen.main.scale
        context.setLineWidth(lineWidth)
      //  context.setStrokeColor(UIColor(hex: "#e9e9e9").cgColor)
        
        if self.topLineStyle != .none {
            context.beginPath()
            let startX = self.topLineStyle == .fill ? 0 : leftSeparatorSpace
            let endX = self.bounds.width - self.rightSeparatorSpace
            context.move(to: CGPoint(x: startX, y: 0))
            context.addLine(to: CGPoint(x: endX, y: 0))
            context.strokePath()
        }
        
        if self.bottomLineStyle != .none {
            context.beginPath()
            let startX = self.topLineStyle == .fill ? 0 : leftSeparatorSpace
            let endX = self.bounds.width - self.rightSeparatorSpace
            context.move(to: CGPoint(x: startX, y: self.bounds.height))
            context.addLine(to: CGPoint(x: endX, y: self.bounds.height))
            context.strokePath()
        }
        
    }
     */
}
