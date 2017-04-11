//
//  CWShareDataService.swift
//  CWWeChat
//
//  Created by chenwei on 2017/4/11.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import SwiftyJSON

class CWShareDataService: NSObject {
    
    func testData() {
        
        
    }
    
    func parseCommentData(_ dict: [String: Any]) {
        let json = JSON(dict)
        guard json["result"].string == "success", 
            let resultArray = json["text"].arrayObject,
            let _ = resultArray as? [[String: String]] else {
            return
        }
        
 
        
        
    }
    
}
