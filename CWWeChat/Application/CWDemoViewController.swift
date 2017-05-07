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
        
      
        let keyboard = CWChatKeyboard()
        self.view.addSubview(keyboard)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        self.view.endEditing(true)
        print("ceshi123")
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
