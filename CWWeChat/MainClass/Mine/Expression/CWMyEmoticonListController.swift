//
//  CWMyEmoticonListController.swift
//  CWWeChat
//
//  Created by chenwei on 16/7/11.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

/// 我的表情
class CWMyEmoticonListController: CWBaseTableViewController {

    var sortBarButtonItem: UIBarButtonItem!
    var doneBarButtonItem: UIBarButtonItem!

    var emoticonList = [EmoticonPackage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "我的表情"
        setupUI()

        let tag2 = "二次元"
        EmoticonService.shared.fetchPackageList(tag: [tag2]) { (list, success) in
            if success {
                self.emoticonList.append(contentsOf: list)
                self.tableView.reloadData()
            }
        }
    }
    
    func setupUI() {
        
        sortBarButtonItem = UIBarButtonItem(title: "排序", style: .plain,target: self, action: #selector(rightBarButtonDown))
        doneBarButtonItem = UIBarButtonItem(title: "完成", style: .plain,target: self, action: #selector(rightBarButtonDown))

        self.navigationItem.rightBarButtonItem = sortBarButtonItem
        
        self.view.backgroundColor = UIColor.white
        //模态视图需要添加取消
        if self.navigationController?.viewControllers.first == self {
            let cancleItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(cancelBarButtonDown))
            self.navigationItem.leftBarButtonItem = cancleItem
        }
        
        self.tableView.rowHeight = 50
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(MyEmoticonCell.self, forCellReuseIdentifier: "cell")
    }
    
    
    @objc func cancelBarButtonDown() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func rightBarButtonDown() {

        let isEditing = self.tableView.isEditing
        
        if isEditing == false {
            self.navigationItem.rightBarButtonItem = sortBarButtonItem
            self.tableView.setEditing(true, animated: true)
        } else {
            self.tableView.setEditing(false, animated: true)
            self.navigationItem.rightBarButtonItem = doneBarButtonItem
        }
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension CWMyEmoticonListController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emoticonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyEmoticonCell
        cell.group = emoticonList[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
                
        let controller = CWEmoticonDetailController()
        controller.emoticonPackage = emoticonList[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {

        let emoticon = emoticonList.remove(at: sourceIndexPath.row)
        emoticonList.insert(emoticon, at: destinationIndexPath.row)
        
    }
    
}

extension CWMyEmoticonListController: MyEmoticonCellDelegate {
    func emoticonCellDeleteButtonDown(cell: MyEmoticonCell) {
        guard let indexPath = self.tableView.indexPath(for: cell) else {
            return
        }
        
        self.emoticonList.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .fade)
    }
}

