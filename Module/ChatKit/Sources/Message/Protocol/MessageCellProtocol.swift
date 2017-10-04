//
//  MessageCellProtocol.swift
//  ChatKit
//
//  Created by chenwei on 2017/10/4.
//

import Foundation

public protocol MessageCellDelegate: class {
    
    /// 点击cell文字中的URL
    ///
    /// - Parameters:
    ///   - cell: cell
    ///   - link: link
    func messageCellDidTap(_ cell: MessageCell, link: URL)
    
    /// 点击cell文字中的电话
    ///
    /// - Parameters:
    ///   - cell: cell
    ///   - phone: phone
    func messageCellDidTap(_ cell: MessageCell, phone: String)
    
    /// cell被点击
    ///
    /// - Parameter cell: cell
    func messageCellDidTap(_ cell: MessageCell)
    
    /// cell 重发按钮点击
    ///
    /// - Parameter cell: cell
    func messageCellResendButtonClick(_ cell: MessageCell)
    
    /// 头像点击的回调方法
    ///
    /// - Parameter userId: 用户id
    func messageCellUserAvatarDidClick(_ userId: String)
    
}

public extension MessageCellDelegate {
    func messageCellDidTap(_ cell: MessageCell, link: URL) {}
    func messageCellDidTap(_ cell: MessageCell, phone: String) {}
    func messageCellDidTap(_ cell: MessageCell) {}
    func messageCellResendButtonClick(_ cell: MessageCell) {}
    func messageCellUserAvatarDidClick(_ userId: String) {}
}


