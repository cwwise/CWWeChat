//
//  ButtonItem.swift
//  EFTableViewManager
//
//  Created by chenwei on 2017/10/2.
//

import UIKit

public class ButtonItem: Item {

    public init(title: String, selectionAction: SelectionHandler?) {
        super.init(title: title, selectionAction: selectionAction)
        self.disableHighlight = true
    }

}
