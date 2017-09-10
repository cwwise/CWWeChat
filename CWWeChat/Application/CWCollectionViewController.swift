//
//  CWCollectionViewController.swift
//  CWWeChat
//
//  Created by wei chen on 2017/7/15.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class CWCollectionViewController: UIViewController {

    public var conversation: CWConversation

    convenience public init(targetId: String) {
        let conversation = CWChatClient.share.chatManager.fecthConversation(chatType: .single, targetId: targetId)
        self.init(conversation: conversation)
    }
    
    public init(conversation: CWConversation) {
        self.conversation = conversation
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // 显示时间
    var messageList: [CWMessageModel] = [CWMessageModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(collectionView)
        
        let message = CWMessage(targetId: "hello", text: "测试数据一条")
        let messageModel = CWMessageModel(message: message)
        messageList.append(messageModel)
        
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(sendMessage))
        self.navigationItem.rightBarButtonItem = barButtonItem
        // Do any additional setup after loading the view.
    }
    
    func sendMessage() {
        let message = CWMessage(targetId: "hello", text: "测试数据\(messageList.count)条")
        let messageModel = CWMessageModel(message: message)
        messageList.append(messageModel)

        collectionView.reloadData()
    }
    
    lazy var collectionView: UICollectionView = {
        let frame = self.view.bounds
        let layout = CWMessageViewLayout()
        layout.delegate = self
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.alwaysBounceVertical = true
        collectionView.register(CWBaseMessageCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension CWCollectionViewController: CWMessageViewLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, itemAt indexPath: IndexPath) -> CWMessageModel {
        return messageList[indexPath.row]
    }
}

extension CWCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CWBaseMessageCell
        let message = messageList[indexPath.row]
        cell.refresh(message: message)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
}
