//
//  Bundle+Extension.swift
//  ChatKit
//
//  Created by wei chen on 2017/10/6.
//

import Foundation

extension Bundle {
    
    static func chatKitAssetBundle() -> Bundle {
        
        let podBundle = Bundle(for: ChatKit.self)
        
        guard let resourceBundleUrl = podBundle.url(forResource: "ChatKitAssets", withExtension: "bundle") else {
            fatalError("chatKit: Could not create path to the assets bundle")
        }
        
        guard let resourceBundle = Bundle(url: resourceBundleUrl) else {
            fatalError("chatKit: Could not load the assets bundle")
        }
        
        return resourceBundle
    }
    
}
