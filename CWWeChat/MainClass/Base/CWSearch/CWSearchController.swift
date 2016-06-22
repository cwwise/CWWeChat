//
//  CWSearchController.swift
//  CWXMPPChat
//
//  Created by chenwei on 16/5/29.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWSearchController: UISearchController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    var showVoiceButton: Bool = false {
        
        didSet {
            if showVoiceButton {
                self.searchBar.showsBookmarkButton = true
                self.searchBar.setImage(CWAsset.SearchBar_voice.image, forSearchBarIcon: .Bookmark, state: .Normal)
                self.searchBar.setImage(CWAsset.SearchBar_voice_HL.image, forSearchBarIcon: .Bookmark, state: .Highlighted)

            } else {
                self.searchBar.showsBookmarkButton = false
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override init(searchResultsController: UIViewController?) {
        super.init(searchResultsController: searchResultsController)
        
        self.searchBar.barTintColor = UIColor.searchBarTintColor()
        self.searchBar.tintColor = UIColor.chatSystemColor()
        self.searchBar.layer.borderWidth = 0.5
        self.searchBar.layer.borderColor = UIColor.searchBarBorderColor().CGColor
        self.searchBar.sizeToFit()
        
        let searchField = self.searchBar.valueForKey("_searchField")
        searchField?.layer.masksToBounds = true
        searchField?.layer.borderWidth = 0.5
        searchField?.layer.borderColor = UIColor.tableViewCellLineColor().CGColor
        searchField?.layer.cornerRadius = 5.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
