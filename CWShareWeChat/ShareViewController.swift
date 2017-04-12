//
//  ShareViewController.swift
//  CWShareWeChat
//
//  Created by wei chen on 2017/4/12.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import Social
import MobileCoreServices

/*
 修改icon
 http://stackoverflow.com/questions/39001813/how-do-you-provide-an-icon-for-an-action-extension
 **/
class ShareViewController: SLComposeServiceViewController {

    override func isContentValid() -> Bool {
        if self.contentText.characters.count == 0 {
            return false
        }
        return true
    }

    override func didSelectPost() {

        guard let item = self.extensionContext?.inputItems.first as? NSExtensionItem,
            let itemProvider = item.attachments?.first as? NSItemProvider,
            itemProvider.hasItemConformingToTypeIdentifier(kUTTypeURL as String) else {
                return
        }
        
        itemProvider.loadItem(forTypeIdentifier: kUTTypeURL as String, options: nil, completionHandler: { (url, error) in
            self.extensionContext!.completeRequest(returningItems: [], completionHandler: { (result) in

                guard let content = self.contentText, let webURL = url else {
                    return
                }
                print(content)
                print(webURL)
            })
        })
    }
    
    func sendMessage(content: String) {
        
        
        
    }

    override func configurationItems() -> [Any]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return []
    }

}
