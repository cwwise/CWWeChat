//
//  CWLoginViewController.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/23.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit
import MBProgressHUD
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func >= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l >= r
  default:
    return !(lhs < rhs)
  }
}


/// 登录界面
class CWLoginViewController: UIViewController, CWToastShowProtocol {
    
    lazy var userNameTextField: UITextField = {
        let userNameTextField = UITextField()
        
        userNameTextField.font = UIFont.systemFont(ofSize: 14)
        userNameTextField.placeholder = "微信号/邮箱地址/QQ号"
        userNameTextField.leftViewMode = .always
        userNameTextField.addTarget(self, action: #selector(textValueChanged(_:)), for: .editingChanged)
        userNameTextField.keyboardType = .asciiCapable
        userNameTextField.spellCheckingType = .no
        userNameTextField.delegate = self
        userNameTextField.leftView = self.leftView("帐号")
        return userNameTextField
    }()
    
    lazy var passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        
        passwordTextField.font = UIFont.systemFont(ofSize: 14)
        passwordTextField.placeholder = "请填写密码"
        passwordTextField.leftViewMode = .always
        passwordTextField.isSecureTextEntry = true
        passwordTextField.delegate = self
        passwordTextField.addTarget(self, action: #selector(textValueChanged(_:)), for: .editingChanged)
        passwordTextField.leftView = self.leftView("密码")
        return passwordTextField
    }()
    
    /// 登录按钮
    var loginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.setTitle("登录", for: UIControlState())
        loginButton.commitStyle()
        return loginButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        setupUI()
        // Do any additional setup after loading the view.
    }

    func setupUI() {
        
        let backItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(cancelBarItemAction))
        let dict = [NSFontAttributeName: UIFont.systemFont(ofSize: 14),
                    NSForegroundColorAttributeName: UIColor.chatSystemColor()]
        backItem.setTitleTextAttributes(dict, for: UIControlState())
        self.navigationItem.leftBarButtonItem = backItem
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)

        //顶部文字
        let label = UILabel()
        label.text = "使用账号和密码登录"
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 19)
        self.view.addSubview(label)
        let margin: CGFloat = 20
        label.snp.makeConstraints { (make) in
            make.left.equalTo(margin)
            make.right.equalTo(-margin)
            make.height.equalTo(30)
            make.top.equalTo(80)
        }
        
        //账号和密码
        self.view.addSubview(userNameTextField)
        userNameTextField.snp.makeConstraints { (make) in
            make.left.equalTo(margin)
            make.right.equalTo(-margin)
            make.height.equalTo(45)
            make.top.equalTo(label.snp.bottom).offset(20)
        }
        
        
        self.view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { (make) in
            make.left.equalTo(margin)
            make.right.equalTo(-margin)
            make.height.equalTo(45)
            make.top.equalTo(userNameTextField.snp.bottom).offset(4)
        }

        //登录按钮
        self.view.addSubview(loginButton)
        loginButton.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
        loginButton.isEnabled = false
        loginButton.snp.makeConstraints { (make) in
            make.left.equalTo(margin)
            make.right.equalTo(-margin)
            make.height.equalTo(44)
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
        }
    }
    
    func leftView(_ text: String) -> UIView {
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 40))
        let textLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        textLabel.text = text
        textLabel.font = UIFont.systemFont(ofSize: 14)
        textLabel.textColor = UIColor.black
        leftView.addSubview(textLabel)
        return leftView
    }
    
    
    // MARK: 点击事件
    func cancelBarItemAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // 模拟的 待添加逻辑
    func loginButtonAction() {
        
        self.view.endEditing(true)

        let userName = userNameTextField.text!
        let password = passwordTextField.text!
        
//        self.showToast(.ShowMessage, text: "加载中...")
        if userName == "" || password == "" {
            
        }
        
        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.mode = .Indeterminate
        hud.labelText = "Loading..."
        DispatchQueue.global(priority: 0).async { 
            sleep(3)
            dispatch_async_safely_to_main_queue({ 
                hud.hide(true)
                let appdelegate = UIApplication.shared.delegate as! AppDelegate
                appdelegate.loginSuccess()
            })
          
        }
    }
    
    func textValueChanged(_ textField: UITextField) {
        let first = judgeTextFieldIsAvailable(userNameTextField)
        let seconde = judgeTextFieldIsAvailable(passwordTextField)
        self.loginButton.isEnabled = first && seconde
    }
    
    func judgeTextFieldIsAvailable(_ textField: UITextField) -> Bool {
        return textField.text?.characters.count >= 6
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string == "" {
            return true
        }
        
        if string.characters.count + (textField.text?.characters.count)! > 25 {
            return false
        }
        
        return true
    }
    
    
}

