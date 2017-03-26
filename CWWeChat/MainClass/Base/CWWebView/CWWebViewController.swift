//
//  CWWebViewController.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/23.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit
import WebKit
import KVOController

private var webViewContentKey = "webViewContentKey"
private var webViewBackgroundColorKey = "webViewBackgroundColorKey"

private let webView_Items_Fixed_Space: CGFloat =  9

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
    
    /// url
    var url: URL?
    
    /// WKWebView
    private lazy var webView:WKWebView = {
        let configure = WKWebViewConfiguration()
        let frame = CGRect(x: 0, y: kNavigationBarHeight, width: kScreenWidth, height: kScreenHeight-kNavigationBarHeight)
        let webView = WKWebView(frame: frame, configuration: configure)
        webView.allowsBackForwardNavigationGestures = true
        webView.navigationDelegate = self
        webView.scrollView.backgroundColor = UIColor.clear
        return webView
    }()
    
    /// 展示进度
    private lazy var progressView: UIProgressView = {
        let frame = CGRect(x: 0, y: kNavigationBarHeight, width: kScreenWidth, height: 10)
        let progressView = UIProgressView(frame: frame)
        progressView.progressTintColor = UIColor.chatSystemColor()
        progressView.trackTintColor = UIColor.clear
        return progressView
    }()
    
    private lazy var backButtonItem: UIBarButtonItem = {
        let backButtonItem = UIBarButtonItem(backTitle: "返回", target: self, action: #selector(navigationBackButtonDown))
        return backButtonItem
    }()
    
    private lazy var closeButtonItem: UIBarButtonItem = {
        let closeButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(navigationCloseButtonDown))
        return closeButtonItem
    }()
    
    fileprivate var authLabel: UILabel = {
        let frame = CGRect(x: 20, y: kNavigationBarHeight+13, width: kScreenWidth-2*20, height: 0)
        let authLabel = UILabel(frame: frame)
        authLabel.font = UIFont.systemFont(ofSize: 12)
        authLabel.textAlignment = .center
        authLabel.textColor = UIColor("#6b6f71")
        authLabel.numberOfLines = 1
        return authLabel
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required convenience init(url: URL) {
        self.init()
        self.url = url
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.defaultBlackColor()
        self.view.addSubview(authLabel)
        self.view.addSubview(webView)
        self.view.addSubview(progressView)
        
        self.navigationItem.leftBarButtonItems = [backButtonItem]
        
        //遍历设置背景颜色
        for subView in webView.scrollView.subviews {
            if "\(subView.classForCoder)" == "WKContentView" {
                subView.backgroundColor = UIColor.white
            }
        }

        kvoController.observe(webView, keyPath: "estimatedProgress", options: .new) { (viewController, webView, change) in
            
            self.progressView.alpha = 1
            self.progressView.setProgress(Float(self.webView.estimatedProgress), animated: true)
            
            if self.webView.estimatedProgress >= 1.0 {
                UIView.animate(withDuration: 0.3, delay: 0.25, options: UIViewAnimationOptions(), animations: {
                    self.progressView.alpha = 0
                }, completion: { (finished) in
                    self.progressView.setProgress(0, animated: false)
                })
            }
            
        }
        
        kvoController.observe(webView.scrollView, keyPath: "backgroundColor", options: .new) { (viewController, scrollView, change) in
            let color = change[NSKeyValueChangeKey.newKey.rawValue] as! UIColor
            if color.cgColor != UIColor.clear.cgColor {
                self.webView.scrollView.backgroundColor = UIColor.clear
            }
        }
        
        self.progressView.progress = 0
        
        guard let url = self.url else {
            return
        }
        
        let request = URLRequest(url: url)
        webView.load(request)
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
        log.debug("CWWebViewController 销毁")
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
