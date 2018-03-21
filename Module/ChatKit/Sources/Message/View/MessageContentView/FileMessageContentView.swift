//
//  FileMessageContentView.swift
//  ChatKit
//
//  Created by chenwei on 2018/3/21.
//

import UIKit
import ChatClient

class FileMessageContentView: MessageContentView {
    
    // 文件名
    private lazy var fileNameLabel: UILabel = {
        let fileNameLabel           = UILabel()
        fileNameLabel.textColor     = UIColor.mainText
        fileNameLabel.font          = UIFont.boldSystemFont(ofSize: 13.0)
        return fileNameLabel
    }()
    
    /// 文件大小
    private lazy var fileSizeLabel: UILabel = {
        let fileSizeLabel       = UILabel()
        fileSizeLabel.textColor = UIColor.mainText
        fileSizeLabel.font      = UIFont.systemFont(ofSize: 12.0)
        return fileSizeLabel
    }()
    
    private lazy var fileIconImageView: UIImageView = {
        let fileIconImageView = UIImageView()
        return fileIconImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.menuItems = [MenuAction.deleteItem]
        self.addSubview(fileNameLabel)
        self.addSubview(fileSizeLabel)
        self.addSubview(fileIconImageView)
        
        setLayoutViews()
    }
    
    override func refresh(message: MessageModel) {
        super.refresh(message: message)
        let body = message.messageBody as! FileMessageBody
        setDataFromBody(body: body, message: message)
    }
    
    func setDataFromBody(body: FileMessageBody, message: MessageModel) {
        
        fileNameLabel.text = body.displayName
        fileSizeLabel.text = String(format: "%.2fK", body.fileLength/1024)
        
        if message.isSend {
            fileNameLabel.textColor = UIColor.white
            fileSizeLabel.textColor = UIColor.white
        } else {
            fileNameLabel.textColor = UIColor.mainText
            fileSizeLabel.textColor = UIColor.mainText
        }
        
    }
    
    func setLayoutViews() {
        fileIconImageView.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 53/2, height: 65/2))
        }
        fileNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(fileIconImageView.snp.right).offset(15)
            make.right.equalTo(-20)
            make.centerY.equalTo(self.snp.centerY).offset(-10)
        }
        fileSizeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(fileIconImageView.snp.right).offset(15)
            make.centerY.equalTo(self.snp.centerY).offset(10)
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
