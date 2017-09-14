//
//  CWTableViewManager.swift
//  CWWeChat
//
//  Created by wei chen on 2017/2/11.
//  Copyright © 2017年 chenwei. All rights reserved.
//

import UIKit

public protocol CWTableViewManagerDelegate: UITableViewDelegate {
    
}

public protocol CWTableViewManagerDataSource: NSObjectProtocol {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell?
}

extension CWTableViewManagerDelegate {
    
}

extension CWTableViewManagerDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell? {
        return nil
    }
}


/// table 管理的
//  主要用来 创建统一的设置界面
//  参考 https://github.com/romaonthego/RETableViewManager 根据自己的项目进行简化
public class CWTableViewManager: NSObject {

    public weak var tableView: UITableView?
    public weak var delegate: CWTableViewManagerDelegate?
    public weak var dataSource: CWTableViewManagerDataSource?

    public var style: CWTableViewStyle?
    public private(set) var sections: [CWTableViewSection]
    
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
        tableView?.register(CWTableHeaderTitleView.self,
                                forHeaderFooterViewReuseIdentifier: CWTableHeaderTitleView.identifier)
        tableView?.register(CWTableFooterTitleView.self,
                                forHeaderFooterViewReuseIdentifier: CWTableFooterTitleView.identifier)
        
        self.register(cellClass: CWTableViewCell.self, forCellReuseIdentifier: CWTableViewItem.self)
        self.register(cellClass: CWTableViewBoolCell.self, forCellReuseIdentifier: CWBoolItem.self)
        self.register(cellClass: CWTableViewButtonCell.self, forCellReuseIdentifier: CWButtonItem.self)

    }
    
    func register(cellClass: Swift.AnyClass, forCellReuseIdentifier itemClass: Swift.AnyClass) {
        self.tableView?.register(cellClass, forCellReuseIdentifier: String(describing: itemClass))
    }
    
    func identifierForCell(at indexPath: IndexPath) -> String {
        let item = sections[indexPath.section][indexPath.row]
        return String(describing: item.classForCoder)
    }
    
    // MARK: 操作item
    public func addSection(itemsOf items: [CWTableViewItem]) {
        let section = CWTableViewSection(items: items)
        self.addSection(section)
    }
    
    // MARK: 操作section
    public func addSection(contentsOf sections: [CWTableViewSection]) {
        for section in sections {
            self.addSection(section)
        }
    }
    
    public func addSection(_ section: CWTableViewSection) {
        section.tableViewManager = self
        sections.append(section)
    }

}


// MARK: UITableViewDataSource
extension CWTableViewManager: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = self.dataSource?.tableView(tableView, cellForRowAt: indexPath) {
            return cell
        }
        
        let identifier = identifierForCell(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! CWTableViewCell
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
        
        // 不明白 为什么需要添加？
        delegate?.tableView?(tableView, didSelectRowAt: indexPath)
    }
    
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if let cellHeight = delegate?.tableView?(tableView, heightForRowAt: indexPath) {
            return cellHeight
        }
        
        let item = sections[indexPath.section][indexPath.row]
        return item.cellHeight
    }
    
    // MARK: header and footreView
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return sections[section].footerHeight
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sections[section].headerHeight
    }

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerTitle = sections[section].headerTitle  else {
            return nil
        }
        
        let headerTitleView = tableView.dequeueReusableHeaderFooterView(withIdentifier: CWTableHeaderTitleView.identifier) as! CWTableHeaderTitleView
        headerTitleView.text = headerTitle
        return headerTitleView
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footerTitle = sections[section].footerTitle  else {
            return nil
        }
        
        let footerTitleView = tableView.dequeueReusableHeaderFooterView(withIdentifier: CWTableFooterTitleView.identifier) as! CWTableFooterTitleView
        footerTitleView.text = footerTitle
        return footerTitleView
    }
    
}


