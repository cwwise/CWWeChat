//
//  TabelViewManagerProtocol.swift
//  EFTableViewManager
//
//  Created by chenwei on 2017/10/2.
//

import UIKit

public protocol TableViewManagerDelegate: UITableViewDelegate {
    
}

extension TableViewManagerDelegate {
    
}

public protocol TableViewManagerDataSource: NSObjectProtocol {
    func tableViewManager(_ tableViewManager: TableViewManager, cellForRowAt indexPath: IndexPath) -> UITableViewCell?
}

public extension TableViewManagerDataSource {
    func tableViewManager(_ tableViewManager: TableViewManager, cellForRowAt indexPath: IndexPath) -> UITableViewCell? {
        return nil
    }
}
