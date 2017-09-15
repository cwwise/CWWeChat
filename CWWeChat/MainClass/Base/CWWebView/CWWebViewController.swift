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
import CWShareView

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
        authLabel.textColor = UIColor(hex: "#6b6f71")
        authLabel.numberOfLines = 1
        return authLabel
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required convenience init(url: URL?) {
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
        
        let barItemImage = UIImage(named: "barbuttonicon_more")
        let rightBarItem = UIBarButtonItem(image: barItemImage, style: .done, target: self, action: #selector(rightBarItemClick))
        self.navigationItem.rightBarButtonItem = rightBarItem

        //遍历设置背景颜色
        for subView in webView.scrollView.subviews {
            if "\(subView.classForCoder)" == "WKContentView" {
                subView.backgroundColor = UIColor.white
            }
        }

        weak var weak_self = self
        kvoController.observe(webView, keyPath: "estimatedProgress", options: .new) { (viewController, webView, change) in
            
            guard let strong_self = weak_self else { return }
            
            strong_self.progressView.alpha = 1
            strong_self.progressView.setProgress(Float(strong_self.webView.estimatedProgress), animated: true)
            
            if strong_self.webView.estimatedProgress >= 1.0 {
                UIView.animate(withDuration: 0.3, delay: 0.25, options: UIViewAnimationOptions(), animations: {
                    strong_self.progressView.alpha = 0
                }, completion: { (finished) in
                    strong_self.progressView.setProgress(0, animated: false)
                })
            }
            
        }
        
        kvoController.observe(webView.scrollView, keyPath: "backgroundColor", options: .new) { (viewController, scrollView, change) in
            
            guard let strong_self = weak_self else { return }

            let color = change[NSKeyValueChangeKey.newKey.rawValue] as! UIColor
            if color.cgColor != UIColor.clear.cgColor {
                strong_self.webView.scrollView.backgroundColor = UIColor.clear
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
    @objc func navigationCloseButtonDown() {
       _ = self.navigationController?.popViewController(animated: true)
    }
    
    @objc func navigationBackButtonDown() {
        
        if self.webView.canGoBack {
            self.webView.goBack()
            let spaceItem = UIBarButtonItem.fixBarItemSpaceWidth(webView_Items_Fixed_Space)
            self.navigationItem.leftBarButtonItems = [backButtonItem,spaceItem,closeButtonItem]
            
        } else {
           _ = self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    @objc func rightBarItemClick() {

        var shareList1: [ShareItem] = []

        let shareItem1_1 = ShareItem(title: "发送给朋友", icon: #imageLiteral(resourceName: "Action_Share"))
        let shareItem1_2 = ShareItem(title: "分享到朋友圈", icon: #imageLiteral(resourceName: "Action_Moments"))
        let shareItem1_3 = ShareItem(title: "收藏", icon: #imageLiteral(resourceName: "Action_MyFavAdd"))
        let shareItem1_4 = ShareItem(title: "在Safari中打开", icon: #imageLiteral(resourceName: "Action_Safari"))
        let shareItem1_5 = ShareItem(title: "分享到新浪", icon: #imageLiteral(resourceName: "Action_Sina"))
        let shareItem1_6 = ShareItem(title: "分享到QQ", icon: #imageLiteral(resourceName: "Action_QQ"))
        let shareItem1_7 = ShareItem(title: "分享到QQ空间", icon: #imageLiteral(resourceName: "Action_qzone"))
        let shareItem1_8 = ShareItem(title: "分享到Facebook", icon: #imageLiteral(resourceName: "Action_facebook"))
        
        shareList1.append(contentsOf: [shareItem1_1, shareItem1_2, shareItem1_3, shareItem1_4,
                                       shareItem1_5, shareItem1_6, shareItem1_7, shareItem1_8])
        
        var shareList2: [ShareItem] = []

        let shareItem2_1 = ShareItem(title: "查看公众号", icon: #imageLiteral(resourceName: "Action_Verified"))
        let shareItem2_2 = ShareItem(title: "复制链接", icon: #imageLiteral(resourceName: "Action_Copy"))
        let shareItem2_3 = ShareItem(title: "调整字体", icon: #imageLiteral(resourceName: "Action_Font"))
        let shareItem2_4 = ShareItem(title: "刷新", icon: #imageLiteral(resourceName: "Action_Refresh"))
        
        shareList2.append(contentsOf: [shareItem2_1, shareItem2_2, shareItem2_3, shareItem2_4])
        
        let clickedHandler = { (shareView: ShareView, indexPath: IndexPath) in
            print(indexPath.section, indexPath.row)
        }
        
        let title = "网页由mp.weixin.qq.com提供"
        let shareView = ShareView(title: title,
                                  shareItems: [shareList1, shareList2], 
                                  clickedHandler: clickedHandler)        
        shareView.show()
        
    }
    
    deinit {
        log.debug("\(self.classForCoder) 销毁")
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
