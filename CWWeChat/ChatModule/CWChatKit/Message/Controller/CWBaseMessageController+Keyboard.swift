//
//  CWChatMessageController+Keyboard.swift
//  CWWeChat
//
//  Created by wei chen on 2017/4/3.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

// MARK: - Keyboard
///响应KeyBoard事件
extension CWBaseMessageController {
    
    /**
     注册消息观察
     */
    func registerKeyboardNotifacation() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.tableView.addGestureRecognizer(tapGesture)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleWillHideKeyboard(_:)),
                                               name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleWillShowKeyboard(_:)),
                                               name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleWillShowKeyboard(_:)),
                                               name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
    }
    
    
    func hideKeyboard() {
       // self.keyboard.en
    }
    
    ///键盘将要隐藏
    func handleWillHideKeyboard(_ notification: Notification)  {
        keyboardWillShowHide(notification, hideKeyBoard:true)
    }
    
    func keyboardWillChangeFrame(_ notification: Notification) {
        
    }
    
    func handleWillShowKeyboard(_ notification: Notification)  {
        keyboardWillShowHide(notification)
    }
    
    func keyboardWillShowHide(_ notification:Notification, hideKeyBoard: Bool = false) {
        
        let keyboardFrameValue = notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        let keyboardFrame = keyboardFrameValue.cgRectValue
        let curve = (notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).intValue
        let duration = (notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let curveNumber = UIViewAnimationCurve(rawValue:curve)
        
        UIView.animate(withDuration: duration,
                       delay: 0,
                       options: self.animationOptionsForCurve(curveNumber!),
                       animations: {
                        
                        if hideKeyBoard {
                            self.tableView.height = kScreenHeight-kChatToolBarHeight
                            //self.tableView.bottom = self.chatToolBar.top
                        } else {
                            self.tableView.height = kScreenHeight-kChatToolBarHeight-keyboardFrame.height
                            //self.tableView.bottom = self.chatToolBar.top
                        }
                        
        }) { (bool) in
            
            
        }
        
    }
    
    
    func animationOptionsForCurve(_ curve:UIViewAnimationCurve) -> UIViewAnimationOptions {
        
        switch curve {
        case .easeInOut:
            return UIViewAnimationOptions()
        case .easeIn:
            return UIViewAnimationOptions.curveEaseIn
        case .easeOut:
            return UIViewAnimationOptions.curveEaseOut
        case .linear:
            return UIViewAnimationOptions.curveLinear
        }
        
    }
    
}

// 处理键盘事件
// MARK: - KeyboardDelegate
extension CWBaseMessageController {
    
    // 发送图片
    // 主要要考虑的是
    public func sendImageMessage(image: UIImage) {
 
        let imageName = String.UUIDString()+".jpg"
        CWChatKit.share.store(image: image, forKey: imageName)
        // 保存
        let imageBody = CWImageMessageBody(path: imageName, size: image.size)
        let message = CWMessage(targetId: conversation.targetId,
                                direction: .send,
                                messageBody: imageBody)
        self.sendMessage(message)
    }
    
    func sendMessage(_ message: CWMessage) {
        // 添加当前聊天类型
        message.chatType = self.conversation.type
        
        let messageModel = CWChatMessageModel(message: message)
        self.messageList.append(messageModel)
        
        let indexPath = IndexPath(row: self.messageList.count-1, section: 0)
        self.tableView.reloadData()
        updateMessageAndScrollBottom(false)
        
        
        // 发送消息 会先存储消息，然后
        let chatManager = CWChatClient.share.chatManager
        chatManager.sendMessage(message, progress: { (progress) in
            
            messageModel.uploadProgress = progress
            guard let cell = self.tableView.cellForRow(at: indexPath) as? CWMessageCell else {
                return
            }
            cell.updateProgress()
            
        }) { (message, error) in
            
            // 更新消息状态
            let chatManager = CWChatClient.share.chatManager
            chatManager.updateMessage(message, completion: { (message, error) in
                
            })
            
            // 发送消息成功
            if error == nil {
                
            } else {
                
            }
            
            guard let cell = self.tableView.cellForRow(at: indexPath) as? CWMessageCell else {
                return
            }
            cell.updateProgress()
            cell.updateState()
        }
        
    }
    
}

extension CWBaseMessageController: CWChatKeyboardDelegate {
    
    func keyboard(_ keyboard: CWChatKeyboard, sendText text: String) {
        let textObject = CWTextMessageBody(text: text)
        let message = CWMessage(targetId: conversation.targetId,
                                direction: .send,
                                messageBody: textObject)
        self.sendMessage(message)
    }
    
    // 发送表情
    
}

extension CWBaseMessageController: MoreInputViewDelegate {
    func moreInputView(_ inputView: MoreInputView, didSelect item: MoreItem) {
        
        switch item.type {
        case .image:
            let picker = UIImagePickerController()
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
            
        default:
            break
        }
        
        
    }
}


//
extension CWBaseMessageController:UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        sendImageMessage(image: image)
        picker.dismiss(animated: true, completion: nil)
    }
    
}


