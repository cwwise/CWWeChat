//
//  NSFileManager+ChatExtension.swift
//  CWWeChat
//
//  Created by chenwei on 16/4/6.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import Foundation
import UIKit

extension NSFileManager {
    
    class func saveContentImage(image: UIImage?,imagePath path:String) {
        guard let image = image where NSFileManager.defaultManager().fileExistsAtPath(path) == false else {
            return
        }
        var data = UIImageJPEGRepresentation(image, 1)
        if data == nil {
            data = UIImagePNGRepresentation(image)
        }
        if NSFileManager.defaultManager().createFileAtPath(path, contents: data, attributes: nil) {
            print("保存图片成功----")
        }
    }
}

