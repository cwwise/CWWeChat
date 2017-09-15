//
//  ExpressionService.swift
//  CWWeChat
//
//  Created by chenwei on 2017/8/23.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher
import SwiftyJSON

/** 
 表情部分使用 面馆表情开放平台 https://yun.facehub.me/
 通过tags获取表情部分还是不太会使用
 */

private let parameters = ["app_id": "65737441-7070-6c69-6361-74696f6e4944",
                  "user_id": "01ce1513-370d-41c7-921c-e23e7f6ac86c",
                  "auth_token": "c2ea7be31d68f8ccce05452076630131"]

enum EmoticonRouter: URLRequestConvertible {

    // 表情
    case tagList
    
    case packageList(page: Int, tags: String)
    // 
    case packageDetail(packageId: String)
    // 轮播图
    case recommends
    // 表情详情
    case emoticonsInfo(emoticon_id: String)
    
    static let limit: Int = 8
    static let baseURLString = "https://yun.facehub.me/api/v1"
    
    public func asURLRequest() throws -> URLRequest {
        
        let result: (path: String, parameters: Parameters) = {
            switch self {
            case .tagList:
                var para = parameters
                para["tag_type"] = "custom"
                return ("/tags", para)
            case let .packageList(page, tags):
                var para:[String: Any] = parameters
                para["tags[]"] = tags
                para["page"] = page
                para["limit"] = EmoticonRouter.limit
                return ("/packages", para)
                
            case let .packageDetail(packageId): 
                return ("/packages/\(packageId)", parameters)

            case let .emoticonsInfo(emoticon_id):
                return ("/emoticons/\(emoticon_id)", parameters)
                
            case .recommends:
                return ("/recommends/last", parameters)
            }
            
            
        }()
        
        let url = try EmoticonRouter.baseURLString.asURL()
        let urlRequest = URLRequest(url: url.appendingPathComponent(result.path))
        
        return try URLEncoding.default.encode(urlRequest, with: result.parameters)
    }
}

class EmoticonService {

    public typealias CompleteBlock = ((_ result: [EmoticonPackage], _ success: Bool) -> Void)
    
    public typealias InfoCompleteBlock = ((_ result: EmoticonPackage?, _ success: Bool) -> Void)

    public static let shared = EmoticonService()

    // banner
    func fetchRecommendList(complete: @escaping CompleteBlock) {
        Alamofire.request(EmoticonRouter.recommends).responseJSON { (response) in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                var packageList = [EmoticonPackage]()
                
                for item in json["recommends"].arrayValue {
                    let package = EmoticonPackage(id: item["content"].stringValue,
                                                  name: item["name"].stringValue)
                    package.banner = item["image"]["full_url"].url
                    packageList.append(package)
                }
                complete(packageList, true)
                
            case .failure(_):
                complete([], false)
            }
            
        }
    }
    
    func fetchPackageList(tag: [String], complete: @escaping CompleteBlock) {
        let packageList = EmoticonRouter.packageList(page: 1, tags: tag.first!)
        Alamofire.request(packageList).responseJSON { (response) in
            
            switch response.result {
            case .success(let value):
   
                let json = JSON(value)
                
                var packageList = [EmoticonPackage]()
                let packages = json["packages"].arrayValue
                for item in packages {
                    
                    let package = EmoticonPackage(id: item["id"].stringValue,
                                                  name: item["name"].stringValue)
                    
                    package.subTitle = item["sub_title"].stringValue
                    
                    package.banner = item["background_detail"]["full_url"].url
                    package.cover = item["cover_detail"]["full_url"].url
                    
                    let author = EmoticonPackage.EmoticonAuthor()
                    author.name = item["author"]["name"].stringValue
                    author.avatar = item["author"]["avatar"].url
                    author.banner = item["author"]["banner"].url
                    author.userDescription = item["author"]["description"].stringValue

                    package.author = author
                    
                    packageList.append(package)
                }
                complete(packageList, true)
                
            case .failure(_):
                complete([], false)

            }
            
        }
    }
    

    func fetchPackageDetail(with packageId: String, complete: @escaping InfoCompleteBlock) {
        
        let packageDetail = EmoticonRouter.packageDetail(packageId: packageId)
        Alamofire.request(packageDetail).responseJSON { (response) in
            
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                let package = json["package"]
                let contentsDetail = package["contents_details"]
                let contents = package["contents"].arrayValue
                
                var emoticonList = [Emoticon]()
                for item in contents {
                    
                    let emoticonInfo = contentsDetail[item.stringValue]
                    let size = CGSize(width: emoticonInfo["width"].intValue,
                                      height: emoticonInfo["height"].intValue)
                    let emoticon = Emoticon(id: emoticonInfo["id"].stringValue)
                    emoticon.size = size
                    emoticon.originalUrl = emoticonInfo["full_url"].url
                    emoticon.thumbUrl = emoticonInfo["medium_url"].url
                    if emoticonInfo["format"].string == "gif" {
                        emoticon.format = .gif
                    } else {
                        emoticon.format = .image
                    }
                    
                    let index = emoticon.id.index(emoticon.id.startIndex, offsetBy: 5)
                    
                    let string = String(emoticon.id[..<index])
                    emoticon.title = emoticonInfo["description"].string ?? string
                    
                    emoticonList.append(emoticon)
                }
                
                let emoticonPackage = EmoticonPackage(id: package["id"].stringValue,
                                                      name: package["name"].stringValue)
                emoticonPackage.emoticonList = emoticonList
                emoticonPackage.subTitle = package["sub_title"].stringValue
                
                emoticonPackage.banner = package["background_detail"]["full_url"].url
                emoticonPackage.cover = package["cover_detail"]["full_url"].url
                
                let author = EmoticonPackage.EmoticonAuthor()
                author.name = package["author"]["name"].stringValue
                author.avatar = package["author"]["avatar"].url
                author.banner = package["author"]["banner"].url
                author.userDescription = package["author"]["description"].stringValue
                emoticonPackage.author = author
                
                complete(emoticonPackage, true)
                
            case .failure(_):
                complete(nil, false)
            }
            
        }
        
        
    }
    
    func downloadPackage(with packageId: String, complete: @escaping CompleteBlock) {
        
        fetchPackageDetail(with: packageId) { (package, success) in
            
            if let package = package {
                
                // 获取成功 开始下载图片
                let urls = package.emoticonList.flatMap({ (emoticon) -> URL in
                    return emoticon.originalUrl!
                })
                // 保存到数据库
                self.saveEmoticonPackage(package)
                // 下载图片
                self.downloadResources(urls, id: package.id)
            }
            
        }
    }
    
    func saveEmoticonPackage(_ package: EmoticonPackage) {
        
    }
    
    func downloadResources(_ resources: [URL], id: String) {
        
        let cache = ImageCache(name: id, path: nil)
        let options = KingfisherOptionsInfoItem.targetCache(cache)
        
        let prefetcher = ImagePrefetcher(resources: resources, options: [options], progressBlock: { (skippedResources, failedResources, completedResources) in
            
            log.debug("progress--\(Float(completedResources.count)/Float(resources.count))")
            
        }) { (skippedResources, failedResources, completedResources) in
            
            log.debug("success--\(Float(completedResources.count)/Float(resources.count))")
            
        }
        prefetcher.start()
        
    }
    
}






