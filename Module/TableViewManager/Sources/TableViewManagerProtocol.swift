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
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell?
}

extension TableViewManagerDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell? {
        return nil
    }
}
