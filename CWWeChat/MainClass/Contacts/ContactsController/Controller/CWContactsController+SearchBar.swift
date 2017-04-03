//
//  CWContactsController+SearchBar.swift
//  CWWeChat
//
//  Created by wei chen on 2017/4/3.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

extension CWContactsController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        let message = "语言搜索"
        let alertController = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        let alertAtion = UIAlertAction(title: "确定", style: .default) { (action) in
            
        }
        alertController.addAction(alertAtion)
        self.present(alertController, animated: true, completion: nil)
    }
}
