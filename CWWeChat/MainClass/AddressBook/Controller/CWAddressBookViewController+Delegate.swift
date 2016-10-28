//
//  CWAddressBookViewController+Delegate.swift
//  CWWeChat
//
//  Created by chenwei on 16/5/29.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

extension CWAddressBookViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        UIApplication.shared.setStatusBarStyle(.default, animated: true)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: true)
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
