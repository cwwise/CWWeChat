//
//  CWMomentDataService.swift
//  CWWeChat
//
//  Created by chenwei on 2017/4/11.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import SwiftyJSON

class CWMomentDataService: NSObject {

    func parseCommentData(_ dict: [String: Any]) {
        let json = JSON(dict)
        guard json["result"].string == "success", 
            let resultArray = json["text"].arrayObject,
            let _ = resultArray as? [[String: String]] else {
            return
        }
    }
    
    
    func parseMomentData() -> [CWMomentLayout] {
        
        var momentLayouts = [CWMomentLayout]()

        guard let path = Bundle.main.path(forResource: "moments", ofType: "json"),
            let momentData = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
                return momentLayouts
        }
        
        guard let momentList = JSON(data: momentData).dictionary?["data"]?.array else {
            return momentLayouts
        }
        
        
        for moment in momentList {
            let momentId = moment["momentId"].stringValue
            let username = moment["username"].stringValue
            let userId = moment["userId"].stringValue
            let date = moment["date"].doubleValue
            let type = CWMomentType(rawValue: moment["type"].intValue) ?? .normal

            let content = moment["content"].string
            let share_Date = Date(timeIntervalSince1970: date/1000)
            let momentModel = CWMoment(momentId: momentId,
                                      username: username,
                                      userId: userId,
                                      date: share_Date)
            momentModel.content = content
            momentModel.type = type
            
            let items = moment["images"].arrayValue
            for item in items {
                let url1 = URL(string: item["largetURL"].stringValue)!
                let url2 = URL(string: item["thumbnailURL"].stringValue)!
                let size = CGSize(width: item["width"].intValue, height: item["height"].intValue)
                
                let imageModel = CWMomentPhoto(thumbnailURL: url2, largetURL: url1, size: size)
                momentModel.imageArray.append(imageModel)
            }
            
            if let news = moment["news"].dictionary {
                
                let url = news["url"]?.stringValue
                let imageUrl = news["imageurl"]?.stringValue
                let title = news["title"]?.stringValue
                let source = news["source"]?.stringValue

                let newsurl = URL(string: url!)!
                let newsImageUrl = URL(string: imageUrl!)!

                let urlModel = CWMultimedia(url: newsurl, 
                                            imageURL: newsImageUrl,
                                            title: title!, source: source)
                momentModel.multimedia = urlModel
            }
                        
            let layout = CWMomentLayout(moment: momentModel)
            momentLayouts.append(layout)
            
        }
        return momentLayouts
    }
    
    
    
}
