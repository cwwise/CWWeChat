
//
//  MessageCell+MenuItem.swift
//  Alamofire
//
//  Created by chenwei on 2018/3/15.
//

import UIKit
import ChatClient

public struct MenuAction {
    
    public static let copyItem = UIMenuItem(title: "复制",
                                            action: #selector(MessageCell.copyAction))
    
    public static let transmitItem = UIMenuItem(title: "转发",
                                                action: #selector(MessageCell.transmitAction))
    
    public static let deleteItem = UIMenuItem(title: "删除",
                                              action: #selector(MessageCell.deleteAction))
    
    public static let revokeItem = UIMenuItem(title: "撤销",
                                              action: #selector(MessageCell.revokeAction))
    
    public static var allValues: [Selector] {
        let actionList = [MenuAction.copyItem, MenuAction.transmitItem,
                          MenuAction.deleteItem, MenuAction.revokeItem]
        return actionList.map({ return $0.action })
    }
}

// MARK: - UIMenuController
extension MessageCell {
    public override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if MenuAction.allValues.contains(action) {
            return true
        }
        return false
    }
    
    public override var canBecomeFirstResponder: Bool {
        return true
    }
    
    public override func resignFirstResponder() -> Bool {
        UIMenuController.shared.setMenuVisible(false, animated: true)
        return super.resignFirstResponder()
    }
    
    // MARK: - MenuAction
    @objc func copyAction() {
        guard let message = self.message, message.messageType == .text else {
            return
        }
        let content = message.messageBody as! TextMessageBody
        UIPasteboard.general.string = content.text
    }
    
    @objc func transmitAction() {
        self.delegate?.messageCellFowardAction(self)
    }
    
    @objc func deleteAction() {
        self.delegate?.messageCellDeleteAction(self)
    }
    
    @objc func revokeAction() {
        
    }
}
