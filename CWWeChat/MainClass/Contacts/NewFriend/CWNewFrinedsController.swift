//
//  NewFrinedsController.swift
//  CWWeChat
//
//  Created by chenwei on 2017/4/8.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import RxSwift

class CWNewFrinedsController: CWBaseTableViewController {

    
    var friendInviteList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "新的朋友"
        
    
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(CWNewFriendCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension CWNewFrinedsController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return friendInviteList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CWNewFriendCell
        
        return cell
    }
    
}

