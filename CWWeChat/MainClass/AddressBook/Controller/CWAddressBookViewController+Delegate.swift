//
//  CWAddressBookViewController+Delegate.swift
//  CWWeChat
//
//  Created by chenwei on 16/5/29.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

extension CWAddressBookViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: true)
        self.tabBarController?.tabBar.hidden = true
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: true)
        self.tabBarController?.tabBar.hidden = false
    }
    
    func searchBarBookmarkButtonClicked(searchBar: UISearchBar) {
        let message = "语言搜索"
        let alertController = UIAlertController(title: "提示", message: message, preferredStyle: .Alert)
        let alertAtion = UIAlertAction(title: "确定", style: .Default) { (action) in
            
        }
        alertController.addAction(alertAtion)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}
