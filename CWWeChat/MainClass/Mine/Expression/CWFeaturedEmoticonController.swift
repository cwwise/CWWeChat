//
//  CWFeaturedEmoticonController.swift
//  CWWeChat
//
//  Created by chenwei on 2017/8/24.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

/// 精选表情
class CWFeaturedEmoticonController: UIViewController {
    
    var tableView: UITableView!
    
    lazy var searchController: CWSearchController = {
        let searchController = CWSearchController(searchResultsController: self.searchResultController)
        searchController.searchResultsUpdater = self.searchResultController
        searchController.searchBar.placeholder = "搜索"
        searchController.searchBar.delegate = self
        searchController.showVoiceButton = true
        return searchController
    }()
    
    //搜索结果
    var searchResultController: CWSearchResultController = {
        let searchResultController = CWSearchResultController()
        return searchResultController
    }()
    
    // 
    var bannerList: [EmoticonPackage] = []
    var packageList: [EmoticonZone] = []
    
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
        
        // banner
        EmoticonService.shared.fetchRecommendList { (list, success) in
            if success {
                self.bannerList = list
                self.tableView.reloadData()
            }
        }
        let tag1 = "热门表情"
        EmoticonService.shared.fetchPackageList(tag: [tag1]) { (list, success) in
            if success {
                let zone = EmoticonZone(name: tag1, packageList: list)
                self.packageList.insert(zone, at: 0)
                self.tableView.reloadData()
            }
        }
        
        let tag2 = "二次元"
        EmoticonService.shared.fetchPackageList(tag: [tag2]) { (list, success) in
            if success {
                let zone = EmoticonZone(name: tag1, packageList: list)
                self.packageList.append(zone)
                self.tableView.reloadData()
            }
        }
        
    }
    
    func setupUI() {
        let frame = CGRect(x: 0, y: kNavigationBarHeight, 
                           width: kScreenWidth, height: kScreenHeight-kNavigationBarHeight)
        
        tableView = UITableView(frame: frame, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(EmoticonListHeaderView.self, forHeaderFooterViewReuseIdentifier: "header")
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "footer")

        tableView.register(EmoticonListCell.self, forCellReuseIdentifier: "cell")
        tableView.register(EmoticonListBannerCell.self, forCellReuseIdentifier: "banner")
        tableView.tableHeaderView = self.searchController.searchBar
        tableView.tableFooterView = UIView()
        self.view.addSubview(tableView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension CWFeaturedEmoticonController: UISearchBarDelegate {
    
    
}

extension CWFeaturedEmoticonController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return packageList.count + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return packageList[section-1].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "banner", for: indexPath) as! EmoticonListBannerCell
            cell.emoticonList = bannerList
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EmoticonListCell
        cell.emoticonInfo = packageList[indexPath.section-1][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! EmoticonListHeaderView
        header.titleLabel.text = packageList[section-1].name
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: "footer")
        return footer
    }
        
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 150
        }
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let package = packageList[indexPath.section-1][indexPath.row]
        
        let controller = CWEmoticonDetailController()
        controller.emoticonPackage = package
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}
