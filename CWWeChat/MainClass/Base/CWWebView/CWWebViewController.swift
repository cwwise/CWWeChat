//
//  CWWebViewController.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/23.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit
import WebKit

private var webViewContentKey = "webViewContentKey"
private var webViewBackgroundColorKey = "webViewBackgroundColorKey"

private let webView_Items_Fixed_Space:CGFloat =  9

/**
 展示网页信息
 */
class CWWebViewController: UIViewController {
    
    ///是否使用网页标题作为nav标题，默认YES
    var usepageTitleAsTitle: Bool = true
    
    ///是否显示加载进度，默认YES
    var showLoadingProgress: Bool = true {
        didSet {
            self.progressView.isHidden = !showLoadingProgress
        }
    }
    
    ///是否禁止历史记录，默认NO
    var disableBackButton: Bool = false
    
    var urlString: String = "" {
        didSet {
            
        }
    }
    
    fileprivate lazy var webView: WKWebView = {
        let configure = WKWebViewConfiguration()
        let frame = CGRect(x: 0, y: Screen_NavigationHeight, width: Screen_Width, height: Screen_Height-Screen_NavigationHeight)
        let webView = WKWebView(frame: frame, configuration: configure)
        webView.allowsBackForwardNavigationGestures = true
        return webView
    }()
    
    fileprivate lazy var progressView: UIProgressView = {
        let frame = CGRect(x: 0, y: Screen_NavigationHeight, width: Screen_Width, height: 10)
        let progressView = UIProgressView(frame: frame)
        progressView.progressTintColor = UIColor.chatSystemColor()
        progressView.trackTintColor = UIColor.clear
        return progressView
    }()
    
    fileprivate lazy var backButtonItem: UIBarButtonItem = {
        let backButtonItem = UIBarButtonItem(backTitle: "返回", target: self, action: #selector(navigationBackButtonDown))
        return backButtonItem
    }()
    
    fileprivate lazy var closeButtonItem: UIBarButtonItem = {
        let closeButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(navigationCloseButtonDown))
        return closeButtonItem
    }()
    
    fileprivate var authLabel: UILabel = {
        let frame = CGRect(x: 20, y: Screen_NavigationHeight+13, width: Screen_Width-2*20, height: 0)
        let authLabel = UILabel(frame: frame)
        authLabel.font = UIFont.systemFont(ofSize: 12)
        authLabel.textAlignment = .center
        authLabel.textColor = UIColor("#6b6f71")
        authLabel.numberOfLines = 1
        return authLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.defaultBlackColor()
        self.view.addSubview(authLabel)
        self.view.addSubview(webView)
        self.view.addSubview(progressView)
        
        webView.navigationDelegate = self
        webView.scrollView.backgroundColor = UIColor.clear
        
        //遍历设置背景颜色
        for subView in webView.scrollView.subviews {
            if "\(subView.classForCoder)" == "WKContentView" {
                subView.backgroundColor = UIColor.white
            }
        }
        
        self.navigationItem.leftBarButtonItems = [backButtonItem]
        
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: &webViewContentKey)
        webView.scrollView.addObserver(self, forKeyPath: "backgroundColor", options: .new, context: &webViewBackgroundColorKey)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.progressView.progress = 0
        let request = URLRequest(url: URL(string: self.urlString)!)
        self.webView.load(request)
    }
    
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if context == &webViewContentKey {
            self.progressView.alpha = 1
            self.progressView.setProgress(Float(webView.estimatedProgress), animated: true)
            
            if self.webView.estimatedProgress >= 1.0 {
                
                UIView.animate(withDuration: 0.3, delay: 0.25, options: UIViewAnimationOptions(), animations: { 
                    self.progressView.alpha = 0
                    }, completion: { (finished) in
                    self.progressView.setProgress(0, animated: false)
                })
                
            }
        }
        
        else if context == &webViewBackgroundColorKey {
            
            let color = change![NSKeyValueChangeKey.newKey] as! UIColor
            if color.cgColor != UIColor.clear.cgColor {
                self.webView.scrollView.backgroundColor = UIColor.clear
            }
        }
        
    }
    
    
    //MARK: 方法
    ///关闭
    func navigationCloseButtonDown() {
       _ = self.navigationController?.popViewController(animated: true)
    }
    
    func navigationBackButtonDown() {
        
        if self.webView.canGoBack {
            self.webView.goBack()
            let spaceItem = UIBarButtonItem.fixBarItemSpaceWidth(webView_Items_Fixed_Space)
            self.navigationItem.leftBarButtonItems = [backButtonItem,spaceItem,closeButtonItem]
            
        } else {
           _ = self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    deinit {
        //直接初始化之后 销毁的话，会出现问题，观察者没有添加 就销魂 会崩溃。待解决
        if urlString != "" {
            self.webView.removeObserver(self, forKeyPath: "estimatedProgress")
            self.webView.scrollView.removeObserver(self, forKeyPath: "backgroundColor")
        }
    }
}

// MARK: - WKNavigationDelegate
extension CWWebViewController: WKNavigationDelegate {
    //完成
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if usepageTitleAsTitle {
            self.title = webView.title
            self.authLabel.text = String(format: "网页由 %@ 提供", (webView.url?.host) ?? "未知网页")
            let size = self.authLabel.sizeThatFits(CGSize(width: self.authLabel.width, height: CGFloat(MAXFLOAT)))
            self.authLabel.height = size.height
        }
   
    }
    
}
