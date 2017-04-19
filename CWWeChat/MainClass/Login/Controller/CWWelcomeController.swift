 //
//  CWWelcomeController.swift
//  CWWeChat
//
//  Created by chenwei on 2017/4/19.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class CWWelcomeController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
  
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        backgroundImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        let loginController = CWLoginController()
        self.navigationController?.pushViewController(loginController, animated: true)
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
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
