//
//  CWTableViewManager.swift
//  CWWeChat
//
//  Created by wei chen on 2017/2/11.
//  Copyright © 2017年 chenwei. All rights reserved.
//

import UIKit

/// table 管理的
//  主要用来 创建统一的设置界面
//  参考 https://github.com/romaonthego/RETableViewManager 根据自己的项目进行简化
class CWTableViewManager: NSObject {

    var tableView: UITableView
    
    var sections: [CWTableViewSection]
    
    
    /// 初始化方法
    ///
    /// - Parameter tableView: tableView实例
    init(tableView: UITableView) {
        
        self.sections = [CWTableViewSection]()
        self.tableView = tableView

        super.init()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
    }
    
    
    func registerCell() {
        
        tableView.register(CWTableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    
    
    
}


// MARK: UITableViewDataSource
extension CWTableViewManager: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "")!
        return cell;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    

}

// MARK: UITableViewDelegate
extension CWTableViewManager: UITableViewDelegate {
    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //默认取消选中
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
}


