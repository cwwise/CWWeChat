//
//  BoolItem.swift
//  EFTableViewManager
//
//  Created by chenwei on 2017/10/2.
//

import Foundation

public class BoolItem: Item {

    public var value: Bool
    
    public var switchChangeHandler: SelectionHandler?
    
    public init(title: String, value: Bool = false, switchChangeHandler: @escaping SelectionHandler) {
        self.value = value
        self.switchChangeHandler = switchChangeHandler
        super.init(title: title)
        self.disableHighlight = true
    }
    
}
