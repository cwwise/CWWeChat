//
//  CWMomentController.swift
//  CWWeChat
//
//  Created by wei chen on 2017/3/30.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import SwiftyJSON

class CWMomentController: CWBaseTableViewController {

    var shareLayouts = [CWMomentLayout]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.title = "分享"
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let frame = CGRect(x: 0, y: 0, width: kScreenWidth, height:  512/2+50)
        self.tableView.tableHeaderView =  CWMomentHeaderView(frame: frame)
        self.tableView.register(CWMomentCell.self, forCellReuseIdentifier: CWMomentCell.identifier)
        setupUI()
    }
    
    func setupUI() {
        
        let dataService = CWMomentDataService()
        
        shareLayouts = dataService.parseMomentData()
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension CWMomentController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shareLayouts.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return shareLayouts[indexPath.row].height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CWMomentCell.identifier, for: indexPath) as! CWMomentCell
        cell.delegate = self
        cell.setLayout(shareLayouts[indexPath.row])
        return cell
    }
    
    
}


extension CWMomentController: CWMomentCellDelegate {
    func shareCell(_ cell: CWMomentCell, didClickImageAtIndex index: Int) {
        log.debug("选择---\(index)")
    }
    
    func shareCell(_ cell: CWMomentCell, didClickInText text: NSAttributedString, textRange: NSRange) {
        
    }
}
