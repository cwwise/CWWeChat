//
//  TextItem.swift
//  EFTableViewManager
//
//  Created by chenwei on 2017/10/2.
//

import Foundation

public class TextItem: Item {
    
    var subTitle: String?
    
    var detailTitle: String?
    
    public init(title: String, subTitle: String?, detailTitle:String?, selectionAction: SelectionHandler? = nil) {
        self.subTitle = subTitle
        self.detailTitle = detailTitle
        super.init(title: title, selectionAction: selectionAction)
    }
    
}
