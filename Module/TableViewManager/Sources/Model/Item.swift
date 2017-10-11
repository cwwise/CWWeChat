//
//  Item.swift
//  EFTableViewManager
//
//  Created by chenwei on 2017/10/2.
//

import Foundation

public typealias SelectionHandler = (Item) -> ()

public protocol Row: NSObjectProtocol {
    
    weak var section: Section? {get set}
 
    var title: String {set get}

    var cellHeight: CGFloat {get set}
    
    var showDisclosureIndicator: Bool {get set}
    
    var disableHighlight: Bool {get set}
    
    var indexPath: IndexPath? { get }
}

public class Item: NSObject, Row {
    /// section
    public weak var section: Section?
    ///  文本
    public var title: String
    ///
    public var subTitle: String?
    ///  cell高度 默认49
    public var cellHeight: CGFloat = kDefaultItemCellHeight
    ///  是否显示
    public var showDisclosureIndicator: Bool = true
    ///  是否不高亮
    public var disableHighlight: Bool = false
    ///  点击事件回调
    public var selectionAction: SelectionHandler?
    ///  indexPath
    public var indexPath: IndexPath? {
        guard let index = section?.items.index(of: self),
            let sectionIndex = section?.index else {
                return nil
        }
        return IndexPath(row: index, section: sectionIndex)
    }
    
    public init(title: String, subTitle: String? = nil, selectionAction: SelectionHandler? = nil) {
        self.title = title
        self.subTitle = subTitle
        self.selectionAction = selectionAction
    }
}



