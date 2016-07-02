//
//  CWLoginViewController.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/23.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWLoginViewController: UIViewController, CWToastShowProtocol {
    
    lazy var userNameTextField: UITextField = {
        let userNameTextField = UITextField()
        
        userNameTextField.font = UIFont.systemFontOfSize(14)
        userNameTextField.placeholder = "微信号/邮箱地址/QQ号"
        userNameTextField.leftViewMode = .Always
        userNameTextField.keyboardType = .ASCIICapable
        userNameTextField.spellCheckingType = .No
        userNameTextField.delegate = self
        userNameTextField.leftView = self.leftView("帐号")
        return userNameTextField
    }()
    
    lazy var passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        
        passwordTextField.font = UIFont.systemFontOfSize(14)
        passwordTextField.placeholder = "请填写密码"
        passwordTextField.leftViewMode = .Always
        passwordTextField.secureTextEntry = true
        passwordTextField.delegate = self
        passwordTextField.leftView = self.leftView("密码")
        return passwordTextField
    }()
    
    /// 登录按钮
    var loginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.setTitle("登录", forState: .Normal)
        loginButton.commitStyle()
        return loginButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        setupUI()
        // Do any additional setup after loading the view.
    }

    func setupUI() {
        
        let backItem = UIBarButtonItem(title: "取消", style: .Plain, target: self, action: #selector(cancelBarItemAction))
        let dict = [NSFontAttributeName: UIFont.systemFontOfSize(14),
                    NSForegroundColorAttributeName: UIColor.chatSystemColor()]
        backItem.setTitleTextAttributes(dict, forState: .Normal)
        self.navigationItem.leftBarButtonItem = backItem
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)

        //顶部文字
        let label = UILabel()
        label.text = "使用账号和密码登录"
        label.textColor = UIColor.blackColor()
        label.textAlignment = .Center
        label.font = UIFont.systemFontOfSize(19)
        self.view.addSubview(label)
        let margin: CGFloat = 20
        label.snp_makeConstraints { (make) in
            make.left.equalTo(margin)
            make.right.equalTo(-margin)
            make.height.equalTo(30)
            make.top.equalTo(80)
        }
        
        //账号和密码
        self.view.addSubview(userNameTextField)
        userNameTextField.snp_makeConstraints { (make) in
            make.left.equalTo(margin)
            make.right.equalTo(-margin)
            make.height.equalTo(45)
            make.top.equalTo(label.snp_bottom).offset(20)
        }
        
        
        self.view.addSubview(passwordTextField)
        passwordTextField.snp_makeConstraints { (make) in
            make.left.equalTo(margin)
            make.right.equalTo(-margin)
            make.height.equalTo(45)
            make.top.equalTo(userNameTextField.snp_bottom).offset(4)
        }

        //登录按钮
        self.view.addSubview(loginButton)
        loginButton.addTarget(self, action: #selector(CWLoginViewController.loginButtonAction), forControlEvents: .TouchUpInside)
        loginButton.enabled = false
        loginButton.snp_makeConstraints { (make) in
            make.left.equalTo(margin)
            make.right.equalTo(-margin)
            make.height.equalTo(44)
            make.top.equalTo(passwordTextField.snp_bottom).offset(30)
        }
    }
    
    func leftView(text: String) -> UIView {
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 40))
        let textLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        textLabel.text = text
        textLabel.font = UIFont.systemFontOfSize(14)
        textLabel.textColor = UIColor.blackColor()
        leftView.addSubview(textLabel)
        return leftView
    }
    
    
    // MARK: 点击事件
    func cancelBarItemAction() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func loginButtonAction() {
        
        self.view.endEditing(true)

        
        let userName = userNameTextField.text!
        let password = passwordTextField.text!
        
//        self.showToast(.ShowMessage, text: "加载中...")
        if userName == "" || password == "" {
            
        }
        
        let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appdelegate.loginSuccess()
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

extension CWLoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        if string == "" {
            return true
        }
        
        if string.characters.count + (textField.text?.characters.count)! > 25 {
            return false
        }
        
        if passwordTextField.text != "" && userNameTextField.text != "" {
            loginButton.enabled = true
        } else {
            loginButton.enabled = false
        }
        
        
        return true
    }
    
    
}

