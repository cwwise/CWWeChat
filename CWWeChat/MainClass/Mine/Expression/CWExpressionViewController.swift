//
//  CWExpressionViewController.swift
//  CWWeChat
//
//  Created by chenwei on 16/7/11.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class CWExpressionViewController: UIViewController {

    var segmentedControl: UISegmentedControl!
        
    var rightBarButtonItem: UIBarButtonItem!
    
    var tableView: UITableView!
    // 
    var bannerList: [EmoticonPackage] = []
    var packageList: [[EmoticonPackage]] = [[]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.setupUI()

        Alamofire.request(EmoticonRouter.tagList).responseJSON { (response) in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
            case .failure(let error):
                print(error)
            }
            
        }
        
//        let packageList = EmoticonRouter.packageList(page: 1, tags: ["精选"])
//        Alamofire.request(packageList).responseJSON { (response) in
//
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)
//                
//                var packageList = [EmoticonPackage]()
//                let packages = json["packages"].arrayValue
//                for item in packages {
//                    
//                    let package = EmoticonPackage(id: item["id"].stringValue,
//                                                  name: item["name"].stringValue)
//                    
//                    package.subTitle = item["sub_title"].stringValue
//                    
//                    package.banner = item["background_detail"]["full_url"].url
//                    package.cover = item["cover_detail"]["full_url"].url
//                    
//                    packageList.append(package)
//                }
//                print(packageList)
//
//            case .failure(let error):
//                print(error)
//            }
//            
//        }
        
//        EmoticonService.shared.downloadPackage(with: "")
        loadRecommends()
        // Do any additional setup after loading the view.
    }
    
    func loadRecommends() {
        Alamofire.request(EmoticonRouter.recommends).responseJSON { (response) in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                var packageList = [EmoticonPackage]()

                for item in json["recommends"].arrayValue {
                    let package = EmoticonPackage(id: item["content"].stringValue,
                                                  name: item["name"].stringValue)
                    package.banner = item["image"]["full_url"].url
                    packageList.append(package)
                }
                self.bannerList = packageList
                self.tableView.reloadData()
            
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    func setupUI() {
        
        tableView = UITableView(frame: self.view.frame, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(EmoticonListHeaderView.self, forHeaderFooterViewReuseIdentifier: "header")
        tableView.register(EmoticonListCell.self, forCellReuseIdentifier: "cell")
        tableView.register(EmoticonListBannerCell.self, forCellReuseIdentifier: "banner")

        self.view.addSubview(tableView)
        
        segmentedControl = UISegmentedControl(items: ["精选表情", "投稿表情"])
        segmentedControl.width = kScreenWidth * 0.55
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedControlChanged(_:)), for: .editingChanged)
        self.navigationItem.titleView = self.segmentedControl
        
        rightBarButtonItem = UIBarButtonItem(image: CWAsset.Nav_setting.image, style: .plain,target: self, action: #selector(rightBarButtonDown))        
        self.navigationItem.rightBarButtonItem = self.rightBarButtonItem

        //模态视图需要添加取消
        if self.navigationController?.viewControllers.first == self {
            let cancleItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(cancelBarButtonDown))
            self.navigationItem.leftBarButtonItem = cancleItem
        }
    }
    
    // MARK: Action
    func cancelBarButtonDown() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func rightBarButtonDown() {
        let myExpression = CWMyExpressionViewController()
        self.navigationController?.pushViewController(myExpression, animated: true)
    }
    
    func segmentedControlChanged(_ segmentedControl: UISegmentedControl)  {
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension CWExpressionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return packageList.count + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return packageList[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "banner", for: indexPath) as! EmoticonListBannerCell
            cell.emoticonList = bannerList
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EmoticonListCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! EmoticonListHeaderView
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 100
        }
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}


