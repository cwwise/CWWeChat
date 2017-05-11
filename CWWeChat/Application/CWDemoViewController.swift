//
//  CWDemoViewController.swift
//  CWWeChat
//
//  Created by wei chen on 2017/5/6.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import SwiftyJSON

class CWDemoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        guard let emoticonPath = Bundle.main.path(forResource: "Emotion", ofType: "bundle"),
        let emoticonBundle = Bundle(path: emoticonPath),
            let plist = emoticonBundle.path(forResource: "emotions", ofType: "plist"),
            let array = NSArray(contentsOfFile: plist) else {
                return
        }
        
        var groups = [CWEmoticonGroup]()

        let json = JSON(array)
        for groupInfo in json.arrayValue {
            
            let type = groupInfo["type"].stringValue
            let groupId = groupInfo["groupid"].stringValue
            let groupName = groupInfo["groupname"].stringValue
            let groupicon = groupInfo["groupicon"].stringValue
            
            var emoticons = [CWEmoticon]()
            
            let items = groupInfo["items"].arrayValue
            for item in items {
                
                if type == "image" {
                    let emoticon = CWEmoticon(chs: item["text"].stringValue,
                                              png: item["image"].stringValue)
                    emoticons.append(emoticon)
                }
                
            }
            
            if type == "expression" {
                break
            }
            
            let group = CWEmoticonGroup(groupID: groupId,
                                        groupName: groupName,
                                        groupIcon: groupicon,
                                        emoticons: emoticons)
            groups.append(group)
        }
        
        let keyboard = CWChatKeyboard()
        keyboard.emoticonInputView.setupGroup(groups)
        self.view.addSubview(keyboard)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        self.view.endEditing(true)
        print("ceshi123")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
