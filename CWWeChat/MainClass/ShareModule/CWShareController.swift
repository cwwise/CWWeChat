//
//  CWShareController.swift
//  CWWeChat
//
//  Created by wei chen on 2017/3/30.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class CWShareController: CWBaseTableViewController {

    var shareLayouts = [CWShareLayout]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.title = "分享"
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(CWShareCell.self, forCellReuseIdentifier: CWShareCell.identifier)
        setupUI()
    }
    
    func setupUI() {
        let shareId = "123"
        let username = "陈威"
        let userId = "cwwise"
        let share_Date = Date()
        
        let share = CWShareModel(shareId: shareId,
                                 username: username,
                                 userId: userId,
                                 date: share_Date)
        share.content = "有一天 春花秋月 夏蝉冬雪 不会散去 \n有一天 一关上门 一躺下来 不再离去 \n有一天 爱看的天 爱踏的地 我爱着的你"
        
        for i in 1...5 {
            let url1 = URL(string: "http://image.cwcoder.com/cwwechat00\(i).jpg")!
            let url2 = URL(string: "http://image.cwcoder.com/cwwechat00\(i).jpg?imageView2/1/w/250/h/200/q/75")!

            let imageModel = CWSharePictureModel(thumbnailURL: url2, largetURL: url1)
            share.imageArray.append(imageModel)
        }
        
        let layout = CWShareLayout(shareModel: share)
        shareLayouts.append(layout)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension CWShareController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shareLayouts.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return shareLayouts[indexPath.row].height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CWShareCell.identifier, for: indexPath) as! CWShareCell
        cell.delegate = self
        cell.setLayout(shareLayouts[indexPath.row])
        return cell
    }
    
    
}


extension CWShareController: CWShareCellDelegate {
    func shareCell(_ cell: CWShareCell, didClickImageAtIndex index: Int) {
        log.debug("选择---\(index)")
    }
    
    func shareCell(_ cell: CWShareCell, didClickInText text: NSAttributedString, textRange: NSRange) {
        
    }
}
