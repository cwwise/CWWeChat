//
//  CWDemoViewController.swift
//  CWWeChat
//
//  Created by wei chen on 2017/5/6.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class CWDemoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        let moreView = CWMoreInputView()
        moreView.loadMoreItems(CWMoreInputViewHelper().chatMoreKeyboardData)
        moreView.bottom = self.view.height
        self.view.addSubview(moreView)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
