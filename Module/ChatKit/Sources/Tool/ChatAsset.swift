//
//  ChatAsset.swift
//  Pods
//
//  Created by wei chen on 2017/10/22.
//

import Foundation
import UIKit

enum ChatAsset: String {

    case defaultHeadImage = "defaultHeadImage"
    
    var image: UIImage? {
        let bundle = kChatKitAssetBundle
        let image = UIImage(named: "ChatKitAssets.bundle/\(self.rawValue)", in: bundle, compatibleWith: nil)
        if image == nil {
            print("图片资源不存在:\(self.rawValue)")
        }
        return image
    }
}

