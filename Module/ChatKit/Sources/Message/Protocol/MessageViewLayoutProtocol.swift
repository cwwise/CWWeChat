//
//  MessageViewLayoutProtocol.swift
//  ChatKit
//
//  Created by chenwei on 2017/10/13.
//

import Foundation

protocol MessageViewLayoutDelegate: class {
    func collectionView(_ collectionView: UICollectionView, itemAt indexPath: IndexPath) -> MessageModel
}
