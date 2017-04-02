//
//  CWInformationButtonCell.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/28.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

protocol CWInformationButtonCellDelegate: NSObjectProtocol {
    func informationButtonCellClicked(_ info: CWInformationModel)
}

class CWInformationButtonCell: UITableViewCell {

    weak var delegate: CWInformationButtonCellDelegate?
    
    var informationModel: CWInformationModel? {
        didSet {
            self.setupInfo()
        }
    }
    
    lazy var button: UIButton = {
       let button = UIButton(type: .custom)
        button.commitStyle()
        button.addTarget(self, action: #selector(CWInformationButtonCell.cellButtonDown(_:)), for: .touchUpInside)
        return button
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(button)
        p_addSnap()
    }
    
    func p_addSnap() {
        self.button.snp.makeConstraints { (make) in
            make.centerX.top.equalTo(self.contentView)
            make.width.equalTo(self.contentView).multipliedBy(0.92)
            make.height.equalTo(self.contentView).multipliedBy(0.78)
        }
    }
    
    func setupInfo() {
        guard let informationModel = informationModel else {
            return
        }
        
        self.button.setTitle(informationModel.title, for: UIControlState())
        self.accessoryType = .none
        self.selectionStyle = .none
    }
    
    func cellButtonDown(_ button: UIButton) {
        if let delegate = self.delegate {
            delegate.informationButtonCellClicked(self.informationModel!)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
