//
//  RecordButton.swift
//  Keyboard
//
//  Created by chenwei on 2017/7/22.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import UIKit
import Hue

class RecordButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setTitle("按住     说话", for: UIControlState())
        self.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        //let normalImage = UIImage.size(width: 10, height: 10).color(UIColor(hex: "#F6F6F6")).image
        //self.setBackgroundImage(normalImage, for: .normal)
        self.setTitleColor(UIColor.black, for: UIControlState())
        self.layer.borderColor = UIColor(hex: "#DADADA").cgColor
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 5.0
        self.layer.masksToBounds = true
        
        self.addTarget(self, action: #selector(recordClick(_:)), for: .touchDown)
        self.addTarget(self, action: #selector(recordComplection(_:)), for: .touchUpInside)
        self.addTarget(self, action: #selector(recordCancel(_:)), for: .touchUpOutside)
        
        self.addTarget(self, action: #selector(recordDragOut(_:)), for: .touchDragOutside)
        self.addTarget(self, action: #selector(recordDragIn(_:)), for: .touchDragInside)
        self.addTarget(self, action: #selector(recordDragIn(_:)), for: .touchDragEnter)
        
    }
    
    //MARK: 录音相关的
    @objc func recordCancel(_ button: UIButton) {
        
    }
    
    @objc func recordComplection(_ button: UIButton) {
    }
    
    @objc func recordDragOut(_ button: UIButton) {
    }
    
    @objc func recordDragIn(_ button: UIButton) {
    }
    
    ///录音按钮按下
    @objc func recordClick(_ button: UIButton) {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
