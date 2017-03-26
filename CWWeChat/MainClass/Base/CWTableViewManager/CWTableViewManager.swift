//
//  CWTableViewManager.swift
//  CWWeChat
//
//  Created by wei chen on 2017/2/11.
//  Copyright © 2017年 chenwei. All rights reserved.
//

import UIKit

@objc public protocol CWTableViewManagerDelegate: UITableViewDelegate {
    
}

/// table 管理的
//  主要用来 创建统一的设置界面
//  参考 https://github.com/romaonthego/RETableViewManager 根据自己的项目进行简化
public class CWTableViewManager: NSObject {

    public weak var tableView: UITableView?
    public weak var delegate: CWTableViewManagerDelegate?
    
    var sections: [CWTableViewSection]
    
    /// 初始化方法
    ///
    /// - Parameter tableView: tableView实例
    init(tableView: UITableView) {
        
        self.sections = [CWTableViewSection]()
        self.tableView = tableView

        super.init()
        
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        
        registerCellClass()
    }
    
    
    func registerCellClass() {
        self.register(cellClass: CWTableViewCell.self, forCellReuseIdentifier: CWTableViewItem.self)
    }
    
    func register(cellClass: Swift.AnyClass, forCellReuseIdentifier itemClass: Swift.AnyClass) {
        self.tableView?.register(cellClass, forCellReuseIdentifier: String(describing: itemClass))
    }
    
    func identifierForCell(at indexPath: IndexPath) -> String {
        let item = sections[indexPath.section][indexPath.row]
        return String(describing: item.classForCoder)
    }
    
    
    // 操作section
    public func addSection(section: CWTableViewSection) {
        sections.append(section)
    }
    
    public func addSection(contentsOf sections: [CWTableViewSection]) {
        self.sections.append(contentsOf: sections)
    }

}


// MARK: UITableViewDataSource
extension CWTableViewManager: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = identifierForCell(at: indexPath)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! CWTableViewCell
        cell.item = sections[indexPath.section][indexPath.row]
        
        cell.cellWillAppear()
        
        return cell;
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }

}

// MARK: UITableViewDelegate
extension CWTableViewManager: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //默认取消选中
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = sections[indexPath.section][indexPath.row]
        if let selectionAction = item.selectionAction {
            selectionAction(item)
        }
        
        // 可选直接使用？ 不需要
        self.delegate?.tableView?(tableView, didSelectRowAt: indexPath)
    }
    
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = sections[indexPath.section][indexPath.row]
        return CGFloat(item.cellHeight)
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return sections[section].footerHeight
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sections[section].headerHeight
    }
    
}


