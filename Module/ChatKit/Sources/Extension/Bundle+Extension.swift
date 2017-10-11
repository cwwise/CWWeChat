//
//  Bundle+Extension.swift
//  ChatKit
//
//  Created by wei chen on 2017/10/6.
//

import Foundation

extension Bundle {
    
    static func messageKitAssetBundle() -> Bundle {
        let podBundle = Bundle(for: MessageController.self)
        
        guard let resourceBundleUrl = podBundle.url(forResource: "MessageKitAssets", withExtension: "bundle") else {
            fatalError("MessageKit: Could not create path to the assets bundle")
        }
        
        guard let resourceBundle = Bundle(url: resourceBundleUrl) else {
            fatalError("MessageKit: Could not load the assets bundle")
        }
        
        return resourceBundle
    }
    
}
