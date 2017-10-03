//
//  EFTableViewManager.swift
//  EFTableViewManager
//
//  Created by chenwei on 2017/10/2.
//

import UIKit

public class TableViewManager: NSObject {

    public weak var tableView: UITableView?
    public weak var delegate: TableViewManagerDelegate?
    public weak var dataSource: TableViewManagerDataSource?
    
    public var style: TableViewStyle
    public private(set) var sections: [Section]
    
    /// 初始化方法
    ///
    /// - Parameter tableView: tableView实例
    public init(tableView: UITableView) {
        
        self.sections = [Section]()
        self.tableView = tableView
        self.style = TableViewStyle()

        super.init()
        
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
             
        registerCellClass()
    }
    
    func registerCellClass() {
        tableView?.register(HeaderTitleView.self,
                            forHeaderFooterViewReuseIdentifier: HeaderTitleView.identifier)
        tableView?.register(FooterTitleView.self,
                            forHeaderFooterViewReuseIdentifier: FooterTitleView.identifier)
        
        register(cellClass: MenuCell.self, forCellReuseIdentifier: MenuItem.self)
        register(cellClass: BaseCell.self, forCellReuseIdentifier: Item.self)
        register(cellClass: BoolCell.self, forCellReuseIdentifier: BoolItem.self)
        register(cellClass: ButtonCell.self, forCellReuseIdentifier: ButtonItem.self)
    }
    
    func register(cellClass: Swift.AnyClass, forCellReuseIdentifier itemClass: Swift.AnyClass) {
        tableView?.register(cellClass, forCellReuseIdentifier: String(describing: itemClass))
    }
    
    public func append(_ section: Section) {
        section.tableViewManager = self
        sections.append(section)
    }
    
    // MARK: 操作item
    public func append(itemsOf items: [Item]) {
        let section = Section(items: items)
        self.append(section)
    }
    
    public func append(itemsOf items: Item...) {
        let section = Section(items: items)
        self.append(section)
    }
    
    // MARK: 操作section
    public func append(contentsOf sections: [Section]) {
        for section in sections {
            self.append(section)
        }
    }
    
}

extension TableViewManager: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  sections[section].count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = self.dataSource?.tableView(tableView, cellForRowAt: indexPath) {
            return cell
        }
        
        let item = sections[indexPath.section][indexPath.row]
        let identifier = String(describing: item.classForCoder)        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! BaseCell
        cell.item = item
        cell.cellWillAppear()
        return cell
    }
    
}

extension TableViewManager: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = sections[indexPath.section][indexPath.row]
        return item.cellHeight
    }
    
    // MARK: Header && Footer
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderTitleView.identifier)
        return header
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let section = sections[section]
        return section.headerHeight
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: FooterTitleView.identifier)
        return footer
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let section = sections[section]
        return section.footerHeight
    }
    

}
